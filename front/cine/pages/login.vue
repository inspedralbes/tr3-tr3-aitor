<template>
  <div class="page-container">
    <div class="login-form">
      <h2 class="form-title">Iniciar sesión</h2>
      <!-- Sección para mostrar mensajes de error -->
      <div class="mensaje-error" v-if="errorInicioSesion">{{ errorInicioSesion }}</div>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" v-model="email" required>
        </div>
        <div class="form-group2">
          <label for="password">Contraseña</label>
          <input :type="showPassword ? 'text' : 'password'" id="password" v-model="password" required>
          <button class="toggle-password" @click="togglePasswordVisibility">{{ showPassword ? 'Ocultar' :
            'Mostrar' }}</button>
        </div>
        <button type="submit" class="boton">Iniciar sesión</button>
      </form>
      <p>¿No tienes una cuenta? <router-link to="/registro">Regístrate aquí</router-link>.</p>
    </div>
  </div>
</template>

<script>
import { useUserStore } from '../stores/store'; // Importa el store de usuario de Pinia

export default {
  data() {
    return {
      email: '',
      password: '',
      errorInicioSesion: '', // Variable para almacenar el mensaje de error
      showPassword: false,

    };
  },
  methods: {
    togglePasswordVisibility() {
      this.showPassword = !this.showPassword;
    },
    async login() {
      try {
        const response = await fetch('http://tr3.a20aitbaresc.daw.inspedralbes.cat/back/api-cine/public/api/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            email: this.email,
            password: this.password
          })
        });

        if (!response.ok) {
          const errorData = await response.json();
          throw new Error(errorData.message || 'Error al iniciar sesión');
        }

        // Limpiar mensaje de error en caso de éxito
        this.errorInicioSesion = '';

        // Si el inicio de sesión es exitoso, almacena la información del usuario en Pinia
        const userData = await response.json();
        useUserStore().setUser(userData);

        // Guardar la información del usuario en localStorage
        localStorage.setItem('user', JSON.stringify(userData));

        // Redirigir a la página de inicio después del inicio de sesión exitoso
        this.$router.push('/');
        setTimeout(() => {
          window.location.reload();
        }, 5);
      } catch (error) {
        console.error('Error al iniciar sesión:', error);
        this.errorInicioSesion = error.message || 'Error al iniciar sesión';
      }
    }
  }
};
</script>

<style scoped>
.page-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 70vh;
  background-color: #000;
  font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;

}

.login-form {
  width: 100%;
  max-width: 400px;
  padding: 20px;
  background-color: #000;
}

.form-title {
  color: #fff;
  text-align: center;
}

.form-group {
  margin-bottom: 20px;
}

.form-group2 {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

label {
  display: block;
  margin-bottom: 5px;
  color: #fff;
}

input[type="email"],
input[type="password"] {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: #333;
  color: #fff;
}

button {
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: #f00;
  color: #fff;
  cursor: pointer;
  width: 100%;
}

button:hover {
  background-color: #c00;
}

p {
  margin-top: 20px;
  text-align: center;
  color: #fff;
  text-decoration: none;
}

router-link {
  color: #007bff;
  text-decoration: none;
  cursor: pointer;
}

router-link:hover {
  color: #0056b3;
}

a:-webkit-any-link {
  color: #f00;
  cursor: pointer;
  text-decoration: none;
}

.mensaje-error {
  color: red;
  margin-bottom: 10px;
}
</style>
