window.addEventListener('DOMContentLoaded', () => {


    document.getElementById('imagenEditarCrearReceta').addEventListener('click', function() {
        document.getElementById('imagenReceta').click();
    });

    document.getElementById('imagenReceta').addEventListener('change', function(event) {
        const file = event.target.files[0]; 

        if (file) {
            const reader = new FileReader(); 

            reader.onload = function(e) {
                const imagePreview = document.getElementById('imagePreview');
                imagePreview.src = e.target.result; 
            }

            reader.readAsDataURL(file); 
        }
    });


    // Apartado de enviar los datos

    
    // Evento para manejar el envío del formulario
    document.getElementById("crearReceta").addEventListener('click', async function (e) {
        e.preventDefault();

       

});




















    
})