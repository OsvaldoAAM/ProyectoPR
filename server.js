// Importa el módulo de MySQL y Express
const mysql = require('mysql2');
const express = require('express');
const path = require('path');

// Crea una aplicación de Express
const app = express();

// Establece el puerto en el que el servidor escuchará
const PORT = process.env.PORT || 3000;

// Configuración de la conexión a MySQL
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',       // tu usuario de MySQL
  password: '1234', // tu contraseña de MySQL
  database: 'sitiorecetas' // tu base de datos
});

// Conexión a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos: ', err);
    return;
  }
  console.log('Conexión exitosa a MySQL');
});

// Sirve los archivos estáticos (como el HTML)
app.use(express.static(path.join(__dirname, 'public')));

// Ruta de ejemplo para obtener datos de la base de datos
app.get('/api/usuarios', (req, res) => {
  connection.query('SELECT * FROM usuarios', (err, results) => {
    if (err) {
      console.error('Error en la consulta: ', err);
      return res.status(500).send('Error en la consulta');
    }
    res.json(results); // Envía los resultados de la consulta en formato JSON
  });
});
app.get('/', (req, res) => {
    res.send('¡Hola, mundo! Mi servidor está funcionando.');
  });
  

// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
