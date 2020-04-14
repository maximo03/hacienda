/*const express = require('express');
const app = express();

//middlewares
app.use(express.json());
app.use(express.urlencoded({extended:false}));

//routes
app.use(require('./routes/index'));


app.listen(3000);
console.log('SERVER ON');

*/

const express =require(`express`);
const app = express();


//setings
app.set(`port`,process.env.PORT || 3001);
//app.set(`json spaces`,2);

//MIDELWARES
app.use(express.json());
app.use(express.urlencoded({extended:true}));

//ROUTES
app.use(require(`./routes/index`));



//STATARTIN SERVER
app.listen(app.get(`port`),()=>{
    console.log(`server on port ${app.get(`port`)}`);
})

