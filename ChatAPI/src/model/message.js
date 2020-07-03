import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const ObjectId = mongoose.Schema.Types.ObjectId;

const messageSchema = new Schema({
    messageBody: String,
    timeStamp: { type: Date, default: Date.now },
    userId: { type: ObjectId, ref: 'User' },
    channelId: { type: ObjectId, ref: 'Channel' },
    userName: String,
    userAvatar: String,
    userAvatarColor: String,
    default: '',
});

module.exports = mongoose.model('Message', messageSchema);
