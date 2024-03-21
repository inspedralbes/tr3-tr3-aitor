<template>
  <div class="container">
    <div class="pelicula-info">
      <img :src="pelicula.imagen" alt="Imagen de la Película" class="pelicula-imagen" />
      <div class="pelicula-details">
        <h2>{{ pelicula.titulo }}</h2>
        <p>Género: {{ pelicula.genero }}</p>
        <p>Duración: {{ pelicula.duracion }}</p>
      </div>
    </div>
    <div class="butacas-ticket">
      <div class="plan-asientos">
        <div v-for="(fila, indiceFila) in planAsientos" :key="indiceFila" class="fila">
          <div v-for="(asiento, indiceAsiento) in fila" :key="indiceAsiento" class="asiento" @click="alternarSeleccion(indiceFila, indiceAsiento)" :class="{ seleccionado: asiento.seleccionado }">
            <img :src="asiento.imagen" :alt="asiento.etiqueta" class="asiento-imagen" />
          </div>
        </div>
      </div>
      <div class="info-asiento" v-if="asientosSeleccionados.length > 0">
        <h3 class="info-titulo">Información de Asientos Seleccionados</h3>
        <div v-for="(asiento, index) in asientosSeleccionados" :key="index">
          <p>Asiento {{ asiento.etiqueta }} - Fila {{ obtenerFila(asiento.etiqueta) }}, Columna {{ obtenerColumna(asiento.etiqueta) }}</p>
        </div>
        <div class="ticket">
          <div class="ticket-header">
            <h3 class="ticket-title">Detalles de la Compra</h3>
          </div>
          <div class="ticket-body">
            <p>Total Asientos:</p>
            <p>Total a Pagar:</p>
          </div>
          <div class="ticket-footer">
            <button @click="comprar" class="boton-comprar">Comprar</button>
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
      pelicula: {
        titulo: 'Ant-Man i la Avispa: Quantumania',
        imagen: './ant.jpg',
        genero: 'Acción, Aventura, Ciencia Ficción',
        duracion: '1h 58min',
      },
      planAsientos: this.generarPlanAsientos(10, 12), // Cambio a 10 filas y 12 columnas
      asientosSeleccionados: [],
      maxAsientosSeleccionados: 10 // Máximo de butacas seleccionadas
    };
  },
  computed: {
    totalAsientosSeleccionados() {
      return this.asientosSeleccionados.length;
    },
    precioTotal() {
      return this.asientosSeleccionados.reduce((total, asiento) => total + asiento.precio, 0);
    },
  },
  methods: {
    generarPlanAsientos(filas, asientosPorFila) {
      const planAsientos = [];
      for (let i = 1; i <= filas; i++) {
        const fila = [];
        for (let j = 1; j <= asientosPorFila; j++) {
          fila.push({
            etiqueta: `F${i}A${j}`,
            precio: 5.50, // Precio por defecto
            cantidad: 1, // Cantidad por defecto
            seleccionado: false,
            imagen: './butaca.png', // URL de la imagen del asiento seleccionado
          });
        }
        planAsientos.push(fila);
      }
      return planAsientos;
    },
    alternarSeleccion(indiceFila, indiceAsiento) {
      const asiento = this.planAsientos[indiceFila][indiceAsiento];
      if (this.totalAsientosSeleccionados < this.maxAsientosSeleccionados || asiento.seleccionado) {
        asiento.seleccionado = !asiento.seleccionado;

        if (asiento.seleccionado) {
          this.asientosSeleccionados.push(asiento);
          asiento.imagen = './butaca_roja.png'; // Cambiar la imagen del asiento seleccionado
        } else {
          const indice = this.asientosSeleccionados.findIndex(asientoSeleccionado => asientoSeleccionado.etiqueta === asiento.etiqueta);
          if (indice !== -1) {
            this.asientosSeleccionados.splice(indice, 1);
            asiento.imagen = './butaca.png'; // Cambiar la imagen del asiento a su estado original
          }
        }
      } else {
        alert('Solo puedes seleccionar un máximo de 10 asientos.');
      }
    },
    comprar() {
      // Lógica para comprar los asientos seleccionados
      alert('Compra realizada correctamente');
    },
    obtenerFila(etiqueta) {
      return etiqueta.split('A')[0].replace('F', '');
    },
    obtenerColumna(etiqueta) {
      return etiqueta.split('A')[1];
    }
  }
};
</script>

<style scoped>
.container {
  display: flex;
  margin-top: 20px
}

.pelicula-info {
  width: 30%;
}

.pelicula-imagen {
  margin-top: 2vh;
  margin-left: 1.5vw;
  width: 18vw;
  height: auto;
}

.pelicula-details {
  margin-left: 20px;
}

.butacas-ticket {
  display: grid;
  grid-template-columns: 1fr 1fr;
}

.plan-asientos {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
  margin-top: 20px;
  margin-left: 30px;
}

.fila {
  display: flex;
}

.asiento {
  width: 40px;
  height: 40px;
  margin: 5px;
  cursor: pointer;
}

.asiento-imagen {
  max-width: 50%;
  max-height: 50%;
}

.info-asiento {
  margin-top: 20px;
  text-align: center;
}

.info-titulo {
  font-size: 20px;
  margin-bottom: 10px;
}

.ticket {
  width: 60%;
  margin-left: 6vw;
  border: 2px solid red;
  border-radius: 10px;
  padding: 10px;
  margin-top: 20px;
  background-color: #f9f9f9;
}

.ticket-header {
  text-align: center;
}

.ticket-title {
  color: red;
  font-size: 24px;
}

.ticket-body {
  margin-top: 10px;
}

.ticket-body p {
  margin: 5px 0;
}

.ticket-footer {
  margin-top: 20px;
  text-align: center;
}
.boton-comprar {
  background-color: red;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

.boton-comprar:hover {
  background-color: #0056b3;
}
</style>
