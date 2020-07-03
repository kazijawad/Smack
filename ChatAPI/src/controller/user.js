import { Router } from 'express';

import User from '../model/user';
import { authenticate } from '../middleware/authMiddleware';

export default () => {
    const api = Router();

    api.post('/add', authenticate, (req, res) => {
        const newUser = new User();
        newUser.name = req.body.name;
        newUser.email = req.body.email;
        newUser.avatarName = req.body.avatarName;
        newUser.avatarColor = req.body.avatarColor;

        newUser.save(err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(newUser);
        });
    });

    api.get('/', authenticate, (req, res) => {
        User.find({}, (err, users) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(users);
        });
    });

    api.get('/:id', authenticate, (req, res) => {
        User.findById(req.params.id, (err, user) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(user);
        });
    });

    api.put('/:id', authenticate, (req, res) => {
        User.findById(req.params.id, (err, user) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            user.name = req.body.name;
            user.email = req.body.email;
            user.avatarName = req.body.avatarName;
            user.avatarColor = req.body.avatarColor;
            user.save(err => {
                if (err) {
                    res.status(500).json({ message: err });
                }
                res.status(200).json({ message: 'User info updated' });
            });
        });
    });

    api.get('/byEmail/:email', authenticate, (req, res) => {
        User.findOne({ 'email': req.params.email }).exec((err, userData) => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json(userData);
        });
    });

    api.delete('/:id', authenticate, (req, res) => {
        User.remove({ _id: req.params.id }, err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'User Successfully Removed' });
        });
    });

    api.delete('/', authenticate, (req, res) => {
        User.find({}, err => {
            if (err) {
                res.status(500).json({ message: err });
            }
            res.status(200).json({ message: 'Users All Removed' });
        });
    });

    return api;
};
