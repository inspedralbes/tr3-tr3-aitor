<template>
    <div>
      <header>
        <img src="../public/logo.jpg" alt="Can Casteller" class="header-img">
        <p class="paragraph-header">El cine que todo el mundo quiere estar, está aquí</p>
      </header>
      <nav class="nav">
        <ul>
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
          <!-- Mostrar opciones adicionales al pasar el mouse sobre "Login" -->
          <li style="float:right" @mouseover="mostrarOpciones = true" @mouseleave="mostrarOpciones = false">
            <nuxt-link to="/login">Login</nuxt-link>
            <!-- Opciones adicionales -->
            <div v-if="mostrarOpciones" class="opciones-adicionales">
              <nuxt-link to="/registro">Registro</nuxt-link>
            </div>
          </li>
        </ul>
      </nav>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        mostrarOpciones: false // Variable para controlar la visualización de las opciones adicionales
      };
    }
  };
  </script>

<style scoped>
body{
    margin: 0;

}
header {
    text-align: center;
    background-color: black;
    padding: 10px;
    margin: 0;
}

.header-img {
    height: 30vh; /* Cambia la altura de la imagen del encabezado según sea necesario */
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

/* Estilos para los enlaces cuando se pasan sobre ellos */
.opciones-adicionales a:hover {
  background-color: #f5f5f5;
}
</style>
