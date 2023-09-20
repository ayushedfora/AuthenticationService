const {isValidEmail, isValidPassword, isValidMobileNumber} = require('../helpers/utilities')
const sendErrorResponse = require('./error')
const strings = require('../constants/strings')
const consts = require('../constants/consts')
const jwt = require('jsonwebtoken')



const validateRegisterRequest = (req,res,next) => {

  const {body} = req

  if(!body || !body.username || !body.email || !body.phoneNumber || !body.password) {
    sendErrorResponse(res,consts.STATUS_CODES.FOUR_HUNDERD, strings.ERROR_MESSAGES.NO_BODY_FOUND)
  }

  if(!isValidEmail(body.email)){
    sendErrorResponse(res,consts.STATUS_CODES.FOUR_HUNDERD, strings.ERROR_MESSAGES.VALID_EMAIL)
  }

  if(!isValidPassword(body.password)){
    sendErrorResponse(res,consts.STATUS_CODES.FOUR_HUNDERD, strings.ERROR_MESSAGES.VALID_PASSWORD)
  }

  next()

}

const validateLoginRequest = (req, res, next) => {
  const {body} = req

  if(!body || !body.email || !body.password) {
    sendErrorResponse(res, consts.STATUS_CODES.FOUR_HUNDERD, strings.ERROR_MESSAGES.NO_BODY_FOUND)
  }

  if(!isValidEmail(body.email)){
    sendErrorResponse(res,consts.STATUS_CODES.FOUR_HUNDERD,strings.ERROR_MESSAGES.VALID_EMAIL)
  }

  if(!isValidPassword(body.password)){
    sendErrorResponse(res,consts.STATUS_CODES.FOUR_HUNDERD, strings.ERROR_MESSAGES.VALID_PASSWORD)
  }

  next()

}

const validateToken = (req, res, next) => {
  const token = String(req.headers.authorization).substring(7)
  console.log(token,'token')
  try {
  const decoded = jwt.verify(token, `${process.env.TOKEN_KEY}`)
  const currentTimestamp = Math.floor(Date.now() / 1000); // Convert to seconds
  if (decoded.exp <= currentTimestamp) {
    // Token has expired
    sendErrorResponse(res, 401, "Token expired")
  }
  return res.status(200).json({
    message : "Valid Token"
  })
  }
  catch(e) {
    sendErrorResponse(res, 401, "Token Signature Verification failed")
  }

}

const validateMobileSignInRequest = (req, res, next) => {
  const {body} = req
  if(!body || !body.phoneNumber) {
    sendErrorResponse(res, consts.STATUS_CODES.FOUR_HUNDERD, strings.ERROR_MESSAGES.NO_BODY_FOUND)
  }
  
  if(!isValidMobileNumber(body.phoneNumber)) {
    sendErrorResponse(res, consts.STATUS_CODES.FOUR_HUNDERD, "Invalid Phone Number")
  }

  next()

}

const authMiddleware = {
    validateRegisterRequest,
    validateLoginRequest,
    validateToken,
    validateMobileSignInRequest,
    otplimiter
}

module.exports = authMiddleware