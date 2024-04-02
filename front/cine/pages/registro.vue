<template>
    <div class="registro">
      <h1>Registro</h1>
      <form @submit.prevent="submitRegistro">
        <div class="campo">
          <label for="email">Correo electrónico:</label>
          <input type="email" id="email" v-model="registro.email" required>
        </div>
        <div class="campo">
          <label for="password">Contraseña:</label>
          <input type="password" id="password" v-model="registro.password" required>
        </div>
        <div class="campo">
          <label for="nombre">Nombre:</label>
          <input type="text" id="nombre" v-model="registro.nombre" required>
        </div>
        <div class="campo">
          <label for="apellido">Apellido:</label>
          <input type="text" id="apellido" v-model="registro.apellido" required>
        </div>
        <div class="campo">
          <label for="foto">Foto de perfil:</label>
          <button @click="mostrarModal">Seleccionar foto</button>
        </div>
        <button type="submit">Registrarse</button>
      </form>
  
      <!-- Modal de selección de imagen -->
      <div class="modal" :class="{ 'abierto': modalAbierto }">
        <div class="contenido">
          <span class="cerrar" @click="cerrarModal">&times;</span>
          <h2>Seleccionar foto de perfil</h2>
          <div class="opciones">
            <img src="../public/icoshin.png" alt="Foto 1" @click="seleccionarFoto(1)">
            <img src="../public/icodoraemon.png" alt="Foto 2" @click="seleccionarFoto(2)">
            <img src="../public/icowalle.png" alt="Foto 3" @click="seleccionarFoto(3)">
            <img src="../public/icospiderman.png" alt="Foto 4" @click="seleccionarFoto(4)">
            <img src="../public/icoant.png" alt="Foto 5" @click="seleccionarFoto(5)">
            <img src="../public/icogroot.png" alt="Foto 6" @click="seleccionarFoto(6)">
            <img src="../public/icocars.png" alt="Foto 7" @click="seleccionarFoto(7)">
            <img src="../public/icohomer.png" alt="Foto 8" @click="seleccionarFoto(8)">
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        registro: {
          email: '',
          password: '',
          nombre: '',
          apellido: '',
          fotoPerfil: null // Usaremos null para indicar que aún no se ha seleccionado ninguna foto
        },
        modalAbierto: false
      };
    },
    methods: {
      submitRegistro() {
        console.log('Datos de registro:', this.registro);
        // Aquí podrías enviar los datos de registro a tu servidor
      },
      mostrarModal() {
        this.modalAbierto = true;
      },
      cerrarModal() {
        this.modalAbierto = false;
      },
      seleccionarFoto(numero) {
        this.registro.fotoPerfil = numero;
        this.cerrarModal(); // Cerrar el modal después de seleccionar una foto
      }
    }
  };
  </script>
  <style scoped>
  .registro {
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
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
    border: 1px solid #ccc;
    border-radius: 3px;
  }
  
  button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 3px;
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
  }
  
  button:hover {
    background-color: #0056b3;
  }
  
  /* Estilos para el modal */
  .modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* Fondo semitransparente */
    z-index: 9999;
    display: none;
    justify-content: center;
    align-items: center;
  }
  
  .modal.abierto {
    display: flex; /* Mostrar el modal cuando está abierto */
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
    width: 100px;
    margin-right: 10px;
    cursor: pointer;
  }
  
  .modal .opciones img:last-child {
    margin-right: 0;
  }
  
  /* Estilo para las imágenes cuando se hace hover sobre ellas */
  .modal .opciones img:hover {
    border: 2px solid #007bff; /* Cambia el color del borde al color deseado */
    border-radius: 5px; /* Agrega un borde redondeado */
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5); /* Agrega una sombra al hacer hover */
  }
  </style>