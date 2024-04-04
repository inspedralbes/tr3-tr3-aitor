<template>
    <div class="user-profile">
        <div>
            <div class="flex-container">
                <div class="user-info-container">
                    <div class="input-container">
                        <label>Nom:</label>
                        <input type="text" name="nom" v-model="userData.name" :readonly="!editing">
                    </div>
                    <div class="input-container">
                        <label>Cognoms:</label>
                        <input type="text" name="cognoms" v-model="userData.surname" :readonly="!editing">
                    </div>
                    <div class="campo">
                        <label for="email">Correo electrónico:</label>
                        <input type="email" id="email" v-model="userData.email" :readonly="!editing">
                    </div>
                    <div class="campo">
                        <label for="password">Contraseña:</label>
                        <input type="password" id="password" v-model="userData.password" :readonly="!editing">
                    </div>
                    <div class="campo">
                        <label for="foto">Foto de perfil:</label>
                        <button @click="mostrarModal" :disabled="!editing">Seleccionar foto</button>
                        <span v-if="!foto_perfil && editing" style="color: red;">¡Selecciona una foto de perfil!</span>
                    </div>
                    <button v-if="!editing" class="large-button" @click="editProfile">Modificar perfil</button>
                    <button v-else class="large-button" @click="guardarDatosUsuario">Guardar</button>
                </div>
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
        <div class="user-actions">
            <ul>
                <img :src="userData.foto_perfil+ '.png'" alt="Foto de perfil">

                <h1>{{ userData.name }} {{ userData.surname }}</h1>
                <li><nuxt-link to="/perfil">Mi Perfil</nuxt-link></li>
                <li><nuxt-link to="/entradas">Mis Entradas</nuxt-link></li>
                <li><button @click="logout">Cerrar sesión</button></li>
            </ul>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            editing: false,
            modalAbierto: false,
            foto_perfil: null,
            userData: {
                name: '',
                surname: '',
                email: '',
                password: 'xxxxxx',
                foto_perfil: '' // Ruta por defecto para la foto de perfil
            }
        };
    },
    methods: {
        async fetchmostrarInformacion() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/usuari/${this.user.user.id}`, {
                    method: 'GET',
                });
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();
                // Asignar la URL de la foto de perfil obtenida de la respuesta del servidor
                this.userData.foto_perfil = data.foto_perfil;
                this.userData.name = data.nom;
                this.userData.surname = data.cognoms;
                this.userData.email = data.email;
                
            } catch (error) {
                console.error("Could not fetch sesiones: ", error);
            }
        },
        logout() {
            // Redirigir al usuario a la página deseada
            this.$router.push('/');
            localStorage.removeItem('user');
        },
        editProfile() {
            this.editing = true;
        },
        guardarDatosUsuario() {
            // Aquí debes enviar los datos del usuario al servidor para ser guardados
            this.editing = false;
        },
        mostrarModal() {
            this.modalAbierto = true;
        },
        cerrarModal() {
            this.modalAbierto = false;
        },
        seleccionarFoto(numero) {
            this.foto_perfil = `../public/${numero}.png`;
            this.userData.foto_perfil = this.foto_perfil;
            this.cerrarModal();
        },
    },
    computed: {
        user() {
            const userData = JSON.parse(localStorage.getItem('user'));
            return userData;
        }
    },
    mounted() {
        this.fetchmostrarInformacion();
    }
};
</script>
<style scoped>
.user-profile {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
}

.user-info-container {
    width: 50%;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.input-container {
    margin-bottom: 15px;
}

.input-container label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

.input-container input,
.input-container select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 3px;
}

.input-container select {
    width: calc(100% + 2px);
    /* Compensar el ancho del borde */
}

.large-button {
    padding: 10px 20px;
    background-color: red;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.user-actions ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.user-actions ul li {
    margin-bottom: 10px;
}

.user-actions img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin-right: 20px;
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
</style>
