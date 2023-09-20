const express = require('express');
const authRouter = require('./routes/auth')
const authMiddleware = require('./middlewares/auth')

const app = express()

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use('/auth',authRouter)

module.exports = app