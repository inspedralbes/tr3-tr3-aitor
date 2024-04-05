<template>
  <div class="centro">
    <h2 class="page-title">Trailers</h2>
  </div>
  <div class="derecha">
    <input type="text" v-model="filtroTitulo" placeholder="Buscar por título">
  </div>
  <div class="peliculas-container">
    <div class="peliculas-grid">
      <div v-for="pelicula in peliculasFiltradas" :key="pelicula.id" class="pelicula-card" @click="mostrarVideo(pelicula.trailer)">
        <img :src="pelicula.cartel" :alt="`Cartel de ${pelicula.titulo}`" class="pelicula-cartel">
        <div class="pelicula-info">
          <h2 class="pelicula-titulo">{{ pelicula.titulo }}</h2>
        </div>
      </div>
    </div>

    <div class="peliculas-grid">
      <div v-for="novedad in novedadesFiltradas" :key="novedad.id" class="pelicula-card" @click="mostrarVideo(novedad.trailer)">
        <img :src="novedad.poster" :alt="`Cartel de ${novedad.title}`" class="pelicula-cartel">
        <div class="pelicula-info">
          <h2 class="pelicula-titulo">{{ novedad.title }}</h2>
        </div>
      </div>
    </div>
  </div>

  <div v-if="mostrarModal" class="modal">
    <div class="modal-content">
      <span class="cerrar" @click="cerrarModal">&times;</span>
      <iframe width="560" height="315" :src="videoUrl" frameborder="0" allowfullscreen></iframe>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      peliculas: [],
      novedades: [],
      mostrarModal: false,
      videoUrl: '',
      filtroTitulo: '',
    };
  },
  async mounted() {
    await this.fetchPeliculas();
    await this.fetchNovedades();
  },
  computed: {
    peliculasFiltradas() {
      return this.peliculas.filter(pelicula =>
        pelicula.titulo.toLowerCase().includes(this.filtroTitulo.toLowerCase())
      );
    },
    novedadesFiltradas() {
      return this.novedades.filter(novedad =>
        novedad.title.toLowerCase().includes(this.filtroTitulo.toLowerCase())
      );
    }
  },
  methods: {
    async fetchPeliculas() {
      try {
        const response = await fetch('http://127.0.0.1:8000/api/listarPeliculas');
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        this.peliculas = data.data.map(pelicula => ({
          ...pelicula,
          trailer: `https://www.youtube.com/embed/${pelicula.id_youtube}`
        }));
      } catch (error) {
        console.error("Could not fetch peliculas: ", error);
      }
    },
    async fetchNovedades() {
      try {
        const response = await fetch('http://127.0.0.1:8000/api/listarNovedades');
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        this.novedades = data.data.map(novedad => ({
          ...novedad,
          trailer: `https://www.youtube.com/embed/${novedad.id_youtube}`
        }));
      } catch (error) {
        console.error("Could not fetch novedades: ", error);
      }
    },
    mostrarVideo(videoUrl) {
      this.videoUrl = videoUrl;
      this.mostrarModal = true;
    },
    cerrarModal() {
      this.mostrarModal = false;
      this.videoUrl = '';
    }
  }
};
</script>
<style scoped>
/* Estilos para el campo de búsqueda */
input[type="text"] {
  width: 200px;
  /* Ancho del campo de búsqueda */
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
  margin-right: 75px;
}

.derecha {
  display: flex;
  /* Para usar flexbox */
  justify-content: flex-end;
  /* Alineación a la derecha */
  margin-bottom: 30px;
  /* Espacio inferior */
}

.modal {
  display: flex;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  justify-content: center;
  align-items: center;
}

.modal-content {
  background-color: black;
  padding: 20px;
  border-radius: 10px;
}

.cerrar {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.cerrar:hover,
.cerrar:focus {
  color: white;
  text-decoration: none;
  cursor: pointer;
}

/* Estilos para la tarjeta de película */
.page-title {
  font-size: 2rem;
  color: var(--color-primary);
  text-align: center;
  margin-bottom: 50px;
}

.peliculas-container {
  max-width: 1200px;
}

.peliculas-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 30px;
}

.pelicula-card {
  width: 300px;
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
</style>
