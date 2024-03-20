<template>
    <div class="peliculas-container">
      <div class="peliculas-grid">
        <div v-for="sesion in sesionesOrdenadas" :key="sesion.id" class="pelicula-card">
          <img :src="sesion.pelicula.cartel" :alt="`Cartel de ${sesion.pelicula.titulo}`" class="pelicula-cartel">
          <div class="pelicula-info">
            <h2 class="pelicula-titulo">{{ sesion.pelicula.titulo }}</h2>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Detalles de la compra -->
    <div v-if="detalleCompra.mostrando" class="detalle-compra">
      <div class="pelicula-seleccionada">
        <img :src="detalleCompra.pelicula.cartel" :alt="`Cartel de ${detalleCompra.pelicula.titulo}`" class="pelicula-cartel">
        <h3>{{ detalleCompra.pelicula.titulo }}</h3>
      </div>
      <div class="asientos">
        <!-- Aquí puedes mostrar el mapa de asientos -->
        <div class="mapa-asientos">
          <!-- Lógica para mostrar la cuadrícula de asientos -->
        </div>
      </div>
      <div class="info-entradas">
        <p>Entradas seleccionadas: {{ detalleCompra.cantidadEntradas }}</p>
        <p>Precio total: {{ detalleCompra.cantidadEntradas * 5 }}€</p>
        <button class="button button-comprar" @click="confirmarCompra">Confirmar compra</button>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        sesiones: [],
        detalleCompra: {
          mostrando: false,
          pelicula: null,
          cantidadEntradas: 0
        }
      };
    },
    async mounted() {
      await this.fetchSesiones();
    },
    computed: {
      sesionesOrdenadas() {
        // Ordenar las sesiones por fecha y hora
        return this.sesiones.sort((a, b) => new Date(a.fecha) - new Date(b.fecha));
      }
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
      mostrarDetallesCompra(sesion) {
        this.detalleCompra.mostrando = true;
        this.detalleCompra.pelicula = sesion.pelicula;
      },
      confirmarCompra() {
        // Lógica para confirmar la compra
      }
    }
  };
  </script>
  
  <style scoped>
  /* Estilos para la información de la película */

  /* Estilos para los detalles de la compra */
  .detalle-compra {
    background-color: #f8f8f8;
    padding: 20px;
    border-radius: 8px;
    margin-top: 20px;
  }
  .pelicula-seleccionada {
    text-align: center;
    margin-bottom: 20px;
  }
  .pelicula-seleccionada img {
    max-width: 200px;
  }
  .mapa-asientos {
    /* Estilos para el mapa de asientos */
  }
  .info-entradas {
    margin-top: 20px;
  }
  </style>
  