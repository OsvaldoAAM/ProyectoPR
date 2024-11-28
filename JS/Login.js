document.getElementById("formularioIniciarSesion").addEventListener("submit", function (event) {
    event.preventDefault();  

    const email = document.getElementById("ingresoCorreo").value;
    const password = document.getElementById("ingresoContraseña").value;

    if (!email || !password) {
        alert("Por favor ingresa ambos campos: correo y contraseña.");
        return;
    }

    const userData = {
        email: email,
        contraseña: password
    };

    console.log(email,password)
    fetch("http://localhost:3000/login", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"  
        },
        body: JSON.stringify(userData)  
    }).then(response => response.json())  
    .then(data => {
        if (data.token) {
            // Si el login es exitoso y recibimos un token
            localStorage.setItem('token', data.token);  // Guardamos el token en el almacenamiento local

            alert("Inicio de sesión exitoso");

            
            window.location.href = "Index.html";  // Cambia esta URL a la página que desees
        } else {
            // Si no se obtiene un token, mostrar un mensaje de error
            alert(data.message || "Hubo un error al iniciar sesión.");
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("Hubo un error en la solicitud. Intenta nuevamente.");
    });

   

});



