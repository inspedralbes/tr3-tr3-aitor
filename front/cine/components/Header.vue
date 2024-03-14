<template>
    <header class="container-header">
      <img src="../public/hola.jpg" alt="El Rincón del hombre mosca logo">
      <p class="paragraph-header">Cine, música y algo de arte. La cabeza del hombre mosca</p>
      <nav class="nav">
        <ul>
          <li id="home"><a href="">Home</a></li>
          <li><a href="">Peliculas</a></li>
          <li><a href="">Catalogo</a></li>
          <li><a href="">Novedades</a></li>
          <li><a href="">Trailers</a></li>
          <li style="float:right"><a href="#about">Login</a></li>
        </ul>
      </nav>
    </header>
  </template>
  
  <script>
  export default {
    // Opciones del componente, si es necesario
  }
  </script>
  
  <style scoped>
  body {
    background-image: url("http://3.bp.blogspot.com/-LuEXvYzBnqU/VTKVi3K7FxI/AAAAAAAAAD4/ks4SrvUR_5Y/s0/fondo.jpg");
    color: white;
    font-family: "Courier New", "Courier", monospace;
  }
  
  .container-header {
    text-align: center;
    background-color: black;
    padding: 1%;
  }
  
  .paragraph-header {
    padding-bottom: 1em;
  }
  
  .nav {
    background-color: #333;
    padding: 10px 0; /* Aumento del espacio interno del menú */
    display: flex; /* Cambio a flexbox para alinear los elementos */
    justify-content: center; /* Centra los elementos horizontalmente */
  }
  
  .nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    display: flex; /* Cambio a flexbox para alinear los elementos */
  }
  
  .nav li {
    border-right: 1px solid #bbb;
  }
  
  .nav li:last-child {
    border-right: none;
    margin-right: 0; /* Elimina el margen derecho del último elemento */
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
  </style>
  