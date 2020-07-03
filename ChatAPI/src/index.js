import http from 'http';
import express from 'express';
import bodyParser from 'body-parser';
import passport from 'passport';
import socket from 'socket.io';

import Message from './model/message';
import Channel from './model/channel';
import config from './config';
import routes from './routes';

const Account = require('./model/account');
const LocalStrategy = require('passport-local').Strategy;

const app = express();
app.server = http.createServer(app);

const io = socket(app.server);

app.use(bodyParser.json({ limit: config.bodyLimit }));
app.use(passport.initialize());

passport.use(new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
}, Account.authenticate()));

passport.serializeUser(Account.serializeUser());
passport.deserializeUser(Account.deserializeUser());

app.use('/v1', routes);

app.get('/', (req, res) => {
    res.json({ message: 'Chat API is ALIVE!' });
});

var typingUsers = {};
io.on('connection', function(client) {
    client.on('newChannel', function(name, description) {
        const newChannel = new Channel({
            name: name,
            description: description,
        });
        newChannel.save((_, channel) => {
            io.emit('channelCreated', channel.name, channel.description, channel.id);
        });
    });

    client.on('startType', function(userName, channelId) {
        typingUsers[userName] = channelId;
        io.emit('userTypingUpdate', typingUsers, channelId);
    });

    client.on('stopType', function(userName) {
        delete typingUsers[userName];
        io.emit('userTypingUpdate', typingUsers);
    });

    client.on('newMessage', function(messageBody, userId, channelId, userName, userAvatar, userAvatarColor) {
        const newMessage = new Message({
            messageBody: messageBody,
            userId: userId,
            channelId: channelId,
            userName: userName,
            userAvatar: userAvatar,
            userAvatarColor: userAvatarColor,
        });

        newMessage.save((_, msg) => {
            io.emit('messageCreated', msg.messageBody, msg.userId, msg.channelId, msg.userName, msg.userAvatar, msg.userAvatarColor, msg.id, msg.timeStamp);
        });
    });
});

app.server.listen(config.port);

module.exports = { app, io };
