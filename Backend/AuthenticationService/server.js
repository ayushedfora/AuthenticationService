const app = require('./app')
const PORT = require('./config')
const dbServices = require('./helpers/db')

dbServices.connectDB().then(()=>{
    app.listen(PORT, () => {
        console.log(`Service running on ${PORT}`)
    })
}).catch((e)=>{
    console.log("Some Error Occured")
})
