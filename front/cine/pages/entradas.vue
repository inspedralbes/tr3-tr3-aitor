<template>
    <div class="container">
      <div class="entradas">
        <div v-for="entrada in entradas" :key="entrada.id" class="entrada">
          <div v-if="entrada.pelicula" class="entrada-info">
            <img :src="entrada.pelicula.cartel" :alt="`Cartel de ${entrada.pelicula.titulo}`" class="cartel">
            <div class="info">
              <h1>{{ entrada.pelicula.titulo }}</h1>
              <p>Filera {{ entrada.fila }} - Columna {{ entrada.columna }}</p>
              <p>{{ entrada.fecha_hora }}</p>
              <p>{{ entrada.precio }}€</p>
            </div>
          </div>
        </div>
      </div>
      <div class="perfil">
        <img :src="user.user.foto_perfil + '.png'" alt="Foto de perfil" class="foto-perfil">
        <div class="info-perfil">
          <h1>{{ user.user.nom }} {{ user.user.cognoms }}</h1>
          <ul>
            <li><nuxt-link to="/perfil">Mi Perfil</nuxt-link></li>
            <li><nuxt-link to="/entradas">Mis Entradas</nuxt-link></li>
          </ul>
          <button @click="logout" class="boton-logout">Cerrar sesión</button>
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
                console.log(data);
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
}

.cartel {
  width: 100px; /* Ajusta el tamaño según sea necesario */
  margin-right: 20px;
}

.info {
  flex: 1;
}

.perfil {
  width: 200px; /* Ajusta el ancho según sea necesario */
  background-color: #f0f0f0;
  padding: 20px;
}

.foto-perfil {
  width: 100px; /* Ajusta el tamaño según sea necesario */
  border-radius: 50%;
}

.info-perfil h1 {
  margin-bottom: 10px;
}

.info-perfil ul {
  list-style: none;
  padding: 0;
}

.info-perfil ul li {
  margin-bottom: 5px;
}

.boton-logout {
  background-color: #ff6347;
  color: white;
  border: none;
  padding: 5px 10px;
  border-radius: 5px;
  cursor: pointer;
}
</style>