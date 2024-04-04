<template>
    <div class="user-profile">
        <div class="flex-container">
            <div class="user-info-container">
                <div class="input-container">
                    <label>Nom:</label>
                    <input type="text" name="nom" v-model="userData.nom" :disabled="!editing" disabled>
                </div>
                <div class="input-container">
                    <label>Cognoms:</label>
                    <input type="text" name="cognoms" v-model="userData.cognoms" :disabled="!editing" disabled>
                </div>
                <div class="input-container">
                    <label for="email">Correo electrónico:</label>
                    <input type="email" id="email" v-model="userData.email" :disabled="!editing" >
                </div>
                <div class="input-container">
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" :data-real-password="userData.password" v-model="fakePassword"
                        :readonly="!editarContraseña"disabled>
                </div>
                <div class="input-container">
                    <label for="foto">Foto de perfil:</label>
                    <button @click="mostrarModal" :disabled="!editing">Seleccionar foto</button>
                </div>
                <button v-if="!editing" class="large-button" @click="editProfile">Modificar perfil</button>
                <button v-else class="large-button" @click="guardarDatosUsuario">Guardar</button>
            </div>
            <div class="user-actions">
                <ul>
                    <img :src="userData.foto_perfil + '.png'" alt="Foto de perfil">
                    <h1>{{ userData.nom }} {{ userData.cognoms }}</h1>
                    <li><nuxt-link to="/perfil">Mi Perfil</nuxt-link></li>
                    <li><nuxt-link to="/entradas">Mis Entradas</nuxt-link></li>
                    <li><button @click="logout">Cerrar sesión</button></li>
                </ul>
            </div>
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
</template>

<script>
export default {
    data() {
        return {
            editing: false,
            editarContraseña: false,
            modalAbierto: false,
            foto_perfil: null,
            fakePassword: 'xxxxxxxx', // Utilizado para mostrar una contraseña falsa

            userData: {
                nom: '',
                cognoms: '',
                email: '',
                password: '',
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
                this.userData = data;
            } catch (error) {
                console.error("Could not fetch sesiones: ", error);
            }
        },
        async guardarDatosUsuario() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/modificarUsuario/${this.user.user.id}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(this.userData)
                });
                const userData = await response.json();

                localStorage.removeItem('user');
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                console.log("Usuario actualizado correctamente");

                localStorage.setItem('user', JSON.stringify(userData));
                this.$router.push('/');

                setTimeout(() => {
                    window.location.reload();
                }, 5);

                // Actualizar el usuario en el localStorage
            } catch (error) {
                console.error("Could not update user: ", error);
            }

            this.editing = false; // Desactiva el modo de edición después de guardar los datos
        },
        logout() {
            // Redirigir al usuario a la página deseada
            this.$router.push('/');

            // Limpiar el localStorage y recargar la página actual en segundo plano
            setTimeout(() => {
                localStorage.removeItem('user');
                window.location.reload();
            }, 5);
        },
        editProfile() {
            this.editing = true;
        },
        mostrarModal() {
            this.modalAbierto = true;
        },
        cerrarModal() {
            this.modalAbierto = false;
        },
        seleccionarFoto(numero) {
            if (!this.foto_perfil) {
                this.foto_perfil = `../public/${numero}.png`;
                this.userData.foto_perfil = this.foto_perfil;
            }
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
  margin: 20px;
}

.flex-container {
  display: grid;
  grid-template-columns: 2fr 1fr;
  grid-gap: 20px;
  
}

.user-info-container {
    width: 70%;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    height: 400px;
}

.input-container {
  margin-bottom: 15px;
  font-size: 20px;
}

.input-container label {
  font-weight: bold;
  margin-bottom: 5px;
}

.input-container input {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

.large-button {
    padding: 10px 20px;
  background-color: red;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  text-align: center;
  margin: 0 auto; /* Para centrar horizontalmente */
  display: block; /* Hacer que el botón ocupe todo el ancho disponible */
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

.modal .opciones img:hover {
  border: 2px solid #007bff;
  transform: scale(1.1);
}

.opciones .fila-imagenes {
  display: flex;
  justify-content: space-around;
  margin-bottom: 10px;
}
.input-container input:disabled {
  background-color: #f0f0f0; /* Color de fondo gris claro */
  color: #666; /* Color de texto gris */
  cursor: not-allowed; /* Cambiar el cursor a no permitido */

}
.input-container button {
  padding: 10px 20px;
  background-color: red;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  text-align: center;
  margin: 0 auto; /* Para centrar horizontalmente */
  display: block; /* Hacer que el botón ocupe todo el ancho disponible */
}
.input-container button:disabled {
  background-color: #ccc; /* Color de fondo gris claro */
  color: #666; /* Color de texto gris */
  cursor: not-allowed; /* Cambiar el cursor a no permitido */
}
</style>
