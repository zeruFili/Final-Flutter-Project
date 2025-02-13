import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    firstname: {
        type: String,
        required: true,
        trim: true
    },
    lastname: {
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
    // phone_number: {
    //     type: String,
    //     required: true,
    //     unique: true,
    //     trim: true
    // },
    password: {
        type: String,
        required: true,
        minlength: 6 // Minimum password length
    },
    birthday: {
        type: Date,
        required: true
    },
    gender: {
        type: String,
        enum: ['male', 'female'],
        required: true
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});

// Create and export the User model
const UserModel = mongoose.model('User', userSchema);
export default UserModel;