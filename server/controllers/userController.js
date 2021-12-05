
const mysql = require('mysql'); 
// Connection Pool
let connection = mysql.createConnection({
  host 		: process.env.DB_HOST,
  user 		: process.env.DB_USER,
  password 	: process.env.DB_PASS,
  port 		: process.env.DB_PORT,
  database 	: process.env.DB_NAME,
  multipleStatements: true
});

// exports.demo = (req, res) => {
// 	let tuyen = req.params.ma_tuyen;
// 	let nha = req.params.ma_nha_xe;
// 	res.render('demo', { tuyen, nha });
// }

// Login Page
exports.loginPage = (req, res) => {
	res.render('login');
}

// Validate User
exports.validateUser = (req, res) => {
	let username = req.body.userName;
	let password = req.body.pass;
	connection.query('CALL VALIDATE_USER (?, ?)', [username, password], (err, rows) => {
    // When done with the connection, release it
    let check = rows[0];
    if (check.length > 0) {
    	connection.query('SELECT CONCAT(ho," ", ten) AS ho_ten, T.ma_khach_hang FROM USERS U, KHACH_HANG K, THANH_VIEN T WHERE userName = ? AND pass = ? AND T.ma_khach_hang = K.ma_khach_hang AND T.userID = U.userID AND vai_tro = "KH"', [username, password], (err, rows) => {
		    // When done with the connection, release it
		    if (rows.length > 0) {
		      res.render('home-page-KH', { rows });
		    } else {
		      //res.render('login');
		      ///////////

		      connection.query('SELECT CONCAT(ho," ", ten) AS ho_ten, ma_nhan_vien, ten_nha_xe, X.ma_nha_xe FROM USERS U, NHAN_VIEN N, NHA_XE X WHERE userName = ? AND pass = ? AND N.userID = U.userID AND vai_tro = "QL" AND N.ma_nha_xe = X.ma_nha_xe', [username, password], (err, rows) => {
				    // When done with the connection, release it
				    if (rows.length > 0) {
				      res.redirect('/qlchuyenXe/'+rows[0].ma_nha_xe);
				    } else {
				      res.redirect('/admintuyenxe');

				      	///////////

		     //  		connection.query('SELECT CONCAT(ho," ", ten) AS ho_ten, ma_nhan_vien, ten_nha_xe, X.ma_nha_xe FROM USERS U, NHAN_VIEN N, NHA_XE X WHERE userName = ? AND pass = ? AND N.userID = U.userID AND vai_tro = "QL" AND N.ma_nha_xe = X.ma_nha_xe', [username, password], (err, rows) => {
					  //   // When done with the connection, release it
					  //   if (rows.length > 0) {
					  //     res.redirect('/qlchuyenXe/'+rows[0].ma_nha_xe);
					  //   } else {
					  //     res.redirect('/admintuyenxe');
					  //   }
					  //   console.log('The Query Results: \n', rows);
					  // });

		      			////////////


				    }
				    console.log('The Query Results: \n', rows);
				  });

		      ////////////

		    }
		    console.log('The Query Results: \n', rows);
		  });
      //res.render('home-page', { rows});
    } else {
      res.render('login');
    }
    console.log('The data from user table: \n', rows);
  });
	
}


// Login Page
exports.registerView = (req, res) => {
	res.render('register');
}

exports.register = (req, res) => {
	let ho = req.body.ho;
	let ten = req.body.ten;
	let gioi_tinh = req.body.gioi_tinh;
	let ngay_sinh = req.body.ngay_sinh;
	let so_dien_thoai = req.body.so_dien_thoai;
	let dia_chi = req.body.dia_chi;
	let userName = req.body.userNameRES;
	let pass = req.body.passRES;

	// User the connection
	connection.query('CALL REGISTER (?, ?, ?, ?, ?, ?, ?, ?)', [ho, ten, so_dien_thoai, ngay_sinh, gioi_tinh, dia_chi, userName, pass], (err, rows) => {
		if(!err) {
			res.render('login');
		} else {
			console.log(err);
			res.render('register');
		}
		console.log('Query Results: \n', rows);
	});
	
}



