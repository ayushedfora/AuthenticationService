// routes/auth.js

const express = require('express');
const router = express.Router();
const authMiddleware = require('../middlewares/auth');
const authController = require('../controllers/auth'); // Import the controller
const rateLimitMiddleware = require('../middlewares/rateLimiter')






router.post('/register', [rateLimitMiddleware.registerLimiter,authMiddleware.validateRegisterRequest], authController.registerUser);
router.post('/login',[rateLimitMiddleware.registerLimiter,authMiddleware.validateLoginRequest], authController.loginUser)
router.post('/validate',authMiddleware.validateToken)
router.post('/mobile',[rateLimitMiddleware.otplimiter,authMiddleware.validateMobileSignInRequest], authController.sendOTP)



module.exports = router;
