import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const channelSchema = new Schema({
    name: String,
    description: String,
    default: '',
});

module.exports = mongoose.model('Channel', channelSchema);
