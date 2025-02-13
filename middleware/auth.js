import jwt from 'jsonwebtoken';
import asyncHandler from 'express-async-handler';
import User from '../models/user.model.js'; // Adjust the path as necessary
import dotenv from 'dotenv';

dotenv.config();

const protect = asyncHandler(async (req, res, next) => {
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    try {
      token = req.headers.authorization.split(' ')[1];
      const secret = process.env.SECRET_KEY; 
      const decoded = jwt.verify(token, secret);
      // Valid token
      req.user = await User.findById(decoded.id).select('-password');

      next();
    } catch (error) {
      res.status(401).json({ error: 'Not authorized' });
    }
  }

  if (!token) {
    res.status(401).json({ error: 'Token not found' });
  }
});

export { protect }; // Use named export