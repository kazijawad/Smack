import { Router } from 'express';

import Message from '../model/message';
import { authenticate } from '../middleware/authMiddleware';

export default () => {
    const api = Router();

    api.post('/add', authenticate, (req, res) => {
        const newMessage = new Message();
        newMessage.messageBody = req.body.messageBody;
        newMessage.userId = req.body.userId;
        newMessage.channelId = req.body.channelId;
        newMessage.userName = req.body.userName;
        newMessage.userAvatar = req.body.userAvatar;
        newMessage.userAvatarColor = req.body.userAvatarColor;

        newMessage.save(err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'Message saved successfully' });
        });
    });

    api.put('/:id', authenticate, (req, res) => {
        Message.findById(req.params.id, (err, message) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            message.messageBody = req.body.messageBody;
            message.userId = req.body.userId;
            message.channelId = req.body.channelId;
            message.userName = req.body.userName;
            message.userAvatar = req.body.userAvatar;
            message.userAvatarColor = req.body.userAvatarColor;

            message.save(err => {
                if (err) {
                    res.status(500).json({ message: err });
                }
                res.status(200).json({ message: 'Message updated' });
            });
        });
    });

    api.get('/byChannel/:channelId', authenticate, (req, res) => {
        Message.find({ 'channelId' : req.params.channelId }, (err, messages) => {
            if(err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(messages);
        });
    });

    api.delete('/:id', authenticate, (req, res) => {
        Message.remove({ _id: req.params.id }, err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'Message Successfully Removed' });
        });
    });

    api.delete('/', authenticate, (req, res) => {
        Message.find({}, err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'Users All Removed' });
        });
    });

    return api;
};
