<template>
  <div class="centro">
    <h2 class="page-title">Sesiones de Cine</h2>
  </div>
  <div class="derecha">
    <input type="text" v-model="filtroTitulo" placeholder="Buscar por título">
  </div>
  <div class="peliculas-container">
    <div v-for="(sesionesDia, fecha) in sesionesAgrupadas" :key="fecha">
      <div class="fecha">
        <h3>{{ fecha }}</h3>
      </div>
      <div class="peliculas-grid">
        <div v-for="sesion in sesionesDia" :key="sesion.id" class="pelicula-card">
          <img :src="sesion.pelicula.cartel" :alt="`Cartel de ${sesion.pelicula.titulo}`" class="pelicula-cartel">
          <div class="pelicula-info">
            <h2 class="pelicula-titulo">{{ sesion.pelicula.titulo }}</h2>
            <p class="pelicula-genero">{{ sesion.pelicula.genero }}</p>
            <p class="pelicula-duracion">Duración: {{ convertirDuracion(sesion.pelicula.duracion) }}</p>
            <p class="sesion-horario">Horario: {{ formatearFecha(sesion.fecha) }}</p>
            <button class="button button-comprar" @click="redireccionarCompraEntradas(sesion)">Comprar entradas</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
export default {
  data() {
    return {
      sesiones: [],
      filtroTitulo: '',
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
    convertirDuracion(minutos) {
      const horas = Math.floor(minutos / 60);
      const minutosRestantes = minutos % 60;
      return `${horas}h ${minutosRestantes}min`;
    },
    formatearFecha(fecha) {
      const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(fecha).toLocaleDateString('es-ES', options);
    },
    redireccionarCompraEntradas(sesion) {
      this.$router.push(`${sesion.id}`);
    },
  },
  computed: {
    sesionesOrdenadas() {
      // Ordenar las sesiones por fecha
      return this.sesiones.sort((a, b) => new Date(a.fecha) - new Date(b.fecha));
    },
    sesionesFiltradas() {
      return this.sesiones.filter(sesion => 
        sesion.pelicula.titulo.toLowerCase().includes(this.filtroTitulo.toLowerCase())
      );
    },
    sesionesAgrupadas() {
      // Agrupar las sesiones por día
      const sesionesAgrupadas = {};
      this.sesionesOrdenadas.forEach(sesion => {
        const fecha = new Date(sesion.fecha).toLocaleDateString('es-ES', {
          year: 'numeric',
          month: 'numeric',
          day: 'numeric'
        });
        if (!sesionesAgrupadas[fecha]) {
          sesionesAgrupadas[fecha] = [];
        }
        sesionesAgrupadas[fecha].push(sesion);
      });
      return sesionesAgrupadas;
    }
  }
};
</script>

<style scoped>
input[type="text"] {
  width: 200px;
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
.fecha{
  margin-left: 40px;
  margin-bottom: 20px;
  font-size: 1.8rem

}

/* Estilos para la información de la película */
.pelicula-info {
  padding: 20px;
  background-color: white;
  /* Color de fondo */
  border-radius: 0 0 20px 20px;
  /* Ajuste del borde inferior */
}

.pelicula-titulo {
  font-size: 1.4rem;
  /* Tamaño del título más pequeño */
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.pelicula-genero,
.pelicula-duracion,
.sesion-horario {
  font-size: 1rem;
  /* Tamaño de la fuente más pequeño */
  color: #666;
  margin-bottom: 5px;
}

.button-comprar {
  background-color: #FF4500;
  /* Color rojo */
  border: none;
  color: white;
  text-align: center;
  text-decoration: none;
  display: block;
  /* Cambiar a bloque para ocupar todo el ancho disponible */
  margin: 10px auto;
  /* Centrar horizontalmente y aplicar margen */
  font-size: 14px;
  /* Tamaño del botón más pequeño */
  cursor: pointer;
  border-radius: 5px;
  padding: 8px 16px;
  /* Ajuste del relleno del botón */
  transition: background-color 0.3s;
  margin-top: 25px;
}

.button-comprar:hover {
  background-color: red;
  /* Cambio de color al pasar el ratón */
}

.button-comprar:focus {
  outline: none;
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
</style>