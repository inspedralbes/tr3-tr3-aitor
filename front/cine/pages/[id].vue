<template>
  <div class="container">
    <div class="pelicula-info">
      <img :src="pelicula.cartel" alt="Imagen de la Película" class="pelicula-imagen" />
      <div class="pelicula-details">
        <h2>{{ pelicula.titulo }}</h2>
        <p>Género: {{ pelicula.genero }}</p>
        <p>Duración: {{ duracionEnHoras }}</p>
      </div>
    </div>
    <div class="butacas-ticket">
      <div class="plan-asientos">
        <div v-for="(fila, indiceFila) in planAsientos" :key="indiceFila" class="fila">
          <div v-for="(asiento, indiceAsiento) in fila" :key="indiceAsiento" class="asiento"
            @click="alternarSeleccion(indiceFila, indiceAsiento)" :class="{ seleccionado: asiento.seleccionado }">
            <img :src="asiento.imagen" :alt="asiento.etiqueta" class="asiento-imagen" />
          </div>
        </div>
      </div>
      <div class="ticket" v-if="asientosSeleccionados.length > 0">
        <div class="ticket-header">
          <h3 class="ticket-title">Detalles de la Compra</h3>
        </div>
        <div class="ticket-body">
          <h4>Asientos Seleccionados:</h4>
          <div v-for="(asiento, index) in asientosSeleccionados" :key="index">
            <p>Fila {{ obtenerFila(asiento.etiqueta) }} - Columna {{ obtenerColumna(asiento.etiqueta) }}</p>
          </div>
          <div class="ticket-summary">
            <p>Total Asientos: {{ totalAsientosSeleccionados }}</p>
            <p>Total a Pagar: {{ precioTotal }}€</p>

          </div>
        </div>
        <div class="ticket-footer">
          <button @click="comprar" class="boton-comprar">Comprar</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { usePeliculasStore } from "../stores/store";

