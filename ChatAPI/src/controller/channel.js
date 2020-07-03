import { Router } from 'express';

import Channel from '../model/channel';
import User from '../model/user';
import { authenticate } from '../middleware/authMiddleware';

export default () => {
    const api = Router();

    api.post('/add', authenticate, (req, res) => {
        const newChannel = new Channel();
        newChannel.name = req.body.name;
        newChannel.description = req.body.description;

        newChannel.save(err => {
            if(err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'Channel saved successfully' });
        });
    });

    api.get('/', authenticate, (req, res) => {
        Channel.find({}, (err, channels) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(channels);
        });
    });

    api.get('/:id', authenticate, (req, res) => {
        Channel.findById(req.params.id, (err, channel) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(channel);
        });
    });

    api.delete('/:id', authenticate, (req, res) => {
        User.remove({ _id: req.params.id }, err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'Channel Successfully Removed' });
        });
    });

    return api;
};
