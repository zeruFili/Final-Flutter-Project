import Profile from '../models/Profile.js';


// Create a new profile

// Create a new profile
export const createProfile = async (req, res) => {
  try {
    const profile = new Profile({ ...req.body, userId: req.userId });
    await profile.save();
    res.status(201).json(profile);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Get a profile by User ID from token
export const getProfile = async (req, res) => {
  try {
    const profile = await Profile.findOne({ userId: req.userId });
    if (!profile) {
      return res.status(404).json({ message: 'Profile not found' });
    }
    res.json(profile);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get only the profile picture by User ID from token
export const getProfilePicture = async (req, res) => {
  try {
    const profile = await Profile.findOne({ userId: req.userId }).select('profilePicture');
    if (!profile) {
      return res.status(404).json({ message: 'Profile not found' });
    }
    res.json({ profilePicture: profile.profilePicture });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update a profile
export const updateProfile = async (req, res) => {
  try {
    const profile = await Profile.findOneAndUpdate({ userId: req.userId }, req.body, { new: true });
    if (!profile) {
      return res.status(404).json({ message: 'Profile not found' });
    }
    res.json(profile);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Delete a profile
export const deleteProfile = async (req, res) => {
  try {
    const profile = await Profile.findOneAndDelete({ userId: req.userId });
    if (!profile) {
      return res.status(404).json({ message: 'Profile not found' });
    }
    res.json({ message: 'Profile deleted' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};