<template>
  <div class="centro">
    <h2 class="page-title">Películas</h2>
  </div>
  <div class="peliculas-container">
    <div class="peliculas-grid">
      <div v-for="pelicula in peliculas" :key="pelicula.id" class="pelicula-card" @click="mostrarModal(pelicula)">
        <img :src="pelicula.cartel" :alt="`Cartel de ${pelicula.titulo}`" class="pelicula-cartel">
        <div class="pelicula-info">
          <h2 class="pelicula-titulo">{{ pelicula.titulo }}</h2>
          <p class="pelicula-genero">{{ pelicula.genero }}</p>
          <p class="pelicula-duracion">Duración: {{ convertirDuracion(pelicula.duracion) }}</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div v-if="modalAbierto" class="modal">
    <div class="modal-contenido pelicula-modal">
      <span class="cerrar" @click="cerrarModal">&times;</span>
      <div class="contenido-pelicula">
        <img :src="peliculaSeleccionada.cartel" :alt="`Cartel de ${peliculaSeleccionada.titulo}`" class="cartel-pelicula">
        <div class="info-pelicula">
          <h2 class="titulo-pelicula">{{ peliculaSeleccionada.titulo }}</h2>
          <p class="genero-pelicula">{{ peliculaSeleccionada.genero }}</p>
          <p class="sinopsis-pelicula">{{ peliculaSeleccionada.sinopsis }}</p>
          <p class="duracion-pelicula">Duración: {{ convertirDuracion(peliculaSeleccionada.duracion) }}</p>
          <p class="fecha-pelicula">Fecha de lanzamiento: {{ formatDate(peliculaSeleccionada.fechaEstreno) }}</p>
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
      modalAbierto: false,
      peliculaSeleccionada: null
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
    },
    mostrarModal(pelicula) {
      this.peliculaSeleccionada = pelicula;
      this.modalAbierto = true;
    },
    cerrarModal() {
      this.modalAbierto = false;
      this.peliculaSeleccionada = null;
    },
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(dateString).toLocaleDateString(undefined, options);
    }
  }
};
</script>

<style scoped>
/* Estilos para el modal */
.modal {
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-contenido {
    background-color: #fefefe;
    padding: 20px;
    border-radius: 10px;
    width: 1000px; /* Ancho fijo del modal */
}

.cerrar {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.cerrar:hover,
.cerrar:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

/* Estilos para la información de la película */
.pelicula-modal {
    text-align: center;
}

.contenido-pelicula {
    display: flex;
    align-items: center;
}

.cartel-pelicula {
    width: 200px;
    height: auto;
    margin-right: 20px;
}

.info-pelicula {
    flex-grow: 1;
    text-align: left;
}

.titulo-pelicula {
    font-size: 1.8rem;
    margin-bottom: 10px;
}

.sinopsis-pelicula {
    font-size: 1.2rem;
    margin-bottom: 10px;
}
.genero-pelicula,
.duracion-pelicula,
.fecha-pelicula {
    font-size: 1rem;
    color: #666;
    margin-bottom: 5px;
}

/* Estilos para las tarjetas de películas */
.page-title {
  font-size: 2rem;
  color: var(--color-primary);
  text-align: center;
  margin-bottom: 50px;
}

.peliculas-container {
  max-width: 1200px;
  /* Hacer el contenedor más grande */
}

.peliculas-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  /* Mostrar 4 películas por fila */
  gap: 30px;
}

.pelicula-card {
  width: 300px;
  /* Ajustar el ancho de las tarjetas de película */
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
