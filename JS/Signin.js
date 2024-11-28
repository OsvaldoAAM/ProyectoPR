
document.getElementById("formularioRegistro").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevenir que el formulario se envíe de manera tradicional

    // Obtener los valores de los campos del formulario
    const nombre = document.getElementById("registroNombre").value;
    const email = document.getElementById("registroEmail").value;
    const contraseña = document.getElementById("registroContraseña").value;
    const confirmacionContraseña = document.getElementById("confirmacionContraseña").value;

    // Validaciones básicas en el frontend
    if (!nombre || !email || !contraseña || !confirmacionContraseña) {
        alert("Todos los campos son obligatorios.");
        return;
    }

    // Validar que las contraseñas coincidan
    if (contraseña !== confirmacionContraseña) {
        alert("Las contraseñas no coinciden.");
        return;
    }

    // Validar el formato del email (expresión regular básica)
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert("El correo electrónico no tiene un formato válido.");
        return;
    }

    // Validar la longitud de la contraseña
    if (contraseña.length < 6) {
        alert("La contraseña debe tener al menos 6 caracteres.");
        return;
    }

    const fecha_registro = new Date().toISOString().split('T')[0];  // Extraemos solo la parte de la fecha

    // Crear un objeto con los datos que vamos a enviar
    const userData = {
        nombre: nombre,
        email: email,
        fecha_registro: fecha_registro, 
        contraseña: contraseña
    };
    
    console.log(userData);

    fetch("http://localhost:3000/usuarios", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(userData) // Convertir el objeto a JSON
    })
    .then(response => {
        if (!response.ok) {
            return response.text().then(errorMessage => { throw new Error(errorMessage) });
        }
        return response.text();
    })
    .then(data => {
        // Mostrar un mensaje de éxito si la respuesta es positiva
        alert(data);
        // Limpiar el formulario
        document.getElementById("formularioRegistro").reset();
    })
    .catch(error => {
        // Mostrar el error si algo falla
        alert("Error: " + error.message);
    });
});

