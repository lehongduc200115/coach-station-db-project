const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { signIn, loginRequired, userAuthen } = require('../api/auth');

router.get('/', userController.loginPage);
router.post('/', userController.validateUser);

router.get('/register', userController.registerView);
router.post('/register', userController.register);
router.get('/logout', userController.logout);

// auth rest api
router.route('/auth/signin').post(signIn);

// add some middlewares
router.use(userAuthen);
router.use(loginRequired);

router.get('/homeKH/:ma_khach_hang', userController.homeKH);
router.get('/viewroute/:ma_khach_hang', userController.viewRoute);
router.post('/viewroute/:ma_khach_hang', userController.findRoute);
router.get('/confirmroute/:ma_luot/:ma_khach_hang', userController.confirmRoute);
router.get('/payment/:ma_luot/:ma_khach_hang', userController.paymentView);
router.post('/payment/:ma_luot/:ma_khach_hang', userController.payment);
router.get('/myticket/:ma_khach_hang', userController.myticket);


router.get('/admintuyenxe', userController.adminTuyenXe);
router.get('/adminnhaxe', userController.adminNhaXe);

router.get('/qlchuyenxe/:ma_nha_xe', userController.qlChuyenXe);
router.get('/qlluotchay/:ma_nha_xe', userController.qlLuotChay);
router.get('/qlnhanvien/:ma_nha_xe', userController.qlNhanVien);
router.get('/editnhanvien/:ma_nha_xe/:ma_nhan_vien', userController.editNhanVien);
//router.post('/editnhanvien/:ma_nha_xe', userController.updateNhaXe);
router.get('/qlxe/:ma_nha_xe', userController.qlXe);



// Create, find, update, delete
//router.get('/', userController.viewHome);





// //

// router.get('/qlchuyenxe', userController.qlChuyenXe);
// router.post('/qlchuyenxe', userController.qlChuyenXe);


// router.post('/qlluotchay', userController.qlLuotChay);


// router.post('/qlnhanvien', userController.qlNhanVien);


// router.post('/qlxe', userController.qlXe);



// router.post('/admintuyenxe', userController.adminTuyenXe);
// router.get('/addtuyen', userController.addTuyenXe);
// router.post('/addtuyen', userController.addTuyenXe);

// router.get('/adminnhaxe', userController.adminNhaXe);
// router.post('/adminnhaxe', userController.adminNhaXe);

// router.get('/:ma_tuyen', userController.deleteTuyen);

router.get('/editnhaxe/:ma_nha_xe', userController.editNhaXe);
router.post('/editnhaxe/:ma_nha_xe', userController.updateNhaXe);

//router.get('/:ma_tuyen/:ma_nha_xe', userController.demo)




module.exports = router;