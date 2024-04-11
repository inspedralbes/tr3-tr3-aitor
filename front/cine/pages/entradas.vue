<template>
    <div class="container">
      <div class="entradas">
        <div v-for="entrada in entradas" :key="entrada.id" class="entrada">
          <div v-if="entrada.pelicula" class="entrada-info">
            <img :src="entrada.pelicula.cartel" :alt="`Cartel de ${entrada.pelicula.titulo}`" class="cartel">
            <div class="info">
              <h1>{{ entrada.pelicula.titulo }}</h1>
              <p>Entrada: Filera {{ entrada.fila }} - Columna {{ entrada.columna }}</p>
              <p>{{ entrada.fecha_hora }}</p>
              <p>Precio: {{ entrada.precio }}€</p>
            </div>
          </div>
        </div>
      </div>
      <div class="perfil">
        <div class="perfil-info">
          <img :src="user.user.foto_perfil + '.png'" alt="Foto de perfil" class="foto-perfil">
          <div class="nombre-info">
            <h1>{{ user.user.nom }} {{ user.user.cognoms }}</h1>
            <ul>
              <li><nuxt-link to="/perfil">Mi Perfil</nuxt-link></li>
              <li><nuxt-link to="/entradas">Mis Entradas</nuxt-link></li>
            </ul>
            <button @click="logout" class="boton-logout">Cerrar sesión</button>
          </div>
        </div>
      </div>
    </div>
  </template>

<script>
export default {
    data() {
        return {
            entradas: [],
            sesiones: [] // Variable para almacenar las sesiones
        }
    },
    methods: {
        async fetchmostrarEntradas() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/listarEntradasPorUsuario/${this.user.user.id}`, {
                    method: 'GET',
                });
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();
                // console.log(data);
                // Asignar los datos a la variable entradas
                this.entradas = data.data;

                // Fetch de detalles de cada sesión
                for (const entrada of this.entradas) {
                    await this.fetchInformacionSesion(entrada.sesion_id);
                }
            } catch (error) {
                console.error("Could not fetch sesiones: ", error);
            }
        },
        async fetchInformacionSesion(sesionId) {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/listarSesionesPorId/${sesionId}`, {
                    method: 'GET',
                });
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();

                // Buscar todas las entradas correspondientes a la sesión
                const entradasDeSesion = this.entradas.filter(entrada => entrada.sesion_id === sesionId);

                // Asignar detalles de sesión a cada entrada correspondiente
                entradasDeSesion.forEach(entrada => {
                    // Formatear la fecha y hora
                    const fechaHora = new Date(data.data.fecha);
                    const fechaFormateada = fechaHora.toLocaleDateString('es-ES', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
                    const horaFormateada = fechaHora.toLocaleTimeString('es-ES', { hour: 'numeric', minute: 'numeric', hour12: true });

                    // Asignar la fecha y la hora formateadas
                    entrada.fecha_hora = `${fechaFormateada} ${horaFormateada}`;
                    entrada.precio = data.data.precio;
                    // Agregar los detalles de la película a la entrada
                    entrada.pelicula = data.data.pelicula;
                });
            } catch (error) {
                console.error("Could not fetch session information: ", error);
            }
        },

        logout() {
            // Redirigir al usuario a la página deseada
            this.$router.push('/');

            // Limpiar el localStorage y recargar la página actual en segundo plano
            setTimeout(() => {
                localStorage.removeItem('user');
                window.location.reload();
            }, 5);
        }
    },
    computed: {
        user() {
            const userData = JSON.parse(localStorage.getItem('user'));
            return userData;
        }
    },
    mounted() {
        this.fetchmostrarEntradas();
    }
}
</script>
<style>
.container {
    display: flex;
    font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
    justify-content: space-between;
    align-items: flex-start;
}

.entradas {
    flex: 1;
}

.entrada {
    margin-bottom: 20px;
}

.entrada-info {
    display: flex;
    align-items: center;
    margin-left: 30px;
    margin-top: 25px;
}

.cartel {
    width: 100px;
    /* Ajusta el tamaño según sea necesario */
    margin-right: 20px;
}

.info {
    flex: 1;
}

.perfil {
    width: 15%;
    
    background-color: #fff;
    /* Fondo blanco */
    border: 1px solid #ccc;
    /* Borde gris */
    border-radius: 5px;
    /* Bordes redondeados */
    padding: 20px;
    /* Espaciado interior */
    display: flex;
    /* Mostrar elementos en línea */
    align-items: center;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-right: 250px;
    margin-top: 80px;
}

.foto-perfil {
    width: 100px;
    /* Tamaño de la foto de perfil */
    height: 100px;
    /* Altura de la foto de perfil */
    border-radius: 50%;
    /* Borde redondeado */
    margin-left: 60px;
    /* Margen a la derecha para separar del texto */
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    /* Sombra ligera */
}

.info-perfil {
    flex: 1;
    /* Ocupar el espacio restante */
}

.info-perfil h1 {
    margin: 0 0 10px;
    /* Margen inferior para separar del resto del contenido */
}

.info-perfil ul {
    padding: 0;
    /* Eliminar el relleno de la lista */
    margin: 0;
    /* Eliminar el margen de la lista */
}

.info-perfil ul li {
    list-style: none;
    /* Eliminar los puntos de la lista */
}
.nombre-info h1 {
    font-size: 20px;
}
.nombre-info ul li {
    width: 200px;
    padding: 10px 20px;
    background-color: red;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
    margin: 0 auto;
    display: block;
    margin-bottom: 15px;
}
.nombre-info ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.nombre-info ul li:hover {
    background-color: #c00;
}
.boton-logout {
    font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;

    width:240px;
    background-color: red;
    /* Color de fondo rojo */
    color: #fff;
    /* Color de texto blanco */
    border: none;
    /* Sin borde */
    padding: 10px 20px;
    /* Espaciado interno */
    border-radius: 5px;
    /* Bordes redondeados */
    cursor: pointer;
    
}

.boton-logout:hover {
    background-color: #c00;
    /* Color de fondo rojo más oscuro al pasar el ratón */
}
a:-webkit-any-link {
    color: white;
    cursor: pointer;
    text-decoration: none;
}
</style>