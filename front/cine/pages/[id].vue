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
    <!-- Modal para butacas ocupadas -->
    <div class="modal" :class="{ 'is-active': showOccupiedModal }">
      <div class="modal-background" @click="closeOccupiedModal"></div>
      <div class="modal-content">
        <div class="box">
          <p>{{ occupiedModalMessage }}</p>
          <button @click="closeOccupiedModal" class="button is-primary">Cerrar</button>
        </div>
      </div>
      <button class="modal-close is-large" aria-label="close" @click="closeOccupiedModal"></button>
    </div>

    <!-- Modal para usuario no logueado -->
    <div class="modal" :class="{ 'is-active': showLoginModal }">
      <div class="modal-background" @click="closeLoginModal"></div>
      <div class="modal-content">
        <div class="box">
          <p>{{ loginModalMessage }}</p>
          <!-- Enlaces para registrar y loguear -->
          <div>
            <button><router-link to="/registro" class="button is-primary">Registrarse</router-link></button>
            <button><router-link to="/login" class="button is-primary">Iniciar sesión</router-link></button>
          </div>
        </div>
      </div>
      <button class="modal-close is-large" aria-label="close" @click="closeLoginModal"></button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      planAsientos: [],
      asientosSeleccionados: [],
      maxAsientosSeleccionados: 10,
      sesiones: null,
      showOccupiedModal: false,
      occupiedModalMessage: '',
      showLoginModal: false,
      loginModalMessage: ''
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
    },
    user() {
      const userData = JSON.parse(localStorage.getItem('user'));
      return userData;
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

      if (asiento.ocupado) {
        this.occupiedModalMessage = 'Esta butaca ya está ocupada. Por favor, seleccione otra.';
        this.showOccupiedModal = true;
        return;
      }

      if (this.totalAsientosSeleccionados >= this.maxAsientosSeleccionados && !asiento.seleccionado) {
        this.occupiedModalMessage = 'Solo puedes seleccionar un máximo de 10 asientos.';
        this.showOccupiedModal = true;
        return;
      }

      asiento.seleccionado = !asiento.seleccionado;

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

    closeModal() {
      this.showModal = false;
    },

    closeOccupiedModal() {
      this.showOccupiedModal = false;
    },

    closeLoginModal() {
      this.showLoginModal = false;
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
        if (!this.user) {
          this.loginModalMessage = 'Debes iniciar sesión o registrarte antes de comprar.';
          this.showLoginModal = true;
          return;
        }

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
              usuario_id: this.user.user.id, // Usar el id_usuario del localStorage
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

/* Estilos para los modales */
.modal {
  display: none;
  position: fixed;
  z-index: 9999;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}

.modal.is-active {
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-background {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  position: relative;
  background-color: white;
  border-radius: 5px;
  padding: 20px;
}

.modal-close {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}
.modal-content button {
  margin-top: 10px; /* Ajusta el margen superior del botón */
  background-color: red; /* Cambia el color de fondo del botón */
  color: white; /* Cambia el color del texto del botón */
  border: none; /* Elimina el borde del botón */
  padding: 10px 20px; /* Ajusta el padding del botón */
  border-radius: 5px; /* Agrega esquinas redondeadas al botón */
  cursor: pointer; /* Cambia el cursor al pasar sobre el botón */
  font-size: 16px; /* Cambia el tamaño de fuente del botón */
  transition: background-color 0.3s ease; /* Agrega una transición suave al cambiar el color de fondo */
  margin-right: 40px;

}

.modal-content button:hover {
  background-color: #c00; /* Cambia el color de fondo del botón al pasar sobre él */
}
.button:-webkit-any-link {
    color: white;
    cursor: pointer;
    text-decoration: none;
}
</style>
