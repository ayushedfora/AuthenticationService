const sendErrorResponse = require('../middlewares/error')
const dbServices = require('../helpers/db')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const twilioService = require('../helpers/twilio')
const consts = require('../constants/consts')

const registerUser = async (req,res,next) => {
  const { body } = req

  body.password = await hashPassword(body.password)
  const doesUserExist = await dbServices.findUser(body.email)
  if(doesUserExist){
    sendErrorResponse(res, 200, "User exists with the same email")
    return
  }
  await dbServices.registerUser(body)
  res.status(201).json({
    "message" : "User registered successfully"
  })
}

const loginUser = async (req,res,next) => {
  const {body} = req
  const user = await dbServices.findUser(body.email)
  if(!user) {
    sendErrorResponse(res, 400, "User does not exist")
    return
  }

  const data = await comparePasswords(body.password, user.password)

  if(data){
    const token = generateAuthToken(user._id)
    res.status(200).json({
      message: "User Logged in Successfully",
      token
    })
  }
  else {
    res.status(404).json({
      "message": "Invalid Password"
    })
  }
  
}

const hashPassword = async (password) => {
return new Promise((resolve, reject) => {
  bcrypt.hash(password, 10, function(err, hash) {
    if(err){
      reject(err)
    }
    else {
      resolve(hash)
    }
  });
})

}

const generateOTP = () => {
  const otpLength = 6;
  

  let otp = '';
  for (let i = 0; i < otpLength; i++) {
    otp += Math.floor(Math.random() * 10); 
  }
  
  return otp;
}

const comparePasswords = async (incomingPassword, dbPassword) => {
  return new Promise((resolve, reject) => {
    bcrypt.compare(incomingPassword, dbPassword, (err, data) => {
        if (err) {
          reject(err)
        }
        else{
          resolve(data)
        }
    })
  })
  
}

const signInWithMobile = async (req, res, next) => {
  const { body } = req
  let user = await dbServices.findUserByPhoneNumber(body.phoneNumber)
  if (!user) {
    user = await dbServices.registerUserByPhoneNumber(body)
  }
  const token = generateAuthToken(user._id)
  res.status(200).json({
    message: "User Logged in Successfully",
    token
  })

}

const verifyOTP = async (req, res, next) => {
  const {body} = req

}

const sendOTP =  async(req, res, next) => {
  const {body} = req
  const otp = generateOTP()
  let otpResponse = {}
  try {
    otpResponse = await twilioService.sendOtpMessage(otp, body.phoneNumber)
  }
  catch(e){
    otpResponse = e
  }
  let message = "OTP sending failed. Please try in 60 seconds"
  let status = consts.STATUS_CODES.TWO_HUNDRED
  if(otpResponse.status){
    message = "OTP sent successfully"
  }
  res.status(status).json({
    message
  })
}

const generateAuthToken = (userId) => {
  const token = jwt.sign({userId}, `${process.env.TOKEN_KEY}`, {
    expiresIn: "2d"
  })
  return token
}

const authController = {
    registerUser,
    loginUser,
    sendOTP
}

module.exports = authController