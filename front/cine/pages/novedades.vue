<template>
  <div>
    <h2 class="page-title">Novedades de Películas</h2>
    <div v-if="loading" class="loading">Cargando...</div>
    <div v-else class="movies-container">
      <article v-for="novedad in sortedNovedades" :key="novedad.id" class="movie-card">
        <div class="movie-poster-wrapper">
          <img :src="`${novedad.poster}`" :alt="novedad.title" class="movie-poster">
        </div>
        <div class="movie-info">
          <h3 class="movie-title">{{ novedad.title }}</h3>
          <p class="movie-synopsis">{{ novedad.sinopsis }}</p>
          <p class="movie-release">Fecha de lanzamiento: {{ formatDate(novedad.estreno) }}</p>
        </div>
      </article>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      novedades: [],
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
        this.novedades = data.data;
      } catch (error) {
        console.error("Could not fetch novedades: ", error);
      }
    },
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(dateString).toLocaleDateString(undefined, options);
    }
  },
  computed: {
    sortedNovedades() {
      return this.novedades.slice().sort((a, b) => {
        const dateA = new Date(a.estreno);
        const dateB = new Date(b.estreno);
        return dateB - dateA;
      });
    }
  }
};
</script>

<style scoped>
.page-title {
  font-size: 2rem; /* Tamaño de fuente más grande */
  color: var(--color-primary); /* Color principal */
  text-align: center; /* Centrar texto */
  margin-bottom: 20px; /* Margen inferior */
}

.movies-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 20px;
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
  margin: 15px;
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
