<template>
  <div class="pelicula-container">
    <div class="pelicula-info">
      <img :src="pelicula.imagen" alt="Imagen de la Película" class="pelicula-imagen" />
      <h2 class="pelicula-titulo">{{ pelicula.titulo }}</h2>
    </div>
    <div class="contenido-ticket">
      <div class="plan-asientos">
        <div v-for="(fila, indiceFila) in planAsientos" :key="indiceFila" class="fila">
          <div v-for="(asiento, indiceAsiento) in fila" :key="indiceAsiento" class="asiento" @click="alternarSeleccion(indiceFila, indiceAsiento)" :class="{ seleccionado: asiento.seleccionado }">
            <img :src="asiento.imagen" :alt="asiento.etiqueta" class="asiento-imagen" />
          </div>
        </div>
      </div>
    </div>
    <div class="info-asiento" v-if="asientosSeleccionados.length > 0">
        <h3 class="info-titulo">Información de Asientos Seleccionados</h3>
        <div v-for="(asiento, index) in asientosSeleccionados" :key="index">
          <p>Asiento {{ asiento.etiqueta }} - Fila {{ obtenerFila(asiento.etiqueta) }}, Columna {{ obtenerColumna(asiento.etiqueta) }}</p>
        </div>
        <p>Total de Asientos Seleccionados: <span class="info-dato">{{ totalAsientosSeleccionados }}</span></p>
        <p>Precio Total: <span class="info-dato">{{ precioTotal.toFixed(2) }}€</span></p>
        <button @click="comprar" class="boton-comprar">Comprar</button>
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
.pelicula-container {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  justify-content: space-between;
  padding: 20px;
}

.pelicula-info {
  width: 30%;
}

.pelicula-imagen {
  max-width: 100%;
  height: auto;
  border-radius: 10px; /* Bordes redondeados */
}

.pelicula-titulo {
  font-size: 24px;
  margin-top: 10px;
}

.contenido-ticket {
  width: 65%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.plan-asientos {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
}

.fila {
  display: flex;
}

.asiento {
  width: 50px;
  height: 50px;
  margin: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  border-radius: 50%;
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

.info-dato {
  font-weight: bold;
}

.boton-comprar {
  background-color: #007bff;
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
