import mongoose from 'mongoose';

const profileSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  profilePicture: { type: String, required: false },
  coverPhoto: { type: String, required: false },
  avatar: { type: String, required: false },
  bio: { type: String, required: false },
  currentCity: { type: String, required: false },
  workplace: { type: String, required: false },
  school: { type: String, required: false },
  hometown: { type: String, required: false },
  relationshipStatus: { type: String, required: false },
});

const Profile = mongoose.model('Profile', profileSchema);

export default Profile;