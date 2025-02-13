import jwt from "jsonwebtoken";
import  asyncHandler from   "express-async-handler" ;
import UserModel from '../models/user.model.js ';

// export const verifyToken = (req, res, next) => {
// 	const token = req.cookies.token; // ezih garn generateToken yemilew page ley res.cookie("token", token, nameun  "token" slaln nw ezih gar req.cookies.token; token yalnew 
// 	// const { token } = req.params;
// 	console.log("Error in verifyToken ", token);
// 	if (!token) return res.status(401).json({ success: false, message: "Unauthorized - no token provided" });
// 	try {
// 		const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY);

// 		if (!decoded) return res.status(401).json({ success: false, message: "Unauthorized - invalid token" });

// 		req.userId = decoded.userId;
// 		next(); // yhen mn malet nw kelay yalewn function run adrgo kecherese buhala router.get("/check-auth", verifyToken, checkAuth); checkAuth wede milew route hid maletu nw
// 	} catch (error) {
// 		console.log("Error in verifyToken ", error);
// 		return res.status(500).json({ success: false, message: "Server error" });
// 	}
// };

// const jwt = require("jsonwebtoken");
// const asyncHandler = require("express-async-handler");
// const User = require("../models/user.");
// require('dotenv').config();


export const verifyToken = asyncHandler(async (req, res, next) => {
	let token;
	if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
	  token = req.headers.authorization.split(" ")[1];
	}
  
	if (!token) {
	  return res.status(401).json({ error: "Token not found" });
	}
  
	try {
	  const secret = "secret_key";
	  const decoded = jwt.verify(token, secret);
	  req.userId = decoded.id; // Store user ID for subsequent use
	  req.user = await UserModel.findById(req.userId).select("-password");
	  next();
	} catch (error) {
	  res.status(401).json({ error: "Not authorized" });
	}
  });