export default {
  data() {
    return {
      planAsientos: [],
      asientosSeleccionados: [],
      maxAsientosSeleccionados: 10,
      sesiones: null
    };
  },
  computed: {
    totalAsientosSeleccionados() {
      return this.asientosSeleccionados.length;
    },
    precioTotal() {
      const total = this.asientosSeleccionados.reduce((total, asiento) => total + (asiento.precio * asiento.cantidad), 0);
      return total.toFixed(2); // Mostrar el precio total con dos decimales
    },
    pelicula() {
      const peliculasStore = usePeliculasStore();
      return peliculasStore.peliculaSeleccionada;
    },
    duracionEnHoras() {
      const horas = Math.floor(this.pelicula.duracion / 60);
      const minutos = this.pelicula.duracion % 60;
      return `${horas}h ${minutos}min`;
    }
  },
  methods: {
    async fetchSesiones() {
      try {
        const response = await fetch(`http://127.0.0.1:8000/api/obtenerSesion/${this.pelicula.sesion_id}`, {
          method: 'GET',
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();

        // Obtener las entradas ocupadas de la sesión
        const entradasOcupadas = await this.obtenerEntradasOcupadas(this.pelicula.sesion_id);

        this.sesiones = data.data.precio;

        // Generar el plan de asientos con las butacas ocupadas marcadas con una imagen diferente
        this.planAsientos = this.generarPlanAsientos(10, 12, data.data.precio, entradasOcupadas);
      } catch (error) {
        console.error("Could not fetch sesiones: ", error);
      }
    },

    async obtenerEntradasOcupadas(sesionId) {
      try {
        const response = await fetch(`http://127.0.0.1:8000/api/listarEntradasPorSesion/${this.pelicula.sesion_id}`, {
          method: 'GET',
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        // Obtener las etiquetas de las butacas ocupadas
        const etiquetasOcupadas = data.data.map(entrada => 'F' + entrada.fila + 'A' + entrada.columna);
        // console.log('Entradas ocupadas:', etiquetasOcupadas); // Mostrar las entradas ocupadas en un console log
        return etiquetasOcupadas;
      } catch (error) {
        console.error("Could not fetch occupied seats: ", error);
        return [];
      }
    },


    generarPlanAsientos(filas, asientosPorFila, precio, entradasOcupadas) {
      const planAsientos = [];
      for (let i = 1; i <= filas; i++) {
        const fila = [];
        for (let j = 1; j <= asientosPorFila; j++) {
          const etiqueta = `F${i}A${j}`;
          const seleccionado = this.asientosSeleccionados.some(asiento => asiento.etiqueta === etiqueta);
          const ocupado = entradasOcupadas.includes(etiqueta);
          const imagen = ocupado ? './butaca_ocupada.png' : (seleccionado ? './butaca_roja.png' : './butaca.png');
          fila.push({
            etiqueta: etiqueta,
            precio: precio,
            cantidad: 1,
            seleccionado: seleccionado,
            ocupado: ocupado,
            imagen: imagen,
          });
        }
        planAsientos.push(fila);
      }
      return planAsientos;
    },

    alternarSeleccion(indiceFila, indiceAsiento) {
      const asiento = this.planAsientos[indiceFila][indiceAsiento];

      // Verificar si el asiento está ocupado
      if (asiento.ocupado) {
        // Si está ocupado, mostrar un mensaje al usuario y salir de la función
        alert('Esta butaca ya está ocupada. Por favor, seleccione otra.');
        return;
      }

      // Verificar si se ha alcanzado el máximo de asientos seleccionados
      if (this.totalAsientosSeleccionados >= this.maxAsientosSeleccionados && !asiento.seleccionado) {
        alert('Solo puedes seleccionar un máximo de 10 asientos.');
        return;
      }

      // Alternar la selección del asiento
      asiento.seleccionado = !asiento.seleccionado;

      // Actualizar la lista de asientos seleccionados
      if (asiento.seleccionado) {
        this.asientosSeleccionados.push(asiento);
        asiento.imagen = './butaca_roja.png';
      } else {
        const indice = this.asientosSeleccionados.findIndex(asientoSeleccionado => asientoSeleccionado.etiqueta === asiento.etiqueta);
        if (indice !== -1) {
          this.asientosSeleccionados.splice(indice, 1);
          asiento.imagen = './butaca.png';
        }
      }
    },

    obtenerFila(etiqueta) {
      return etiqueta.split('A')[0].replace('F', '');
    },
    obtenerColumna(etiqueta) {
      return etiqueta.split('A')[1];
    },
    async comprar() {
      try {
        // Obtener el id_usuario del localStorage
        

        for (const asiento of this.asientosSeleccionados) {
          const filaSeleccionada = this.obtenerFila(asiento.etiqueta);
          const columnaSeleccionada = this.obtenerColumna(asiento.etiqueta);

          const response = await fetch('http://127.0.0.1:8000/api/crearEntrada', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              cantidad: 1,
              fila: filaSeleccionada,
              columna: columnaSeleccionada,
              sesion_id: this.pelicula.sesion_id,
              usuario_id:  // Usar el id_usuario del localStorage
            })
          });

          if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.message || 'Error al comprar entrada');
          }

          const responseData = await response.json();
        }

        this.asientosSeleccionados = [];

        // Redirigir a la página de inicio después de la compra
        this.$router.push('/');
      } catch (error) {
        console.error('Error al comprar entradas:', error);
      }
    },
  },
  mounted() {
    this.fetchSesiones(); // Llama a la función para obtener el precio de la sesión al cargar el componente
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
  align-items: center;
  text-align: center;
  width: 60%;
  /* Utiliza un porcentaje del ancho del contenedor */
  max-width: 600px;
  /* Establece un ancho máximo para evitar que el ticket se expanda demasiado en pantallas grandes */
  height: auto;
  /* Altura automática según el contenido */
  margin: 0 auto;
  /* Centra horizontalmente el ticket */
  padding: 20px;
  /* Aumenta el espacio interno del ticket */
  border: 2px solid red;
  border-radius: 10px;
  background-color: #f9f9f9;
  margin-top: 20px;
  margin-bottom: 20px;
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
  margin: 5px 0
}

.ticket-summary {
  margin-top: 20px;
  /* Agrega espacio entre los detalles y el resumen */
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
  background-color: #c00;
}
</style>
