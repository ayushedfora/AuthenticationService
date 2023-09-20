
const consts = require('../constants/consts')
const accountSid = consts.TWILIO.SID;
const authToken = consts.TWILIO.TOKEN;
const client = require('twilio')(accountSid, authToken);

const sendOtpMessage = (otp, phoneNumber) => {

    return new Promise((resolve, reject)=>{
        client.messages
        .create({
           body: `${consts.TWILIO.OTP_MESSAGE}: ${otp}`,
           from: consts.TWILIO.SENDER_PHONE_NUMBER,
           to: phoneNumber
         })
        .then(message=> {
             resolve({message, status: true})
        }
        ).catch((e)=>{
                reject({message:e, status: false})
             });
    })
    
}

const twilioService = {
    sendOtpMessage
}

module.exports = twilioService