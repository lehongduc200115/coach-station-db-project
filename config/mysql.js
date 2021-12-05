const mysql = require('mysql2');

exports.pool = mysql.createPool({
	connectionLimit : 10,
	host        	: process.env.DB_HOST,
	user 			: process.env.DB_USER,
	password 		: process.env.DB_PASS,
	port 			: process.env.DB_PORT,
	database 		: process.env.DB_NAME
});

// connect to DB
// pool.getConnection((err, connection) => {
// 	if (err) throw err; // not connected
// 	console.log('Connected as ID ' + connection.threadId);
// });
