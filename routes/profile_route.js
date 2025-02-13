import express from 'express';
import { verifyToken } from "../middleware/verifyToken.js";
import { createProfile, getProfile, getProfilePicture, updateProfile, deleteProfile } from '../controllers/profile.controller.js';

const router = express.Router();

router.post('/', verifyToken, createProfile);
router.get('/', verifyToken, getProfile); // No userId parameter needed
router.get('/profile-picture', verifyToken, getProfilePicture);
router.put('/', verifyToken, updateProfile);
router.delete('/', verifyToken, deleteProfile);

export default router;