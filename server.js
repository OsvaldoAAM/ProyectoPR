// Importa modulos requeridos
const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const bcrypt = require('bcryptjs');
const cors = require('cors');
const app = express();

// Establece el puerto en el que el servidor escuchará
const PORT = process.env.PORT || 3000;

// Configuración de la conexión a MySQL
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',       //  usuario de MySQL
  password: '1234', //  contraseña de MySQL
  database: 'sitiorecetas' // nombre de la base de datos
});

app.use(cors());
app.use(express.json());


connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos: ', err);
    return;
  }
  console.log('Conexión exitosa a MySQL');
});


app.use(express.static(path.join(__dirname, 'public')));

//Metodos HTTPS


app.get('/', (req, res) => {
    res.send('¡El servidor está funcionando.');
  });


app.get('/api/usuarios', (req, res) => {
  connection.query('SELECT * FROM usuarios', (err, results) => {
    if (err) {
      console.error('Error en la consulta: ', err);
      return res.status(500).send('Error en la consulta');
    }
    res.json(results); // Envía los resultados de la consulta en formato JSON
  });
});


// Ruta POST para registrar un usuario
app.post('/usuarios', async (req, res) => {
  const { nombre, email, fecha_registro, contraseña } = req.body;

  if (!nombre || !email || !contraseña) {
    return res.status(400).send('Todos los campos son obligatorios');
  }

  // Verificar si el correo electrónico ya está registrado
  connection.query('SELECT * FROM usuarios WHERE email = ?', [email], (err, results) => {
    if (err) {
      console.error('Error al verificar el email:', err);
      return res.status(500).send('Error al verificar el email');
    }

    if (results.length > 0) {
      return res.status(400).send('El correo electrónico ya está registrado');
    }

    // Si el correo no está registrado, encriptar la contraseña
    bcrypt.hash(contraseña, 10, (err, hashedPassword) => {
      if (err) {
        console.error('Error al encriptar la contraseña:', err);
        return res.status(500).send('Error al procesar la contraseña');
      }

      const query = 'INSERT INTO usuarios (nombre, email, fecha_registro, contraseña) VALUES (?, ?, ?, ?)';

      // Insertar los datos del usuario en la base de datos
      connection.query(query, [nombre, email, fecha_registro, hashedPassword], (err, results) => {
        if (err) {
          console.error('Error al insertar el usuario:', err);
          return res.status(500).send('Error al agregar el usuario');
        }
        res.status(201).send('Usuario agregado');
      });
    });
  });
});



  
// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
