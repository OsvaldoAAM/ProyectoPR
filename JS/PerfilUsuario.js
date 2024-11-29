window.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token');
 
    if (!token) {
        mostrarNavbarNoAutenticado();

        //Funcionalidad proxima, eliminar el contenido de la página y mostrar "Inicia sesion para acceder"
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
            mostrarDatosUsuario(data.user);
          console.log(data.user)
        } else {
          //Eliminar el contenido de la página y mostrar un "Inicie sesión de nuevo para acceder"
        }
      })
      .catch(error => {
        console.error('Error al verificar autenticación:', error);
        mostrarNavbarNoAutenticado(); 
      });
})

function mostrarDatosUsuario(user){
    document.getElementById('nombreUsuario').innerText = `${user.nombre}`;
}