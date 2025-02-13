import mongoose from 'mongoose';

const postSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId, // Reference to the user who created the post
    required: true,
    ref: 'User',
  },
  content: {
    type: String,
    required: true,
  },
  imageUrl: {
    type: String,
    default: null, // Optional image URL
  },
  createdAt: {
    type: Date,
    default: Date.now, // Automatically set to now
  },
  updatedAt: {
    type: Date,
    default: Date.now, // Automatically set to now
  },
  likes: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId, // Reference to the user who liked the post
      ref: 'User',
    },
    content: {
      type: Number,
      default: 0,
    },
    createdAt: {
      type: Date,
      default: Date.now, // Timestamp for when the like was made
    },
  }],
  comments: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    },
    content: {
      type: String,
      required: true,
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
  }],
  visibility: {
    type: String,
    enum: ['public', 'friends', 'private'], // Post visibility options
    default: 'public',
  },
});

const Post = mongoose.model('Post', postSchema);

export default Post; // Use ES6 export