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

router.get('/myticket/:ma_khach_hang', userController.myticket);

// add some middlewares
// router.use(userAuthen);
// router.use(loginRequired);

router.get('/homeKH/:ma_khach_hang', userController.homeKH);
router.get('/viewroute/:ma_khach_hang', userController.viewRoute);
router.post('/viewroute/:ma_khach_hang', userController.findRoute);
router.get('/confirmroute/:ma_luot/:ma_khach_hang', userController.confirmRoute);
router.get('/payment/:ma_luot/:ma_khach_hang', userController.paymentView);
router.post('/payment/:ma_luot/:ma_khach_hang', userController.payment);


router.get('/admintuyenxe', userController.adminTuyenXe);
router.get('/adminnhaxe', userController.adminNhaXe);

router.get('/qlchuyenxe/:ma_nha_xe', userController.qlChuyenXe);
router.get('/addchuyenxe/:ma_nha_xe', userController.addChuyenXe);
router.post('/addchuyenxe/:ma_nha_xe', userController.postAddChuyenXe);
router.get('/editchuyenxe/:ma_chuyen_xe', userController.editChuyenXe);
router.post('/editchuyenxe/:ma_chuyen_xe/:ma_nha_xe', userController.postEditChuyenXe);
router.get('/xoachuyenxe/:ma_chuyen_xe/:ma_nha_xe', userController.delChuyenXe);
// router.get('/addchuyen', userController.addChuyenXe);
router.get('/qlluotchay/:ma_nha_xe', userController.qlLuotChay);
router.get('/addluotchay/:ma_nha_xe', userController.addLuotChay);
router.post('/addluotchay/:ma_nha_xe', userController.postAddLuotChay);
router.get('/editluotchay/:ma_luot_chay/:ma_nha_xe', userController.editLuotChay);
router.post('/editluotchay/:ma_luot_chay/:ma_nha_xe', userController.postEditLuotChay);
router.get('/xoaluotchay/:ma_luot_chay/:ma_nha_xe', userController.delLuotChay);
// router.get('/addluotchay/:ma_nha_xe', userController.addLuotChay);
router.get('/addxe/:ma_nha_xe', userController.addXe);
router.get('/qlnhanvien/:ma_nha_xe', userController.qlNhanVien);
router.get('/editnhanvien/:ma_nhan_vien/:ma_nha_xe', userController.editNhanVien);
router.post('/editnhanvien/:ma_nhan_vien/:ma_nha_xe', userController.postEditNhanVien);
router.get('/qlxe/:ma_nha_xe', userController.qlXe);
router.get('/qlthongke/:ma_nha_xe', userController.qlThongKe);
// router.get('/qlthongke/:ma_nha_xe', userController.qlThongKe);



// Create, find, update, delete
//router.get('/', userController.viewHome);





// //

// router.get('/qlchuyenxe', userController.qlChuyenXe);
// router.post('/qlchuyenxe', userController.qlChuyenXe);


// router.post('/qlluotchay', userController.qlLuotChay);


// router.post('/qlnhanvien', userController.qlNhanVien);


// router.post('/qlxe', userController.qlXe);



// router.post('/admintuyenxe', userController.adminTuyenXe);
router.get('/addtuyen', userController.addTuyenXe);
// router.post('/addtuyen', userController.addTuyenXe);

// router.get('/adminnhaxe', userController.adminNhaXe);
// router.post('/adminnhaxe', userController.adminNhaXe);

// router.get('/:ma_tuyen', userController.deleteTuyen);

router.get('/editnhaxe/:ma_nha_xe', userController.editNhaXe);
router.post('/editnhaxe/:ma_nha_xe', userController.updateNhaXe);

//router.get('/:ma_tuyen/:ma_nha_xe', userController.demo)




module.exports = router;