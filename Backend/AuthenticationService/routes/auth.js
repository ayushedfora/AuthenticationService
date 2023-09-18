// routes/auth.js

const express = require('express');
const router = express.Router();
const authMiddleware = require('../middlewares/auth');
const authController = require('../controllers/auth'); // Import the controller






router.post('/register', authMiddleware.validateRegisterRequest, authController.registerUser);
router.post('/login',authMiddleware.validateLoginRequest, authController.loginUser)
router.post('/validate',authMiddleware.validateToken)
router.post('/mobile',authMiddleware.validateMobileSignInRequest)



module.exports = router;
