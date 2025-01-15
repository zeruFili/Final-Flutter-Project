import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true
    },
    password: {
        type: String,
        required: true,
        minlength: 6 // Minimum password length
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});

// Create and export the User model
const UserModel = mongoose.model('User', userSchema);
export default UserModel;