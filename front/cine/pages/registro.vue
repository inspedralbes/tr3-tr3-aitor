<template>
    <div class="page-container">
        <div class="registro">
            <h2 class="form-title">Registro</h2>
            <form @submit.prevent="submitRegistro">
                <div class="campo">
                    <label for="nom">Nombre:</label>
                    <input type="text" id="nom" v-model="nom" required>
                </div>
                <div class="campo">
                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" v-model="cognoms" required>
                </div>
                <div class="campo">
                    <label for="email">Correo electrónico:</label>
                    <input type="email" id="email" v-model="email" required>
                </div>
                <div class="campo">
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" v-model="password" required>
                </div>
                <div class="campo">
                    <label for="foto">Foto de perfil:</label>
                    <button @click="mostrarModal">Seleccionar foto</button>
                    <span v-if="!foto_perfil" style="color: red;">¡Selecciona una foto de perfil!</span>
                </div>
                <button type="submit">Registrarse</button>
            </form>
            <p>¿Ya tienes una cuenta? <router-link to="/login">Logueate aquí</router-link>.</p>
            <!-- Modal de selección de imagen -->
            <div class="modal" v-bind:class="{ 'abierto': modalAbierto }">
                <div class="contenido">
                    <span class="cerrar" @click="cerrarModal">&times;</span>
                    <h2>Seleccionar foto de perfil</h2>
                    <div class="opciones">
                        <div class="fila-imagenes">
                            <img src="../public/1.png" alt="Foto 1" @click="seleccionarFoto(1)">
                            <img src="../public/2.png" alt="Foto 2" @click="seleccionarFoto(2)">
                            <img src="../public/3.png" alt="Foto 3" @click="seleccionarFoto(3)">
                        </div>
                        <div class="fila-imagenes">
                            <img src="../public/4.png" alt="Foto 4" @click="seleccionarFoto(4)">
                            <img src="../public/5.png" alt="Foto 5" @click="seleccionarFoto(5)">
                            <img src="../public/6.png" alt="Foto 6" @click="seleccionarFoto(6)">
                        </div>
                        <div class="fila-imagenes">
                            <img src="../public/7.png" alt="Foto 7" @click="seleccionarFoto(7)">
                            <img src="../public/8.png" alt="Foto 8" @click="seleccionarFoto(8)">
                            <img src="../public/9.png" alt="Foto 9" @click="seleccionarFoto(9)">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { useUserStore } from '../stores/store'; // Importa el store de usuario de Pinia

export default {
    data() {
        return {
            nom: '',
            cognoms: '',
            email: '',
            password: '',
            foto_perfil: null, // Usaremos null para indicar que aún no se ha seleccionado ninguna foto
            modalAbierto: false
        };
    },
    methods: {
        mostrarModal() {
            this.modalAbierto = true;
        },
        cerrarModal() {
            this.modalAbierto = false;
        },
        seleccionarFoto(numero) {
            this.foto_perfil = numero;
            this.cerrarModal(); // Cerrar el modal después de seleccionar una foto
        },
        async submitRegistro() {
            try {
                // Verificar si se ha seleccionado una foto de perfil
                if (!this.foto_perfil) {
                    return;
                }

                // Enviar el formulario
                const response = await fetch('http://127.0.0.1:8000/api/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        nom: this.nom,
                        cognoms: this.cognoms,
                        email: this.email,
                        password: this.password,
                        foto_perfil: this.foto_perfil
                    })
                });

                if (!response.ok) {
                    const errorData = await response.json();
                    throw new Error(errorData.message || 'Error al registrar el usuario');
                }

                // Obtener la información del usuario desde la respuesta del servidor
                const userData = await response.json();

                // Almacenar la información del usuario en el localStorage
                localStorage.setItem('userData', JSON.stringify(userData));

                // Redirigir a la página de inicio después del registro exitoso
                this.$router.push('/');

            } catch (error) {
                console.error('Error al registrar:', error);
            }
        }

    },
};
</script>
<style scoped>
/* Estilos generales */
.page-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh;
    background-color: #000;
}

.registro {
    width: 100%;
    max-width: 400px;
    padding: 20px;
    background-color: #000;
    color: #fff;
}

.form-title {
    color: #fff;
    text-align: center;
}

.campo {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

input[type="text"],
input[type="email"],
input[type="password"],
select {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    background-color: #333;
    color: #fff;
}

button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 3px;
    background-color: #f00;
    color: #fff;
    cursor: pointer;
}

button:hover {
    background-color: #c00;
}

/* Estilos para el modal */
.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 9999;
    display: none;
    justify-content: center;
    align-items: center;
}

.modal.abierto {
    display: flex;
}

.modal .contenido {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    position: relative;
}

.modal .contenido .cerrar {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 20px;
    color: #888;
}

.modal h2 {
    margin-top: 0;
}

.modal .opciones img {
    width: 150px;
    height: 150px;
    margin-left: 10px;
    margin-right: 10px;
    margin-bottom: 10px;
    border-radius: 50%;
    cursor: pointer;
    transition: transform 0.3s ease;
}

.modal .opciones img:last-child {
    margin-right: 0;
}

/* Estilo para las imágenes cuando se hace hover sobre ellas */
.modal .opciones img:hover {
    border: 2px solid #007bff;
    transform: scale(1.1);
}

/* Estilo para las filas de imágenes */
.opciones .fila-imagenes {
    display: flex;
    justify-content: space-around;
    margin-bottom: 10px;
}

p {
    margin-top: 20px;
    text-align: center;
    color: #fff;
    text-decoration: none;
}

a:-webkit-any-link {
    color: #f00;
    cursor: pointer;
    text-decoration: none;
}
</style>