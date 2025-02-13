import Post from '../models/Post.model.js'; // Adjust the path as necessary
import User from '../models/user.model.js';
import Profile from '../models/Profile.js';

// Create a new post
import { v4 as uuidv4 } from 'uuid'; // Import uuid for generating unique IDs

// Create a new post
export const createPost = async (req, res) => {
    const { content, imageUrl, visibility } = req.body;
  
    let newId;
    let postExists = true;
  
    // Generate a unique ID and check if it already exists
    while (postExists) {
      newId = uuidv4();
      const existingPost = await Post.findOne({ id: newId });
      postExists = existingPost !== null; // If an existing post is found, regenerate ID
    }
  
    const newPost = new Post({
      id: newId, // Use the unique ID
      userId: req.user._id, // Use the user ID from the authenticated request
      content,
      imageUrl,
      visibility,
    });
  
    try {
      const post = await newPost.save();
      res.status(201).json(post);
    } catch (error) {
      res.status(500).json({ message: 'Error creating post', error });
    }
  };

// Update a post
export const updatePost = async (req, res) => {
  const { postId } = req.params;
  const { content, imageUrl, visibility } = req.body;

  try {
    const post = await Post.findById(postId);
    if (!post) return res.status(404).json({ message: 'Post not found' });
    if (post.userId.toString() !== req.user._id.toString()) return res.status(403).json({ message: 'Forbidden' });

    post.content = content || post.content;
    post.imageUrl = imageUrl || post.imageUrl;
    post.visibility = visibility || post.visibility;
    post.updatedAt = Date.now();

    await post.save();
    res.json(post);
  } catch (error) {
    res.status(500).json({ message: 'Error updating post', error });
  }
};

// Delete a post
export const deletePost = async (req, res) => {
  const { postId } = req.params;

  try {
    const post = await Post.findById(postId);
    if (!post) return res.status(404).json({ message: 'Post not found' });
    if (post.userId.toString() !== req.user._id.toString()) return res.status(403).json({ message: 'Forbidden' });

    await post.remove();
    res.status(204).send(); // No content
  } catch (error) {
    res.status(500).json({ message: 'Error deleting post', error });
  }
};

// Get a specific post by ID if it's public
export const getPost = async (req, res) => {
    const { postId } = req.params;

    try {
        // Find the post by ID and populate the userId field to get user details
        const post = await Post.findById(postId).populate('userId');

        if (!post) return res.status(404).json({ message: 'Post not found' });
        if (post.visibility !== 'public') return res.status(403).json({ message: 'Forbidden: Post is not public' });

        // Fetch the user's profile picture based on userId from the Profile model
        const userProfile = await Profile.findOne({ userId: post.userId._id });

        // Construct the user info object
        const userInfo = {
            firstname: post.userId.firstname,
            lastname: post.userId.lastname,
            profilePicture: userProfile ? userProfile.profilePicture : null, // Get profile picture
        };

        // Return the post along with the user info
        res.json({
            post,
            userInfo
        });
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving post', error });
    }
};

// Get all public posts
export const getAllPublicPosts = async (req, res) => {
  try {
    const posts = await Post.find({ visibility: 'public' });
    res.json(posts);
  } catch (error) {
    res.status(500).json({ message: 'Error retrieving posts', error });
  }
};


export const likePost = async (req, res) => {
    const { postId } = req.params;
    const userId = req.user._id; // The user ID from the authenticated request
  
    try {
      const post = await Post.findById(postId);
      if (!post) return res.status(404).json({ message: 'Post not found' });
  
      // Check if the user already liked the post
      const likeIndex = post.likes.findIndex(like => like.userId.toString() === userId.toString());
  
      if (likeIndex !== -1) {
        // User has already liked the post, so we will remove the like
        post.likes.splice(likeIndex, 1); // Remove the like
      } else {
        // User has not liked the post, so we will add a like
        post.likes.push({ userId, content: 1, createdAt: Date.now() });
      }
  
      await post.save();
      
      // Send back the updated post or a success message
      res.status(200).json({ message: 'Post like status updated successfully', post });
    } catch (error) {
      res.status(500).json({ message: 'Error updating like status', error });
    }
  };



  // Add a comment to a post
export const addComment = async (req, res) => {
    const { postId } = req.params;
    const { content } = req.body; // Comment content
  
    try {
      const post = await Post.findById(postId);
      if (!post) return res.status(404).json({ message: 'Post not found' });
  
      // Create a new comment object
      const comment = {
        userId: req.user._id, // The ID of the user making the comment
        content,
        createdAt: Date.now(),
      };
  
      // Add the comment to the post's comments array
      post.comments.push(comment);
      await post.save();
  
      res.status(201).json({ message: 'Comment added successfully', post });
    } catch (error) {
      res.status(500).json({ message: 'Error adding comment', error });
    }
  };