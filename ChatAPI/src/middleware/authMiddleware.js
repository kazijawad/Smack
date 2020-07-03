import jwt from 'jsonwebtoken';
import expressJwt from 'express-jwt';

const TOKENTIME = 60 * 60 * 24 * 90;
const SECRET = 'W3 CHAT 4 FUN';

const authenticate = expressJwt({ secret: SECRET });

const generateAccessToken = (req, res, next) => {
    req.token = req.token || {};
    req.token = jwt.sign ({ id: req.user.id }, SECRET, { expiresIn: TOKENTIME });
    next();
};

const respond = (req, res) => {
    res.status(200).json({
        user: req.user.username,
        token: req.token,
    });
};

module.exports = { authenticate, generateAccessToken, respond };
