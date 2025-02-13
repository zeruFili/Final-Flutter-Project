import jwt from 'jsonwebtoken';
import nodemailer from 'nodemailer';
import bcrypt from 'bcrypt';
import { generateTokenAndSetCookie } from "../utils/generateTokenAndSetCookie.js";
import UserModel from '../models/user.model.js';

import dotenv from 'dotenv';
dotenv.config();




export const register = async (req, res) => {
    const { firstname, lastname, email, password, birthday, gender } = req.body;

    try {
        const existingUser = await UserModel.findOne({ email });
        if (existingUser) {
            return res.status(400).send({ Status: "User already exists" });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new UserModel({ firstname, lastname, email, password: hashedPassword, birthday, gender });
        await newUser.save();

        res.status(201).send({ Status: "User registered successfully" });
    } catch (error) {
        console.error("Registration error:", error);
        res.status(500).send({ Status: "Internal Server Error" });
    }
};

export const sendResetPasswordEmail = async (req, res) => {
    const { email } = req.body;

    try {
        const user = await UserModel.findOne({ email });
        if (!user) {
            return res.status(404).send({ Status: "User not found" });
        }

        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET_KEY, { expiresIn: "1d" });
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL, // Use environment variables for sensitive info
                pass: process.env.EMAIL_PASSWORD // Use environment variables for sensitive info
            }
        });

        const mailOptions = {
            from: process.env.EMAIL,
            to: email,
            subject: 'Reset Password Link',
            text: `http://localhost:5173/reset_password/${user._id}/${token}`
        };

        await transporter.sendMail(mailOptions);
        return res.send({ Status: "Success" });

    } catch (error) {
        console.error("Error:", error);
        return res.status(500).send({ Status: "Internal Server Error" });
    }
};

export const resetPassword = async (req, res) => {
    const { id, token } = req.params;
    const { password } = req.body;

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);

        const hash = await bcrypt.hash(password, 10);
        const user = await UserModel.findByIdAndUpdate(id, { password: hash }, { new: true });

        if (!user) {
            return res.status(404).send({ Status: "User not found" });
        }
        return res.send({ Status: "Success" });

    } catch (error) {
        if (error instanceof jwt.JsonWebTokenError) {
            return res.status(401).send({ Status: "Invalid or expired token" });
        }
        console.error("Error:", error);
        return res.status(500).send({ Status: "Internal Server Error" });
    }
};

export const login = async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await UserModel.findOne({ email });
        if (!user) {
            return res.status(404).send({ Status: "User not found" });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).send({ Status: "Invalid credentials" });
        }
        console.log("JWT_SECRET_KEY:", process.env.JWT_SECRET_KEY); 

        generateTokenAndSetCookie(res, user._id);
        const token = jwt.sign({ id: user._id },  "secret_key", { expiresIn: "1d" });

        return res.status(200).send({
            Status: "Login successful",
            token,
            user: {
                id: user._id,
                firstname: user.firstname,
                lastname: user.lastname,
                email: user.email
            }
        });

    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).send({ Status: "Internal Server Error" });
    }
};

export const checkAuth = async (req, res) => {
    try {
        const user = req.user; // Use req.user from token verification
        if (!user) {
            return res.status(400).json({ success: false, message: "User not found" });
        }

        res.status(200).json({ success: true, user });
    } catch (error) {
        console.log("Error in checkAuth ", error);
        res.status(400).json({ success: false, message: error.message });
    }
};