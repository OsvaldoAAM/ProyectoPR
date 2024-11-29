window.addEventListener('DOMContentLoaded', () => {



















    document.getElementById('imagenEditarCrearReceta').addEventListener('click', function() {
        document.getElementById('imagenReceta').click();
    });

    document.getElementById('imagenReceta').addEventListener('change', function(event) {
        const file = event.target.files[0]; // Obtenemos el archivo seleccionado

        if (file) {
            const reader = new FileReader(); // Creamos un lector de archivos

            reader.onload = function(e) {
                const imagePreview = document.getElementById('imagePreview');
                imagePreview.src = e.target.result; // Establecemos la fuente de la imagen de vista previa
            }

            reader.readAsDataURL(file); // Leemos el archivo como una URL de datos (base64)
        }
    });

    
})