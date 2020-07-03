import mongoose from 'mongoose';

import config from './config';

export default callback => {
    let db;
    mongoose.connect(config.mongoUrl, function(err, database) {
        if (err) {
            console.log(err);
            process.exit(1);
        }
        db = database;
        callback(db);
    });
};
