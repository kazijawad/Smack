import mongoose from 'mongoose';
import passportLocalMongoose from 'passport-local-mongoose';

const Schema = mongoose.Schema;
const Account = new Schema({
    email: String,
    password: String,
});

Account.plugin(passportLocalMongoose);
module.exports = mongoose.model('Account', Account);
