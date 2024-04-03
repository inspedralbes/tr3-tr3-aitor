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

        <!-- Mostrar el botón de Login si el usuario no está logeado -->
        <li v-if="!user" style="float:right">
          <nuxt-link to="/login">Login</nuxt-link>
        </li>

        <!-- Mostrar la foto de perfil y el nombre del usuario si está logeado -->
        <li v-if="user" style="float:right">
          <img :src="user.user.foto_perfil+ '.png'" alt="Foto de perfil">
          <span>{{ user.user.nom }}</span>
        </li>

        <!-- Mostrar opciones adicionales si el usuario no está logeado -->
        <li v-if="!user" style="float:right" @mouseover="mostrarOpciones = true" @mouseleave="mostrarOpciones = false">
          <div v-if="mostrarOpciones" class="opciones-adicionales">
            <nuxt-link to="/registro">Registro</nuxt-link>
          </div>
        </li>
      </ul>
    </nav>
  </div>
</template>


<script>
import { useUserStore } from '../stores/store'; // Importa el store de usuario de Pinia

export default {
  data() {
    return {
      mostrarOpciones: false // Variable para controlar la visualización de las opciones adicionales
    };
  },
  computed: {
    user() {
      return useUserStore().user; // Accede al estado del usuario desde el store de Pinia
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
  width: 40px; /* Ajusta el ancho de la imagen de perfil según sea necesario */
  height: 40px; /* Ajusta la altura de la imagen de perfil según sea necesario */
  margin-right: 5px; /* Ajusta el margen derecho para separar la imagen del nombre de usuario */
}

/* Estilos para el nombre de usuario */
.nav li span {
  color: white; /* Color del texto */
  margin-right: 20px;
}

</style>
