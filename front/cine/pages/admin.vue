<template>
    <div class="admin-container">
        <div class="options-container">
            <button class="movies-button" @click="toggleMovies">Películas</button>
            <button class="sessions-button" @click="toggleSessions">Sesiones</button>
            <button class="novedades-button" @click="toggleNovedades">Novedades</button>

        </div>
        <div v-if="showMovies" class="items-list">
            <h2>Listado de Películas:</h2>
            <transition-group name="fade">
                <div class="grid-container">
                    <div class="grid-item-header">ID</div>
                    <div class="grid-item-header">Título</div>
                    <div class="grid-item-header">Duración</div>
                    <div class="grid-item-header">Género</div>
                    <div class="grid-item-header">Sinopsis</div>
                    <div class="grid-item-header">Acciones</div>
                </div>
                <div class="grid-container" v-for="movie in movies" :key="movie.id">
                    <div class="grid-item">{{ movie.id }}</div>
                    <div class="grid-item">{{ movie.titulo }}</div>
                    <div class="grid-item">{{ formatDuration(movie.duracion) }}</div>
                    <div class="grid-item">{{ movie.genero }}</div>
                    <div class="grid-item">{{ movie.sinopsis }}</div>
                    <div class="grid-item">
                        <button @click="modifyItem" class="option-button">Modificar</button><br>
                        <button @click="deleteItem" class="option-button">Eliminar</button>
                    </div>
                </div>
                <div class="boton-derecha">
                    <button class="option-button2" @click="openCreateMovieModal">Crear</button>
                </div>
            </transition-group>
        </div>
        <div v-if="showSessions" class="items-list">
            <h2>Listado de Sesiones:</h2>
            <transition-group name="fade">
                <div class="grid-container2">
                    <div class="grid-item-header">ID</div>
                    <div class="grid-item-header">Película</div>
                    <div class="grid-item-header">Fecha</div>
                    <div class="grid-item-header">Hora</div>
                    <div class="grid-item-header">Precio</div>
                    <div class="grid-item-header">Acciones</div>
                </div>
                <div class="grid-container2" v-for="session in sessions" :key="session.id">
                    <div class="grid-item">{{ session.id }}</div>
                    <div class="grid-item">{{ session.pelicula.titulo }}</div>
                    <div class="grid-item">{{ session.fecha }}</div>
                    <div class="grid-item">{{ session.hora }}</div>
                    <div class="grid-item">{{ session.precio }}€</div>
                    <div class="grid-item">
                        <button @click="modifyItem" class="option-button">Modificar</button><br>
                        <button @click="deleteItem" class="option-button">Eliminar</button>
                    </div>
                </div>
                <div class="boton-derecha">
                    <button class="option-button2" @click="createItem">Crear</button>
                </div>
            </transition-group>
        </div>
        <div v-if="showNovedades" class="items-list">
            <h2>Listado de Novedades:</h2>
            <transition-group name="fade">
                <div class="grid-container">
                    <div class="grid-item-header">ID</div>
                    <div class="grid-item-header">Titulo</div>
                    <div class="grid-item-header">Genero</div>
                    <div class="grid-item-header">Estreno</div>
                    <div class="grid-item-header">Sinopsis</div>
                    <div class="grid-item-header">Acciones</div>
                </div>
                <div class="grid-container" v-for="novedad in novedades" :key="novedad.id">
                    <div class="grid-item">{{ novedad.id }}</div>
                    <div class="grid-item">{{ novedad.title }}</div>
                    <div class="grid-item">{{ novedad.genero }}</div>
                    <div class="grid-item">{{ formatEstreno(novedad.estreno) }}</div>
                    <div class="grid-item">{{ novedad.sinopsis }}</div>
                    <div class="grid-item">
                        <button @click="modifyItem" class="option-button">Modificar</button><br>
                        <button @click="deleteItem" class="option-button">Eliminar</button>
                    </div>
                </div>
                <div class="boton-derecha">
                    <button class="option-button2" @click="createItem">Crear</button>
                </div>
            </transition-group>
        </div>
        <div class="modal" v-if="showCreateMovieModal">
            <div class="modal-content">
                <span class="close" @click="closeCreateMovieModal">&times;</span>
                <h2>Crear Nueva Película</h2>
                <form @submit.prevent="submitNewMovie">
                    <label for="titulo">Título:</label>
                    <input type="text" id="titulo" v-model="newMovie.titulo" required>
                    <label for="duracion">Duración:</label>
                    <input type="number" id="duracion" v-model="newMovie.duracion" required>

                    <!-- Agrega los campos necesarios para la película (duración, género, sinopsis, etc.) -->

                    <button type="submit">Crear Película</button>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            showMovies: false,
            showSessions: false,
            showNovedades: false,
            movies: [],
            sessions: [],
            novedades: [],
            showCreateMovieModal: false,
            newMovie: {
                titulo: '',
                duracion: 0,
                genero: '',
                sinopsis: '',
                cartel: '',
                trailer: '',
                id_youtube: '',
                fechaEstreno: '',
                sesion_id: 'NULL',
            }
        };
    },
    created() {
        this.fetchMovies();
        this.fetchSessions();
        this.fetchNovedades();

    },
    methods: {
        toggleMovies() {
            this.showMovies = !this.showMovies;
            this.showSessions = false;
            this.showNovedades = false;
        },
        toggleSessions() {
            this.showSessions = !this.showSessions;
            this.showMovies = false;
            this.showNovedades = false;
        },
        toggleNovedades() {
            this.showNovedades = !this.showNovedades;
            this.showMovies = false;
            this.showSessions = false;
        },
        openCreateMovieModal() {
            this.showCreateMovieModal = true;
        },
        closeCreateMovieModal() {
            this.showCreateMovieModal = false;
        },

        async fetchMovies() {
            try {
                const response = await fetch('http://127.0.0.1:8000/api/listarPeliculas');
                if (!response.ok) {
                    throw new Error('Error al obtener las películas');
                }
                const data = await response.json();
                this.movies = data.data;
            } catch (error) {
                console.error(error);
            }
        },
        async fetchSessions() {
            try {
                const response = await fetch('http://127.0.0.1:8000/api/listarSesiones');
                if (!response.ok) {
                    throw new Error('Error al obtener las sesiones');
                }
                const data = await response.json();
                this.sessions = data.data.map(session => {
                    const [date, time] = session.fecha.split(' ');
                    return {
                        ...session,
                        fecha: this.formatDate(date),
                        hora: time
                    };
                });
            } catch (error) {
                console.error(error);
            }
        },
        async fetchNovedades() {
            try {
                const response = await fetch('http://127.0.0.1:8000/api/listarNovedades');
                if (!response.ok) {
                    throw new Error('Error al obtener las novedades');
                }
                const data = await response.json();
                this.novedades = data.data;
            } catch (error) {
                console.error(error);
            }
        },
        createItem() {
            // Lógica para crear un elemento (película o sesión)
        },
        modifyItem() {
            // Lógica para modificar un elemento (película o sesión)
        },
        deleteItem() {
            // Lógica para eliminar un elemento (película o sesión)
        },
        formatDuration(duration) {
            const hours = Math.floor(duration / 60);
            const minutes = duration % 60;
            return `${hours}h ${minutes}min`;
        },
        formatDate(dateString) {
            const [year, month, day] = dateString.split('-');
            return `${day}/${month}/${year}`;
        },
        formatEstreno(estreno) {
            const [year, month, day] = estreno.split('-');
            return `${day}/${month}/${year}`;
        }
    }
};
</script>

