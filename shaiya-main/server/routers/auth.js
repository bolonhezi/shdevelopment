const express = require('express');
const passport = require('passport');
const JwtStrategy = require('passport-jwt').Strategy;
const jwt = require('jsonwebtoken');

const router = express.Router();

const { runPreparedQuery } = require('../config/db');
const q = require('../queries/auth');

const cookieExtractor = function(req) {
    let token = null;
    if (req && req.cookies) token = req.cookies['token'];
    return token;
};

const jwtOptions = {
    jwtFromRequest: cookieExtractor,
    secretOrKey: process.env.JWT_SECRET
}

const generateJwtToken = (userData) => {
    const signature = process.env.JWT_SECRET;

    const token = jwt.sign(userData, signature, {
        expiresIn: '24h'
    });

    return token;
}

router.get('/me', passport.authenticate('jwt', { session: false }), (req, res) => {
    let { UserID } = req.user;
    res.status(200).json({ resultCode: 0, data: { UserID } });
})

router.post('/login', async (req, res) => {
    let { login, password } = req.body;

    try {
        const checkUser = await runPreparedQuery(q.userDataQuery, { login, password });
        if(checkUser.recordset.length > 0) {
            const correctPassword = checkUser.recordset[0].Pw === password;
            if(correctPassword) {
                let { UserID } = checkUser.recordset[0];
                let token = generateJwtToken({ login: UserID });
                res.status(200).cookie('token', token, {
                    expires: new Date(Date.now() + 24 * 60 * 60 * 1000),
                    secure: false, // set to true if your using https
                    httpOnly: false,
                }).json({ resultCode: 0 });
            } else {
                res.status(200).json({ resultCode: 1, message: "Invalid username or password" });
            }
        } else {
            res.status(200).json({ resultCode: 1, message: "Invalid username or password" });
        }
    } catch (err) {
        res.sendStatus(500);
    }
});

router.post('/register', async (req, res) => {
    let { login, password, password2 } = req.body;
    if(password !== password2) {
        res.json({ resultCode: 1, message: "Passwords are not equal" });
        return;
    }
    if(login === password) {
        res.json({ resultCode: 1, message: "Login should not match password" });
        return;
    }
    try {
        let resp = await runPreparedQuery(q.checkUserQuery, { login });
        if (resp.recordset[0].Count > 0) {
            res.status(200).json({ resultCode: 1, message: "Username occupied" });
        } else {
            let result = await runPreparedQuery(q.registerQuery, { login, password, ip: `${req.ip.substr(7)}` });
            if(result.rowsAffected) {
                res.status(201).json({ resultCode: 0 });
            } else {
                res.status(201).json({ resultCode: 1, message: "Something went wrong, please try later" });
            }
        }
    }
    catch (err) {
        res.sendStatus(500);
    }
});

router.post('/change', passport.authenticate('jwt', { session: false }), async (req, res) => {
    let { old_pass, password, password2 } = req.body;
    let login = req.user.UserID;
    if(password === login) {
        res.json({ resultCode: 1, message: "New password should not match your username" });
        return;
    }
    if(password !== password2) {
        res.json({ resultCode: 1, message: "Passwords are not equal" });
        return;
    }
    try {
        let resp = await runPreparedQuery(q.getPasswordQuery, { login });
        if(resp.recordset[0].Pw === password) {
            res.status(200).json({ resultCode: 1, message: "New password is equal to the old one" });
            return;
        }
        if (resp.recordset[0].Pw !== old_pass) {
            res.status(200).json({ resultCode: 1, message: "Invalid old password" });
        } else {
            let result = await runPreparedQuery(q.changePasswordQuery, { login, password });
            if(result.rowsAffected) {
                await runPreparedQuery(q.createChangePassLogQuery, { id: req.user.UserUID, oldpass: old_pass, newpass: password });
                res.status(201).json({ resultCode: 0 });
            } else {
                res.status(201).json({ resultCode: 1, message: "Something went wrong, please try later" });
            }
        }
    }
    catch (err) {
        res.sendStatus(500);
    }
})

passport.use(new JwtStrategy(jwtOptions, async function(jwt_payload, done) {
    try {
        let { login } = jwt_payload;
        let currUser = await runPreparedQuery(q.userDataUnprotectedQuery, { login });
        if(currUser.recordset.length > 0) {
            return done(null, currUser.recordset[0]);
        } else {
            return done(null, false);
        }
    } catch(err) {
        return done(err, false);
    }
}))

module.exports = router;