// Trang chu - Khach Hang
exports.homeKH = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	  // User the connection
	 connection.query('SELECT CONCAT(ho," ", ten) AS ho_ten, ma_khach_hang FROM KHACH_HANG WHERE ma_khach_hang = ?', [ma_khach_hang], (err, rows) => {
	   // When done with the connection, release it
	   if (!err) {
	      res.render('home-page-KH', { rows });
	   } else {
	      console.log(err);
	   }
	    console.log('The data from user table: \n', rows);
	});
}

// Xem Chuyến xe
exports.viewRoute = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	res.render('view-route', { ma_khach_hang });
}


// Find route by search
exports.findRoute = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	let searchTerm = req.body.diem_den;
	let searchDate = req.body.ngay_di;

	// User the connection
	connection.query('SELECT ten_nha_xe, ngay_khoi_hanh, gio_khoi_hanh, ten_tram_den, gia_ve, ma_luot, ma_khach_hang FROM NHA_XE N, TUYEN_XE T, CHUYEN_XE C, LUOT_CHAY L, THANH_VIEN  WHERE noi_den LIKE ? AND C.ma_tuyen = T.ma_tuyen AND L.ma_chuyen = C.ma_chuyen AND N.ma_nha_xe = C.ma_nha_xe AND C.ngay_khoi_hanh = ? AND ma_khach_hang = ?', ['%' + searchTerm + '%', searchDate, ma_khach_hang], (err, rows) => {
		if(!err) {
			res.render('view-route', { rows, ma_khach_hang });
		} else {
			console.log(err);
		}
		console.log('Query Results: \n', rows);
	});
}



exports.confirmRoute = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	res.render('confirm-route', { ma_khach_hang });
}

// Xem Chuyến xe
exports.confirmRoute = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	let ma_luot = req.params.ma_luot;
	// User the connection
	connection.query('SELECT ten_nha_xe, noi_di, noi_den, ten_tram_den, ngay_khoi_hanh, gio_khoi_hanh, gia_ve, phu_thu, ma_khach_hang, ma_luot FROM NHA_XE N, TUYEN_XE T, CHUYEN_XE C, LUOT_CHAY L, THANH_VIEN WHERE L.ma_luot = ? AND L.ma_chuyen = C.ma_chuyen AND C.ma_tuyen = T.ma_tuyen AND C.ma_nha_xe = N.ma_nha_xe AND ma_khach_hang = ?', [ma_luot, ma_khach_hang], (err, rows) => {
		if(!err) {
			res.render('confirm-route', { rows });
		} else {
			console.log(err);
		}
			console.log('Query Results: \n', rows);
		});
}

exports.paymentView = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	let ma_luot = req.params.ma_luot;
	res.render('payment', { ma_khach_hang});
}

exports.payment = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	let ma_luot = req.params.ma_luot;
	let so_luong = req.body.so_luong;
	let tram_len = req.body.tram_don_trung_gian;
	// User the connection
	connection.query('CALL MUA_NHIEU_VE (?, ?, ?, ?)', [so_luong, ma_khach_hang, ma_luot, tram_len], (err, rows) => {
		if(!err) {
			connection.query('SELECT CONCAT(ho," ",ten) AS ho_ten, so_dien_thoai, ma_khach_hang FROM KHACH_HANG WHERE ma_khach_hang = ?', [ma_khach_hang], (err, rows) => {
			    // When done with the connection, release it
			    if (!err) {
			      res.render('payment', { rows });
			    } else {
			      console.log(err);
			    }
			    console.log('The Query Results: \n', rows);
			  });

			//res.render('payment', { ma_khach_hang });
		} else {
			console.log(err);
		}
			console.log('Query Results: \n', rows);
		});
}

