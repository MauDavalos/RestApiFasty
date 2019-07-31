const mysql = require('mysql');
const express = require('express');
var app = express();
const bodyparser = require('body-parser');
var session = require('express-session');

app.use(bodyparser.json());
app.use(session({secret:"mau"}));

var mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'fasty',
    multipleStatements: true
});

//const session = require('express-session');

mysqlConnection.connect((err) => {
    if (!err)
        console.log('DB connection succeded.');
    else
        console.log('DB connection failed \n Error : ' + JSON.stringify(err, undefined, 2));
});


app.listen(3000, () => console.log('Express server is runnig at port no : 3000'));

//Get all users
app.get('/usuarios', (req, res) => {
    mysqlConnection.query('SELECT * FROM usuario', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Get un usuario
app.get('/usuario/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM usuario WHERE id_usuario = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});


//// get usuario --retorna json
app.get("/users/:id", (req,res) => {
    console.log("Devolviendo usuario con id: " + req.params.id)
    const userId = req.params.id
    const queryString = "select * from usuario where id_usuario = ?"
     mysqlConnection.query(queryString, [userId], (err, rows, fields) => {
        res.json(rows)
    })
    //res.end()
})

///////////// auth
app.post("/auth", (req,res) => {
	var username = req.body.username;
    var password = req.body.password;
     console.log(username+' '+password)
	if (username && password) {
		mysqlConnection.query('SELECT * FROM usuario WHERE nickname = ? AND contrasena = ?', [username, password], (err, rows, fields) => {
			if (rows.length > 0) {
               req.session.username = username;
               req.session.loggedin = true;
				/*req.session.loggedin = true;
				req.session.username = username;*/
				res.send(rows)
			} else {
                res.send("false")
			}			
			res.end();
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}
})

///////////// contrato join

app.post("/contrato", (req,res) => {
	var username = req.body.username;
    var password = req.body.password;
     console.log(username+' '+password)
	if (username && password) { 
		mysqlConnection.query('SELECT usuario.nombre_usuario, usuario.nickname, contrato.descripcion_contrato FROM contrato LEFT JOIN usuario ON usuario.id_usuario = contrato.id_usuario WHERE nickname = ? AND contrasena = ? ', [username, password], (err, rows, fields) => {
			if (rows.length > 0) {
               req.session.username = username;
               req.session.loggedin = true;
				/*req.session.loggedin = true;
				req.session.username = username;*/
				res.json(rows)
			} else {
                res.send("false")
			}			
			res.end();
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}
})

///////////////

///////////// registrar pagos SI VALE CONFIRMADO

app.post("/registrarpago", (req,res) => {
    var fechaPago = req.body.fechaPago;
    var valorPagado = req.body.valorPagado;
    var idContrato = req.body.idContrato;
    var idMetodoPago = req.body.idMetodoPago;

     console.log(fechaPago+' '+valorPagado+' '+idContrato+''+idMetodoPago)
	if (fechaPago && valorPagado && idContrato && idMetodoPago) { 
		mysqlConnection.query('INSERT INTO pago(fecha_pago, monto_pago, id_contrato, id_metodo) VALUES(?,?,?,?)', [fechaPago, valorPagado, idContrato, idMetodoPago], (err, rows, fields) => {
            if (err) {
                throw err;
            }else{ 
                
                res.send('El pago se ha registrado correctamente.')
            } 		
			res.end();
		});
	} else {
		res.send('Ingrese datos de tabla pago!');
		res.end();
	}
})

///////////////

///////////// prueba

app.post("/pruebaf", (req,res) => {
	var username = req.body.username;
    var password = req.body.password;
     console.log(username+' '+password)
	if (username && password) { 
        mysqlConnection.query('SELECT usuario.nombre_usuario, usuario.nickname, contrato.descripcion_contrato, plan FROM contrato LEFT JOIN usuario ON usuario.id_usuario = contrato.id_usuario LEFT JOIN plan ON plan.id_plan = contrato.id_plan WHERE id_usuario = ?', [username, password], (err, rows, fields) => {
			if (rows.length > 0) {
               req.session.username = username;
               req.session.loggedin = true;
				/*req.session.loggedin = true;
				req.session.username = username;*/
				res.json(rows)
			} else {
                res.send("false")
			}			
			res.end();
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}
})

//////////////////// CONFIRMADO SI VALE registros plan y contrato

app.get("/usercontract/:id", (req,res) => {
    console.log("Devolviendo registros de : " + req.params.id)
    const userId = req.params.id
    const queryString = "SELECT * FROM contrato LEFT JOIN plan ON plan.id_plan = contrato.id_plan WHERE contrato.id_usuario = ?"
     mysqlConnection.query(queryString, [userId], (err, rows, fields) => {
        res.json(rows)
    })
    //res.end()
})

/////////// paypal SI VALE

app.get("/paypal/:id", (req,res) => {
    console.log("Devolviendo datos de paypal de : " + req.params.id)
    const userId = req.params.id
    const queryString = "SELECT * FROM paypal WHERE id_usuario = ?"
     mysqlConnection.query(queryString, [userId], (err, rows, fields) => {
        res.json(rows)
    })
    //res.end()
})

/////////// tarjeta si vale

app.get("/tarjeta/:id", (req,res) => {
    console.log("Devolviendo datos de tarjeta de : " + req.params.id)
    const userId = req.params.id
    const queryString = "SELECT * FROM tarjeta WHERE id_usuario = ?"
     mysqlConnection.query(queryString, [userId], (err, rows, fields) => {
        res.json(rows)
    })
    //res.end()
})

///////////

app.post("/infouser", (req,res) => {
	var username = req.body.username;
    var password = req.body.password;
    const queryP = 'SELECT * FROM usuario WHERE nickname = ? AND contrasena = ?';
     console.log(username+' '+password)
     console.log('Se devuelve usuario '+ username)
	if (username && password) {
		mysqlConnection.query(queryP, [username, password], (err, rows, fields) => {
			if (rows.length > 0) {
               //req.session.username = username;
               //req.session.loggedin = true;
               //mysqlConnection.query(queryP, [username], (err, rows, fields) => {
                ///res.json(rows)
                const queryString = "select usuario.apellido_usuario WHERE nickname = ? AND contrasena = ?"
                mysqlConnection.query(queryString, [username], (err, rows, fields) => {
                 res.json(rows)

            })
			} else {
                res.send("false")
			}			
			res.end();
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}
})

//// get usuario --retorna json
app.get("/users/:id", (req,res) => {
    console.log("Devolviendo usuario con id: " + req.params.id)
    const userId = req.params.id
    const queryString = "select * from usuario where id_usuario = ?"
     mysqlConnection.query(queryString, [userId], (err, rows, fields) => {
        res.json(rows)
    })
    //res.end()
})