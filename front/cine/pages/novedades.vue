<template>
  <div class="centro">
    <h2 class="page-title">Novedades de Películas</h2>
  </div>
  <div class="derecha">
    <input type="text" v-model="filtroTitulo" placeholder="Buscar por título">
  </div>
  <div class="derecha">
    <select v-model="filtroGenero" @change="filtrarPorGenero">
      <option value="">Todos los géneros</option>
      <option v-for="genero in generosDisponibles" :key="genero">{{ genero }}</option>
    </select>
  </div>
  
  <div class="novedadess-container">
    <div class="novedadess-grid">
      <div v-for="novedad in novedadesFiltradas" :key="novedad.id" class="novedades-card" @click="mostrarModal(novedad)">
        <img :src="novedad.poster" :alt="`Cartel de ${novedad.title}`" class="novedades-cartel">
        <div class="novedades-info">
          <h2 class="novedades-titulo">{{ novedad.title }}</h2>
          <p class="novedades-genero">{{ novedad.genero }}</p>
          <p class="novedades-duracion">Fecha de lanzamiento: {{ formatDate(novedad.estreno) }}</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div v-if="modalAbierto" class="modal">
    <div class="modal-contenido novedades-modal">
      <span class="cerrar" @click="cerrarModal">&times;</span>
      <div class="modal-content">
        <img :src="novedadSeleccionada.poster" :alt="`Cartel de ${novedadSeleccionada.title}`" class="cartel-novedad">
        <div class="novedades-info">
          <h2 class="titulo-novedad">{{ novedadSeleccionada.title }}</h2>
          <p class="duracion-genero">{{ novedadSeleccionada.genero }}</p>
          <p class="novedades-genero">{{ novedadSeleccionada.sinopsis }}</p>
          <p class="duracion-novedad">Fecha de lanzamiento: {{ formatDate(novedadSeleccionada.estreno) }}</p>
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
      modalAbierto: false,
      novedadSeleccionada: null,
      filtroTitulo: '',
      filtroGenero: '', // Nuevo filtro de género
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
    },
    mostrarModal(novedad) {
      this.novedadSeleccionada = novedad;
      this.modalAbierto = true;
    },
    cerrarModal() {
      this.modalAbierto = false;
      this.novedadSeleccionada = null;
    },
    filtrarPorGenero() {
      // Método para aplicar el filtro por género
    }
  },
  computed: {
    novedadesFiltradas() {
      return this.novedades.filter(novedad =>
        (novedad.title.toLowerCase().includes(this.filtroTitulo.toLowerCase()) &&
         (this.filtroGenero === '' || novedad.genero === this.filtroGenero))
      );
    },
    generosDisponibles() {
      return [...new Set(this.novedades.map(novedad => novedad.genero))];
    }
  }
};
</script>

<style scoped>
/* Estilos para el campo de búsqueda */
input[type="text"] {
  width: 200px; /* Ancho del campo de búsqueda */
  padding: 10px; 
  border-radius: 5px; 
  border: 1px solid #ccc; 
  margin-right: 75px;
}
.derecha {
  display: flex; /* Para usar flexbox */
  justify-content: flex-end; /* Alineación a la derecha */
  margin-bottom: 30px; /* Espacio inferior */
}
select {
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-top: 10px; 
  margin-right: 75px;
}
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
    width: 80%; /* Modificar el ancho del modal según tus necesidades */
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


.modal-content {
  display: flex;
}

.cartel-novedad {
    width: 200px;
    height: auto;
    border-radius: 10px;
    margin-right: 20px; /* Espacio entre la imagen y la información */
}

.novedades-info {
    flex-grow: 1; /* Permite que el contenido ocupe todo el espacio disponible */
}

.titulo-novedad {
    font-size: 1.8rem;
    margin-bottom: 10px;
    color: #333; /* Cambiar el color del título si es necesario */
}

.sinopsis-novedad {
    font-size: 1.2rem;
    margin-bottom: 10px;
    color: #666; /* Cambiar el color del texto de la sinopsis si es necesario */
    line-height: 1.5; /* Espaciado entre líneas */
}

.duracion-novedad {
    font-size: 1rem;
    color: #666; /* Cambiar el color del texto de la duración si es necesario */
    margin-bottom: 5px;
}

/* Estilos para las tarjetas de novedades */
.page-title {
  font-size: 2rem;
  color: var(--color-primary);
  text-align: center;
  margin-bottom: 50px;
}

.novedadess-container {
  max-width: 1200px;
}

.novedadess-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 30px;
}

.novedades-card {
  width: 300px;
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

.novedades-duracion {
  font-size: 1.2rem;
  color: #666;
  margin-bottom: 5px;
}
.duracion-genero {
    font-size: 1rem;
    color: black; /* Cambiar el color del texto de la duración si es necesario */
    margin-bottom: 5px;
}
</style>