exports.myticket = (req, res) => {
	let ma_khach_hang = req.params.ma_khach_hang;
	  // User the connection
	 connection.query('SELECT N.ten_nha_xe, T.noi_di, T.noi_den, C.ten_tram_den, V.ma_ve, C.ngay_khoi_hanh, L.gio_khoi_hanh FROM VE V, LUOT_CHAY L, CHUYEN_XE C, NHA_XE N, TUYEN_XE T WHERE V.ma_khach_hang = ? AND V.ma_luot = L.ma_luot AND L.ma_chuyen = C.ma_chuyen AND C.ma_tuyen = T.ma_tuyen AND C.ma_nha_xe = N.ma_nha_xe', [ma_khach_hang], (err, rows) => {
	   // When done with the connection, release it
	   if (!err) {
	      res.render('my-ticket', { rows });
	   } else {
	      console.log(err);
	   }
	    console.log('The data from user table: \n', rows);
	});
}



// ======== Chuyen Xe
// exports.qlChuyenXe = (req, res) => {
// 	res.render('chuyen-xe');
// }
// Find route by search
exports.qlChuyenXe = (req, res) => {
		// User the connection
		let ma_nha_xe = req.params.ma_nha_xe;
		connection.query('SELECT * FROM CHUYEN_XE WHERE ma_nha_xe = ?', [ma_nha_xe], (err, rows) => {

			if(!err) {
				res.render('chuyen-xe', { rows, ma_nha_xe });
			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});
}

// ======== Luot Chay
// exports.qlLuotChay = (req, res) => {
// 	res.render('luot-chay');
// }
// Find route by search
exports.qlLuotChay = (req, res) => {
		// User the connection
		let ma_nha_xe = req.params.ma_nha_xe;
		connection.query('SELECT ma_luot, ten_tram_den, gio_khoi_hanh, phu_thu FROM CHUYEN_XE C, LUOT_CHAY L WHERE L.ma_chuyen = C.ma_chuyen AND ma_nha_xe = ?', [ma_nha_xe], (err, rows) => {
		
			if(!err) {
				res.render('luot-chay', { rows, ma_nha_xe });
			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});

}

// ======== Nhan Vien
// exports.qlNhanVien = (req, res) => {
// 	res.render('nhan-vien');
// }
// Find route by search
exports.qlNhanVien = (req, res) => {
	let ma_nha_xe = req.params.ma_nha_xe;
		// User the connection
		connection.query('SELECT ma_nhan_vien, ho, ten, gioi_tinh, loai_nhan_vien, ma_nha_xe FROM NHAN_VIEN WHERE ma_nha_xe = ?', [ma_nha_xe], (err, rows) => {
			if(!err) {
				res.render('nhan-vien', { rows, ma_nha_xe });
			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});
}

exports.editNhanVien = (req, res) => {
	let ma_nha_xe = req.params.ma_nha_xe;
	let ma_nhan_vien = req.params.ma_nhan_vien;
  // User the connection
  connection.query('SELECT CONCAT(ho," ",ten) AS ho_ten, gioi_tinh, ngay_sinh, dia_chi, so_dien_thoai, loai_nhan_vien FROM NHAN_VIEN WHERE ma_nhan_vien = ?', [ma_nhan_vien], (err, rows) => {
    if (!err) {
      res.render('edit-nhan-vien', { rows, ma_nha_xe });
    } else {
      console.log(err);
    }
    console.log('The data from user table: \n', rows);
  });
}




// ======== Xe
// exports.qlXe = (req, res) => {
// 	res.render('xe');
// }
// Find route by search
exports.qlXe = (req, res) => {
		let ma_nha_xe = req.params.ma_nha_xe;
		// User the connection
		connection.query('SELECT * FROM XE WHERE ma_nha_xe = ?', [ma_nha_xe], (err, rows) => {
			if(!err) {
				res.render('xe', { rows, ma_nha_xe });
			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});
}


// exports.adminTuyenXe = (req, res) => {
// 	res.render('tuyen-xe');
// }

// Find route by search
exports.adminTuyenXe = (req, res) => {

		// User the connection
		connection.query('SELECT * FROM TUYEN_XE', (err, rows) => {
			if(!err) {
				res.render('tuyen-xe', { rows });
			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});
	
}

exports.addTuyenXe = (req, res) => {
	res.render('add-tuyen');
}

// Them Tuyen xe moi
exports.addTuyenXe = (req, res) => {
	const {noi_di, noi_den } = req.body;
	pool.getConnection((err, connection) => {
		if (err) throw err; // not connected
		console.log('Connected as ID ' + connection.threadId);

		// User the connection
		connection.query('INSERT INTO TUYEN_XE SET ma_tuyen = CAST(FLOOR(RAND()*(999999-100000+1)+100000) AS CHAR), noi_di = ?, noi_den = ?', [noi_di, noi_den], (err, rows) => {
			connection.release();
			if(!err) {
				res.render('add-tuyen'); 
			} else {
				console.log(err);
			}
			console.log('Query Results:\n', rows);
		});
	});
}



// exports.adminNhaXe = (req, res) => {
// 	res.render('nha-xe');
// }

// Find route by search
exports.adminNhaXe = (req, res) => {

		// User the connection
		connection.query('SELECT N.ma_nha_xe, ten_nha_xe, email, so_dien_thoai, dia_chi FROM NHA_XE N, SDT_NHA_XE S WHERE N.ma_nha_xe = S.ma_nha_xe', (err, rows) => {
			if(!err) {
				res.render('nha-xe', { rows });
			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});
}

// Delete user
exports.deleteTuyen = (req, res) => {
	pool.getConnection((err, connection) => {
		if (err) throw err; // not connected
		console.log('Connected as ID ' + connection.threadId);
		

		// User the connection
		connection.query('DELETE FROM TUYEN_XE WHERE ma_tuyen = ?', [req.params.ma_tuyen], (err, rows) => {
			connection.release();
			if(!err) {
				res.redirect('/admintuyenxe');
			} else {
				console.log(err);
			}
			console.log('The data from the USERS table: \n', rows);
		});
	});

}



// Edit user
exports.editNhaXe = (req, res) => {
	pool.getConnection((err, connection) => {
		if (err) throw err; // not connected
		console.log('Connected as ID ' + connection.threadId);
		
		//let searchTerm = req.body.search;

		// User the connection
		connection.query('SELECT ten_nha_xe, email, S.so_dien_thoai, N.dia_chi, ho, ten FROM NHA_XE N, NHAN_VIEN Q, SDT_NHA_XE S WHERE N.ma_nha_xe = ? AND Q.ma_nha_xe = N.ma_nha_xe AND S.ma_nha_xe = N.ma_nha_xe AND N.NV_quan_ly = Q.ma_nhan_vien', [req.params.ma_nha_xe], (err, rows) => {
			connection.release();
			if(!err) {
				res.render('edit-nha-xe', { rows });
			} else {
				console.log(err);
			}
			console.log('Query Resultslll: \n', rows);
		});
	});
}

// Update User
exports.updateNhaXe = (req, res) => {
	const { ten_nha_xe, email, dia_chi } = req.body;
	pool.getConnection((err, connection) => {
		if (err) throw err; // not connected
		console.log('Connected as ID ' + connection.threadId);
		
		//let searchTerm = req.body.search;

		// User the connection
		connection.query('UPDATE NHA_XE SET ten_nha_xe = ?, email = ?, dia_chi = ? WHERE ma_nha_xe = ?', [ten_nha_xe, email, dia_chi, req.params.ma_nha_xe], (err, rows) => {
			//connection.release();
			if(!err) {
				pool.getConnection((err, connection) => {
				if (err) throw err; // not connected
				console.log('Connected as ID ' + connection.threadId);
				//let searchTerm = req.body.search;

				// User the connection
				connection.query('SELECT ten_nha_xe, email, S.so_dien_thoai, N.dia_chi, ho, ten FROM NHA_XE N, NHAN_VIEN Q, SDT_NHA_XE S WHERE N.ma_nha_xe = ? AND Q.ma_nha_xe = N.ma_nha_xe AND S.ma_nha_xe = N.ma_nha_xe', [req.params.ma_nha_xe], (err, rows) => {
					connection.release();
					if(!err) {
						res.render('edit-nha-xe', { rows });
					} else {
						console.log(err);
					}
					console.log('Query Resultsssss: \n', rows);
				});
			});

			} else {
				console.log(err);
			}
			console.log('Query Results: \n', rows);
		});
	});
}







