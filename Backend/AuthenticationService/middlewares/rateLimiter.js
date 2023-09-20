const { rateLimit } = require('express-rate-limit')
const  strings  = require('../constants/strings')

const otplimiter = rateLimit({
	windowMs: 60 * 1000, // 15 minutes
	limit: 1, // Limit each IP to 100 requests per `window` (here, per 15 minutes)
	standardHeaders: 'draft-7', // draft-6: `RateLimit-*` headers; draft-7: combined `RateLimit` header
	legacyHeaders: false, // Disable the `X-RateLimit-*` headers
	 message : strings.ERROR_MESSAGES.RATE_LIMITER_ERROR
})

const registerLimiter = rateLimit({
	windowMs: 60 * 1000,
	limit: 3,
	standardHeaders: 'draft-7',
	legacyHeaders: false,
	message: strings.ERROR_MESSAGES.RATE_LIMITER_ERROR
})

const resetPasswordLimiter = rateLimit({
	windowMs: 60 * 1000,
	limit: 5,
	standardHeaders: 'draft-7',
	legacyHeaders: false,
	message: strings.ERROR_MESSAGES.RATE_LIMITER_ERROR
})

const rateLimiter = {otplimiter, registerLimiter, resetPasswordLimiter}

module.exports = rateLimiter