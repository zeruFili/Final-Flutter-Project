import express from "express";
import mongoose from "mongoose";
import cookieParser from "cookie-parser"; // Ensure cookie-parser is imported
import cors from "cors"; // Ensure cors is imported
import authroute from './routes/auth_route.js';
import postroute from './routes/post_route.js';
import profileroute from './routes/profile_route.js';
import dotenv from 'dotenv';

// Load environment variables from .env file
dotenv.config();

const app = express();

// Middleware
app.use(cookieParser());

app.use(express.json()); // Middleware for JSON data

app.use(cors()); 

app.get("/", (req, res) => {
    res.send("hello world");
});

app.use("/api/auth", authroute); // Set up auth routes
app.use("/api/post", postroute);
app.use("/api/profile", profileroute);

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/authf') // Consider using localhost
  .then(() => {
    console.log('Connected to MongoDB');
    
    // Start the server only after a successful database connection
    app.listen(3000, () => {
        console.log("Server is running on port 3000");
    });
  })
  .catch((error) => {
    console.error('Error connecting to MongoDB', error);
  });