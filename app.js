const express = require('express');
const exphbs = require('express-handlebars');
const bodyParser = require('body-parser');
const mysql = require('mysql2');

require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;


app.use(bodyParser.urlencoded({ extended: false}));
app.use(bodyParser.json());

// static file
app.use(express.static('public'));

// template engine
app.engine('hbs', exphbs({extname: '.hbs'}));
app.set('view engine', 'hbs'); 

// connection Pool

const pool = mysql.createPool({
	connectionLimit : 100,
	host        	: process.env.DB_HOST,
	user 			: process.env.DB_USER,
	password 		: process.env.DB_PASS,
	port 			: process.env.DB_PORT,
	database 		: process.env.DB_NAME
});

// // connect to DB
pool.getConnection((err, connection) => {
	if (err) throw err; // not connected
	console.log('Connected as ID ' + connection.threadId);
});

const routes = require('./server/routes/user');
app.use('/', routes);

app.listen(port, () => console.log('Listening on port', port));



// https://raddy.co.uk/blog/simple-user-management-system-nodejs-express-mysql-handlebards/









