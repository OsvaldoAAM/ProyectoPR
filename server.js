// Importa modulos requeridos
const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const bcrypt = require('bcryptjs');
const cors = require('cors');
const jwt = require('jsonwebtoken');
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

  connection.query('SELECT * FROM usuarios WHERE email = ?', [email], (err, results) => {
    if (err) {
      console.error('Error al verificar el email:', err);
      return res.status(500).send('Error al verificar el email');
    }

    if (results.length > 0) {
      return res.status(400).send('El correo electrónico ya está registrado');
    }

    bcrypt.hash(contraseña, 10, (err, hashedPassword) => {
      if (err) {
        console.error('Error al encriptar la contraseña:', err);
        return res.status(500).send('Error al procesar la contraseña');
      }

      const query = 'INSERT INTO usuarios (nombre, email, fecha_registro, contraseña) VALUES (?, ?, ?, ?)';

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

// Ruta para iniciar sesión
app.post('/login', (req, res) => {
  const { email, contraseña } = req.body;

  if (!email || !contraseña) {
      return res.status(400).send('Por favor, ingrese ambos campos (email y contraseña).');
  }

  // Buscar el usuario por el email
  const query = 'SELECT * FROM usuarios WHERE email = ?';
  connection.query(query, [email], (err, results) => {
      if (err) {
          console.error('Error en la consulta a la base de datos:', err);
          return res.status(500).send('Error en el servidor');
      }

      // Verificar si el usuario existe
      if (results.length === 0) {
          return res.status(400).send('El correo electrónico no está registrado.');
      }

      // Comparar la contraseña proporcionada con el hash almacenado
      const user = results[0];  

      bcrypt.compare(contraseña, user.contraseña, (err, isMatch) => {
        if (err) {
            console.error('Error al comparar las contraseñas:', err);
            return res.status(500).send('Error en el servidor');
        }

        if (!isMatch) {
            return res.status(400).send('La contraseña es incorrecta.');
        }

        // Generar un token JWT (ahora incluyendo el nombre del usuario)
        const token = jwt.sign(
            { 
                id: user.id, 
                nombre: user.nombre,  
                email: user.email 
            }, 
            'secreto_jwt', 
            { expiresIn: '30d' }
        );

        // Enviar el token al cliente
        res.json({ message: 'Inicio de sesión exitoso', token: token });
    });
  });
});


function verificarToken(req, res, next) {
  const token = req.headers['authorization']; // El token se envía en el encabezado "Authorization"

  if (!token) {
    return res.status(403).json({ authenticated: false });
  }

  // Verificar el token
  jwt.verify(token, 'secreto_jwt', (err, decoded) => {
    if (err) {
      return res.status(403).json({ authenticated: false });
    }

    // Si el token es válido, decodificamos la información y la pasamos al siguiente middleware
    req.user = decoded; // Los datos del usuario están en decoded (puedes tener el nombre, id, etc.)
    next(); // Continuamos con la ejecución
  });
}

// Ruta protegida para verificar autenticación
app.get('/autenticacion', verificarToken, (req, res) => {
  // Si el token es válido, devolvemos la información del usuario
  res.json({ authenticated: true, user: req.user });
});



  
// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
