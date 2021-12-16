// const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool } = require('../../config/mysql');


const PRIVATE_KEY = 'this is my private key'

exports.signIn = async function (req, res) {
    pool.query('SELECT * FROM USERS WHERE userName=?', [req.body.email],
    (err, rows) => {
        if (rows.length <= 0) {
            return res.status(401).json({
                message: 'Authentication failed! User not found!'
            });
        } else {
            const user = rows[0];
            // if (!user.comparePassword(req.body.password)) {
            if (user.pass !== req.body.password) {
                return res.status(401).json({
                    message: 'Authentication failed! Wrong password!'
                });
            }
            else {
                let token = jwt.sign({
                    name: user.userName,
                    role: user.vai_tro,
                },
                    PRIVATE_KEY
                );
                res.cookie("Authorization", 'JWT ' + token, {
                    httpOnly: true,
                    sameSite: "strict",
                });

                // res.cookie("role", user.vai_tro, {
                //     httpOnly: true,
                //     sameSite: "strict",
                // });

                return res.json({
                    token: token
                });
            }
        };
    });
}

exports.loginRequired = function (req, res, next) {
    console.log('req.user: ', req.user);
    if (req.user) {
        next();
    } else {
        return res.status(401).json({ message: 'Unauthorized user!' });
    }
};

exports.userAuthen = function (req, res, next) {
    if (req.headers 
        && req.headers.cookie 
        && req.headers.cookie.search('=') !== -1
        && req.headers.cookie.substr(req.headers.cookie.search('=')+1).split('%20')[0] === 'JWT') {
        jwt.verify(req.headers.cookie.substr(req.headers.cookie.search('=')+1).split('%20')[1], PRIVATE_KEY, function (err, decode) {
            if (err) {
                req.user = undefined;
                console.log(err);
            }
            req.user = decode;
            console.log(`user: ${req.user.name}`)
            next();
        });
    } else {
        console.log(`req.headers.authorization: ${req.headers.authorization}`);
        console.log(`req.headers.cookie: ${req.headers.cookie}`);
        req.user = undefined;
        next();
    }
}

exports.roleExtraction = function (cookie) {
    var role = undefined;
    jwt.verify(cookie.substr(cookie.search('=')+1).split('%20')[1], PRIVATE_KEY, function (err, decode) {
        if (err) {
            user = undefined;
            console.log(err);
        }
        role = decode.role;
    });

    console.log(`role = ${role}`);
    return role;
}
exports.usernameExtraction = function (cookie) {
    var name = undefined;
    jwt.verify(cookie.substr(cookie.search('=')+1).split('%20')[1], PRIVATE_KEY, function (err, decode) {
        if (err) {
            user = undefined;
            console.log(err);
        }
        name = decode.name;
    });

    console.log(`name = ${name}`);
    return name;
}