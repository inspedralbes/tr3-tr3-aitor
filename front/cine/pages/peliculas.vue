<template>
    <div class="peliculas-container">
      <h1>Películas</h1>
      <ul class="peliculas-list">
        <li v-for="pelicula in peliculas" :key="pelicula.id" class="pelicula-item">
          <img :src="pelicula.cartel" :alt="`Cartel de ${pelicula.titulo}`" class="pelicula-cartel">
          <div class="pelicula-info">
            <span class="pelicula-titulo">{{ pelicula.titulo }}</span>
            <span class="pelicula-duracion">Duración: {{ convertirDuracion(pelicula.duracion) }}</span>
          </div>
        </li>
      </ul>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        peliculas: [],
      };
    },
    async mounted() {
      await this.fetchPeliculas();
    },
    methods: {
      async fetchPeliculas() {
        try {
          const response = await fetch('http://127.0.0.1:8000/api/listarPeliculas');
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          const data = await response.json();
          this.peliculas = data.data; // Asegúrate de adaptar esta línea según la estructura de tu respuesta de API
        } catch (error) {
          console.error("Could not fetch peliculas: ", error);
        }
      },
      convertirDuracion(minutos) {
        const horas = Math.floor(minutos / 60);
        const minutosRestantes = minutos % 60;
        return `${horas}h ${minutosRestantes}min`;
      }
    }
  };
  </script>
  
  <style scoped>
  .peliculas-container {
    max-width: 800px;
    margin: 0 auto;
  }
  
  .peliculas-list {
    list-style: none;
    padding: 0;
  }
  
  .pelicula-item {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
  }
  
  .pelicula-cartel {
    width: 150px;
    height: auto;
    margin-right: 20px;
  }
  
  .pelicula-info {
    flex: 1;
  }
  
  .pelicula-titulo {
    font-size: 1.2rem;
    font-weight: bold;
  }
  
  .pelicula-duracion {
    font-size: 1rem;
    color: #666;
  }
  </style>
  