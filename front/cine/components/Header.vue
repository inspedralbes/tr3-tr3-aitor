<template>
  <div>
    <header>
      <img src="../public/logo.jpg" alt="Can Casteller" class="header-img">
      <p class="paragraph-header">El cine que todo el mundo quiere estar, está aquí</p>
    </header>
    <nav class="nav">
      <ul>
        <!-- Enlaces de navegación -->
        <li id="home">
          <nuxt-link to="/"><img src="../public/casa.png" alt="Home"></nuxt-link>
        </li>
        <li>
          <nuxt-link to="/peliculas">Peliculas</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/sesiones">Sesiones</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/novedades">Novedades</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/trailers">Trailers</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/contactanos">Contactanos</nuxt-link>
        </li>

        <li v-if="user" style="float:right">
          <div class="grid-container" @mouseenter="showOptions = true" @mouseleave="showOptions = false">
            <div class="grid-item">
              <img :src="user.user.foto_perfil + '.png'" alt="Foto de perfil">
              <span>{{ user.user.nom }}</span>
            </div>
            <div class="grid-item" v-show="showOptions">
              <nuxt-link to="/perfil">Perfil</nuxt-link>
            </div>
            <div v-if="user && user.user.id === 1" class="grid-item"v-show="showOptions">
              <nuxt-link to="/admin">Admin</nuxt-link>
            </div>
            <div class="grid-item" v-show="showOptions">
              <nuxt-link to="/entradas">Mis entradas</nuxt-link>
            </div>
            <div class="grid-item" v-show="showOptions">
              <button @click.stop="logout" class="logout-button">Cerrar sesión</button>
            </div>
          </div>
        </li>
        <!-- Mostrar el apartado de login si el usuario no está logeado -->
        <li v-else style="float:right">
          <div @mouseover="mostrarOpciones = true" @mouseleave="mostrarOpciones = false">
            <nuxt-link to="/login">Login</nuxt-link>
            <ul v-if="mostrarOpciones">
              <li>
                <nuxt-link to="/registro">Registro</nuxt-link>
              </li>
            </ul>
          </div>
        </li>

        <!-- Mostrar apartado "Admin" si el id_usuario es 1 -->

      </ul>
    </nav>
  </div>
</template>

<script>
export default {
  data() {
    return {
      mostrarOpciones: false,
      showOptions: false
    };
  },
  computed: {
    user() {
      // Obtener la información del usuario almacenada en localStorage
      const userData = JSON.parse(localStorage.getItem('user'));
      return userData;
    }
  },
  methods: {
    logout() {
      // Redirigir al usuario a la página deseada
      this.$router.push('/');

      // Limpiar el localStorage y recargar la página actual en segundo plano
      setTimeout(() => {
        localStorage.removeItem('user');
        window.location.reload();
      }, 5);
    }
  }
};
</script>


<style scoped>
body {
  margin: 0;

}

header {
  text-align: center;
  background-color: black;
  padding: 10px;
  margin: 0;
  font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
}

.header-img {
  height: 30vh;
  /* Cambia la altura de la imagen del encabezado según sea necesario */
}

.paragraph-header {
  padding-bottom: 1em;
  color: white;
}

.nav ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: black;
font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif
}

.nav li {
  float: left;
}

.nav li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.nav li a:hover {
  background-color: red;
}

.nav li:first-child {
  border-right: 1px solid #bbb;
}

.nav li:last-child {
  border-left: 1px solid #bbb;
}

.nav li a img {
  width: 20px;
  height: auto;
}

.opciones-adicionales {
  position: absolute;
  right: 0;
  background-color: black;
  color: white;
  border-top: none;
  padding: 10px;
}

/* Estilos para los enlaces dentro de las opciones adicionales */
.opciones-adicionales a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.opciones-adicionales a:hover {
  background-color: #f5f5f5;
}

.nav li img {
  width: 50px;
  /* Ajusta el ancho de la imagen de perfil según sea necesario */
  height: 50px;
  /* Ajusta la altura de la imagen de perfil según sea necesario */
  margin-right: 5px;
  /* Ajusta el margen derecho para separar la imagen del nombre de usuario */
}

/* Estilos para el nombre de usuario */
.nav li span {
  color: white;
  font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
  margin-right: 20px;
}

.grid-container {
  display: grid;
  grid-template-columns: 1fr;
  align-items: center;
  gap: 10px;
}

.grid-item {
  padding: 5px;
  text-align: center;
}

.logout-button {
  padding: 10px 20px;
  background-color: red;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  text-align: center;
  margin: 0 auto;
  display: block;
}

.logout-button:hover {
  background-color: #c00;
}
</style>
