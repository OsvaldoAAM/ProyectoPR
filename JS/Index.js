// Comprobar si el usuario está autenticado al cargar la página principal
window.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token'); // Obtener el token de localStorage
  
    if (!token) {
      mostrarNavbarNoAutenticado();
      return;
    }
  
   
    fetch('http://localhost:3000/autenticacion', {
      method: 'GET',
      headers: {
        'Authorization': token 
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.authenticated) {
        mostrarNavbarAutenticado(data.user); 
        console.log(data.user)
      } else {
        mostrarNavbarNoAutenticado(); 
      }
    })
    .catch(error => {
      console.error('Error al verificar autenticación:', error);
      mostrarNavbarNoAutenticado(); 
    });
    
  });
  
  // Función para mostrar el navbar cuando el usuario no está autenticado
  function mostrarNavbarNoAutenticado() {
    document.getElementById('optionWithoutAccount').style.display = 'flex';
    document.getElementById('optionWithAccount').style.display = 'none';
  }
  
  // Función para mostrar el navbar cuando el usuario está autenticado
  function mostrarNavbarAutenticado(user) {
    document.getElementById('optionWithoutAccount').style.display = 'none';
    document.getElementById('optionWithAccount').style.display = 'flex';
  
    // Mostrar el nombre del usuario o cualquier otra información relevante
    document.getElementById('leyendaSesionIniciada').innerText = `Bienvenido, ${user.nombre}`;
  }
  