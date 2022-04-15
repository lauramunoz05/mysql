const express = require('express');
const morgan = require('morgan');
const path = require('path');
const app = express();
require('dotenv').config();


// Middlewares
app.use(morgan('dev'));
app.use(express.json());

// Routes 
app.get('', (req, res) => {
    res.send('<h1>Hola mundo</h1>')
});

app.use('/api/', require("./routes/productos"));
app.use('/api/', require("./routes/sedes"));;

// PORT 
app.set('port', process.env.PORT || 301);

app.listen(app.get('port'), () => {
    console.log(`servidor corriendo en el puerto ${app.get("port")} `);
})