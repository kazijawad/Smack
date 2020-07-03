import mongoose from 'mongoose';
const Schema = mongoose.Schema;

const userSchema = new Schema({
    name: String,
    email: String,
    avatarName: String,
    avatarColor: String,
    default: '',
});

module.exports = mongoose.model('User', userSchema);
