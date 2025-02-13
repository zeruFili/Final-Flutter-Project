import express from 'express';
import { createPost, updatePost, deletePost, getPost, getAllPublicPosts , likePost , addComment } from '../controllers/post.controller.js'; // Importing controller functions
import { protect } from '../middleware/auth.js'; // Importing middleware
import { verifyToken } from "../middleware/verifyToken.js";

const router = express.Router();

// Create a new post
router.post('/', verifyToken, createPost);

// Update a post
router.put('/:postId', verifyToken, updatePost);

// Delete a post
router.delete('/:postId', verifyToken, deletePost);

// Get a specific post
router.get('/:postId', getPost);
// Like a post (this will also handle unliking)
router.post('/:postId/like', verifyToken, likePost);

// Get all public posts
router.get('/public', getAllPublicPosts);

// Additional routes can be added here if needed
// router.get("/", (req, res) => {
//     res.send("Welcome to the posts API");
// });


// Add a comment to a post
router.post('/:postId/comment', verifyToken, addComment);

export default router;