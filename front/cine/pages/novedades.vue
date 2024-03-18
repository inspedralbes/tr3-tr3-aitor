<template>
  <div class="centro">
    <h2 class="page-title">Novedades de Películas</h2>
  </div>
  <div class="novedadess-container">


    <div class="novedadess-grid">
      <div v-for="novedad in novedades" :key="novedad.id" class="novedades-card">
        <img :src="novedad.poster" :alt="`Cartel de ${novedad.title}`" class="novedades-cartel">
        <div class="novedades-info">
          <h2 class="novedades-titulo">{{ novedad.title }}</h2>
          <p class="novedades-duracion">Fecha de lanzamiento: {{ formatDate(novedad.estreno) }}</p>
        </div>
      </div>
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
        return dateA - dateB; // Cambiar a dateA - dateB
      });
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

.novedadess-container {
  max-width: 1200px;
  /* Hacer el contenedor más grande */
}

.novedadess-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  /* Mostrar 4 películas por fila */
  gap: 30px;
}

.novedades-card {
  width: 300px;
  /* Ajustar el ancho de las tarjetas de película */
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
  margin-left: 40px;
  margin-bottom: 20px;
}

.novedades-card:hover {
  transform: translateY(-5px);
}

.novedades-cartel {
  width: 100%;
  height: auto;
  border-radius: 20px 20px 0 0;
}

.novedades-info {
  padding: 20px;
}

.novedades-titulo {
  font-size: 1.6rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.novedades-genero,
.novedades-duracion {
  font-size: 1.2rem;
  color: #666;
  margin-bottom: 5px;
}
</style>
