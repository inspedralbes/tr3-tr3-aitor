<template>
  <div>
    <h2>Novedades de Películas</h2>
    <div v-if="loading" class="loading">Cargando...</div>
    <div v-else class="movies-container">
      <article v-for="movie in sortedMovies" :key="movie.id" class="movie-card">
        <div class="movie-poster-wrapper">
          <img :src="`${movie.poster}`" :alt="movie.title" class="movie-poster">
        </div>
        <div class="movie-info">
          <h3 class="movie-title">{{ movie.title }}</h3>
          <p class="movie-synopsis">{{ movie.sinopsis }}</p>
          <p class="movie-release">Fecha de lanzamiento: {{ movie.estreno }}</p>
        </div>
      </article>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      movies: [],
      loading: false
    };
  },
  async mounted() {
    await this.fetchNovedades();
  },
  methods: {
    async fetchNovedades() {
      try {
        const response = await fetch('http://127.0.0.1:8000/api/listarNovedades');
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        // Asigna los datos a this.movies en lugar de this.peliculas
        this.movies = data.movies; // Asegúrate de adaptar esta línea según la estructura de tu respuesta de API
      } catch (error) {
        console.error("Could not fetch peliculas: ", error);
      }
    }
  },
  computed: {
    sortedMovies() {
      return this.movies.slice().sort((a, b) => {
        // Convertir las fechas a objetos Date para poder compararlas
        const dateA = new Date(a.estreno);
        const dateB = new Date(b.estreno);
        // Ordenar por fecha de lanzamiento descendente (más reciente primero)
        return dateB - dateA;
      });
    }
  }
};
</script>

<style scoped>
:root {
  --color-primary: #0056b3;
  --color-secondary: #6c757d;
  --color-border: #e2e2e2;
  --background-card: #ffffff;
  --font-family-base: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  --border-radius-base: 8px;
}

.movies-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 20px;
  /* Margen inferior agregado */
}

@media (min-width: 768px) {
  .movies-container {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 992px) {
  .movies-container {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 1200px) {
  .movies-container {
    grid-template-columns: repeat(4, 1fr);
  }
}

.movie-card {
  display: flex;
  flex-direction: column;
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius-base);
  overflow: hidden;
  background-color: var(--background-card);
  transition: box-shadow 0.3s ease;
  cursor: pointer;
}

.movie-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.movie-poster-wrapper {
  line-height: 0;
  margin-bottom: 10px;
}

.movie-poster {
  width: 100%;
  height: auto;
  display: block;
  border-radius: var(--border-radius-base) var(--border-radius-base) 0 0;
}

.movie-info {
  padding: 15px;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

.movie-title {
  margin: 0;
  font-size: 1.2rem;
  color: var(--color-primary);
}

.movie-synopsis {
  margin: 5px 0 10px 0;
  font-size: 1rem;
  color: #444;
}

.movie-release {
  margin: 0;
  font-style: italic;
  color: var(--color-secondary);
}

.loading {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200px;
  font-size: 1.2rem;
}
</style>
