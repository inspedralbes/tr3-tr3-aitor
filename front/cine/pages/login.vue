<template>
  <div class="page-container">
    <div class="login-form">
      <h2 class="form-title">Iniciar sesión</h2>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" v-model="email" required>
        </div>
        <div class="form-group">
          <label for="password">Contraseña</label>
          <input type="password" id="password" v-model="password" required>
        </div>
        <button type="submit">Iniciar sesión</button>
      </form>
      <p>¿No tienes una cuenta? <router-link to="/registro">Regístrate aquí</router-link>.</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: '',
      password: ''
    };
  },
  methods: {
    login() {
      // Aquí puedes implementar la lógica de inicio de sesión
      console.log('Iniciando sesión con', this.email, this.password);
      // Redirigir a la página inicial después de iniciar sesión
      this.$router.push('/');
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
</style>
