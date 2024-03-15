<template>
  <div class="centro">
    <h2 class="page-title">Películas</h2>
  </div>
  <div class="peliculas-container">
    

    <div class="peliculas-grid">
      <div v-for="pelicula in peliculas" :key="pelicula.id" class="pelicula-card">
        <img :src="pelicula.cartel" :alt="`Cartel de ${pelicula.titulo}`" class="pelicula-cartel">
        <div class="pelicula-info">
          <h2 class="pelicula-titulo">{{ pelicula.titulo }}</h2>
          <p class="pelicula-genero">{{ pelicula.genero }}</p>
          <p class="pelicula-duracion">Duración: {{ convertirDuracion(pelicula.duracion) }}</p>
        </div>
      </div>
    </div>
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
        this.peliculas = data.data;
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
.page-title {
  font-size: 2rem;
  color: var(--color-primary);
  text-align: center;
  margin-bottom: 50px;
}

.peliculas-container {
  max-width: 1200px; /* Hacer el contenedor más grande */
}

.peliculas-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* Mostrar 4 películas por fila */
  gap: 30px;
}

.pelicula-card {
  width: 300px; /* Ajustar el ancho de las tarjetas de película */
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
  margin-left: 40px;
  margin-bottom: 20px;
}

.pelicula-card:hover {
  transform: translateY(-5px);
}

.pelicula-cartel {
  width: 100%;
  height: auto;
  border-radius: 20px 20px 0 0;
}

.pelicula-info {
  padding: 20px;
}

.pelicula-titulo {
  font-size: 1.6rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.pelicula-genero,
.pelicula-duracion {
  font-size: 1.2rem;
  color: #666;
  margin-bottom: 5px;
}
</style>
