const mongoose = require('mongoose')

const Schema = mongoose.Schema

const userSchema = new Schema ({
    email: {type : String, unique: true},
    password: {type : String},
    userName: {type : String},
    phoneNumber: {type : String, unique: true}
})

const userModel = mongoose.model('User',userSchema)
async function connectDB() {
    try {
        await mongoose.connect('mongodb+srv://Iyush:%40JPawar13052000@cluster0.bb4ef.mongodb.net/?retryWrites=true&w=majority', {
          
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('Connected to the database');
    } catch (error) {
        console.error('Error connecting to the database:', error);
    }
}



async function registerUser(body) {
    
    const user = new userModel({email:body.email,password:body.password,userName:body.userName,phoneNumber:body.phoneNumber})
    await user.save()
}

async function registerUserByPhoneNumber(body) {
    const user = new userModel({userName:body.userName,phoneNumber:body.phoneNumber})
    await user.save()
}

async function findUser(userEmail) {

    const user = await userModel.findOne({email:userEmail})
    return user
}

async function findUserByPhoneNumber(phoneNumber) {
    const user = await userModel.findOne({phoneNumber: phoneNumber})
    return user
}

const dbServices = {
    connectDB ,registerUser, findUser, findUserByPhoneNumber, registerUserByPhoneNumber
}

module.exports = dbServices;