<style scoped>
.admin-container {
    max-width: 1200px;
    margin: 0 auto;
    margin-top: 20px;
}

.options-container {
    display: flex;
    justify-content: space-around;
    margin-bottom: 20px;
}

.movies-button,
.sessions-button,
.novedades-button,
.entrades-button {
    padding: 10px 20px;
    font-size: 16px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.movies-button:hover,
.sessions-button:hover,
.novedades-button:hover {
    background-color: #c00;
}

.movies-options {
    text-align: center;
    margin-top: 20px;
}

h2 {
    margin-bottom: 10px;
}

.grid-container {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr 1fr 3fr 2fr;
    gap: 10px;
    margin-bottom: 20px;
}

.grid-container2 {
    display: grid;
    grid-template-columns: 1fr 2fr 1fr 1fr 1fr 2fr;
    gap: 10px;
    margin-bottom: 20px;
}

.grid-item-header {
    background-color: #f2f2f2;
    padding: 10px;
    font-weight: bold;
    text-align: center;
    border: 1px solid #ddd;
}

.grid-item {
    align-items: center;
    text-align: center;
    font-size: 16px;
}

.grid-item :last-child {
    text-align: left;
}

.items-list {
    margin-top: 20px;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
    opacity: 0;
}

.option-button {
    padding: 10px 15px;
    font-size: 16px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-bottom: 10px;
}

.option-button:hover {
    background-color: #c00;
}

.boton-derecha {
    text-align: right;
    margin-right: 105px;
}

.option-button2 {
    padding: 10px 15px;
    font-size: 16px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-bottom: 25px;
    margin-top: 15px;
}

.option-button2:hover {
    background-color: #c00;
}
.modal {
  display: block;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>