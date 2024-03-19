<template>
    <div>
      <h1>Sesiones de Cine</h1>
      <div v-for="sesion in sesiones" :key="sesion.id" class="sesion-card" @click="mostrarModal(sesion)">
        <div class="sesion-info">
          <h2 class="sesion-fecha">{{ sesion.fecha }}</h2>
          <p class="sesion-dia-espectador">Día del espectador: {{ sesion.diaEspectador ? 'Sí' : 'No' }}</p>
          <h3>Película:</h3>
          <p>{{ sesion.pelicula.titulo }}</p>
          <!-- Mostrar más detalles de la película si es necesario -->
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        sesiones: [],
        modalAbierto: false,
        sesionSeleccionada: null
      };
    },
    async mounted() {
      await this.fetchSesiones();
    },
    methods: {
      async fetchSesiones() {
        try {
          const response = await fetch('http://127.0.0.1:8000/api/listarSesiones');
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          const data = await response.json();
          this.sesiones = data.data;
        } catch (error) {
          console.error("Could not fetch sesiones: ", error);
        }
      },
      mostrarModal(sesion) {
        this.sesionSeleccionada = sesion;
        this.modalAbierto = true;
      },
      cerrarModal() {
        this.modalAbierto = false;
        this.sesionSeleccionada = null;
      }
    }
  };
  </script>
  
  <style scoped>
  /* Estilos para las tarjetas de sesiones */
  .sesion-card {
    width: 300px;
    /* Ajustar el ancho de las tarjetas de sesión */
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
  }
  
  .sesion-card:hover {
    transform: translateY(-5px);
  }
  
  .sesion-info {
    padding: 20px;
  }
  
  .sesion-fecha {
    font-size: 1.6rem;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
  }
  
  .sesion-dia-espectador {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 5px;
  }
  </style>
  