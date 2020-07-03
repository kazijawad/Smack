import express from 'express';

import config from '../config';
import middleware from '../middleware';
import initalizeDb from '../db';
import user from '../controller/user';
import account from '../controller/account';
import channel from '../controller/channel';
import message from '../controller/message';

const router = express();

initalizeDb(db => {
    router.use(middleware({ config, db }));
    router.use('/user', user({ config, db }));
    router.use('/account', account({ config, db }));
    router.use('/channel', channel({ config, db }));
    router.use('/message', message({ config, db }));
});

export default router;
