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
                        <button @click="openEditMovieModal(movie)" class="option-button">Modificar</button><br>
                        <button @click="deleteMovie(movie.id)" class="option-button">Eliminar</button>
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
                        <button @click="openEditSessionModal(session)" class="option-button">Modificar</button><br>
                        <button @click="deleteSesion(session.id)" class="option-button">Eliminar</button>
                    </div>
                </div>
                <div class="boton-derecha">
                    <button class="option-button2" @click="openCreateSessionModal">Crear</button>
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
                        <button @click="openEditNovedadModal(novedad)" class="option-button">Modificar</button><br>
                        <button @click="deleteNovedad (novedad.id)" class="option-button">Eliminar</button>
                    </div>
                </div>
                <div class="boton-derecha">
                    <button class="option-button2" @click="openCreateNovedadModal">Crear</button>
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
                    <label for="genero">Género:</label>
                    <input type="text" id="genero" v-model="newMovie.genero" required>
                    <label for="sinopsis">Sinopsis:</label>
                    <textarea id="sinopsis" v-model="newMovie.sinopsis" required></textarea>
                    <label for="cartel">Cartel:</label>
                    <input type="text" id="cartel" v-model="newMovie.cartel" required>
                    <label for="trailer">Trailer:</label>
                    <input type="text" id="trailer" v-model="newMovie.trailer" required>
                    <label for="id_youtube">ID Youtube:</label>
                    <input type="text" id="id_youtube" v-model="newMovie.id_youtube" required>
                    <label for="fechaEstreno">Fecha de Estreno:</label>
                    <input type="date" id="fechaEstreno" v-model="newMovie.fechaEstreno" required>
                    <label for="sesion_id">Sesión:</label>
                    <input type="number" id="sesion_id" v-model="newMovie.sesion_id">
                    <button type="submit">Crear Película</button>
                </form>
            </div>
        </div>
        <div class="modal" v-if="showEditMovieModal">
            <div class="modal-content">
                <span class="close" @click="closeEditMovieModal">&times;</span>
                <h2>Modificar Película</h2>
                <form @submit.prevent="submitEditMovie">
                    <!-- Campos de edición de la película -->
                    <label for="titulo">Título:</label>
                    <input type="text" id="titulo" v-model="selectedMovie.titulo" required>
                    <label for="duracion">Duración:</label>
                    <input type="number" id="duracion" v-model="selectedMovie.duracion">
                    <label for="genero">Género:</label>
                    <input type="text" id="genero" v-model="selectedMovie.genero">
                    <label for="sinopsis">Sinopsis:</label>
                    <textarea id="sinopsis" v-model="selectedMovie.sinopsis"></textarea>
                    <label for="cartel">Cartel:</label>
                    <input type="text" id="cartel" v-model="selectedMovie.cartel">
                    <label for="trailer">Trailer:</label>
                    <input type="text" id="trailer" v-model="selectedMovie.trailer">
                    <label for="id_youtube">ID Youtube:</label>
                    <input type="text" id="id_youtube" v-model="selectedMovie.id_youtube">
                    <label for="fechaEstrenoEdit">Fecha de Estreno:</label>
                    <input type="date" id="fechaEstrenoEdit" v-model="selectedMovie.fechaEstreno">
                    <label for="sesion_id">Sesión:</label>
                    <input type="number" id="sesion_id" v-model="selectedMovie.sesion_id">
                    <button type="submit">Modificar Película</button>
                </form>
            </div>
        </div>

    </div>
    <div class="modal" v-if="showDeleteConfirmation">
        <div class="modal-content">
            <h2>¿Estás seguro de que quieres eliminar esta pelicula?</h2>
            <div class="modal-buttons">
                <button @click="deleteConfirmed">Sí, eliminar</button>
                <button @click="cancelDelete">Cancelar</button>
            </div>
        </div>
    </div>
    <div class="modal" v-if="showCreateSessionModal">
        <div class="modal-content">
            <span class="close" @click="closeCreateSessionModal">&times;</span>
            <h2>Crear Nueva Sesión</h2>
            <form @submit.prevent="submitNewSesion">
                <label for="fecha">Fecha:</label>
                <input type="date" id="fecha" v-model="newSesion.fecha" required>
                <label>Día Espectador:</label>
                <div class="radio-buttons">
                    <input type="radio" id="opcion1" value="0" v-model="newSesion.diaEspectador" required>
                    <label for="opcion1">NO</label>
                    <input type="radio" id="opcion2" value="1" v-model="newSesion.diaEspectador">
                    <label for="opcion2">SI</label>
                </div>
                <label for="precio">Precio:</label>
                <input type="decimal" id="precio" v-model="newSesion.precio" required>
                <button type="submit">Crear Sesión</button>
            </form>
        </div>
    </div>
    <div class="modal" v-if="showEditSessionModal">
        <div class="modal-content">
            <span class="close" @click="closeEditSessionModal">&times;</span>
            <h2>Modificar Sesión</h2>
            <form @submit.prevent="submitEditSession">
                <!-- Campos de edición de la sesión -->
                <label for="fecha">Fecha:</label>
                <input type="date" id="fecha" v-model="selectedSession.fecha" required>
                <label>Día Espectador:</label>
                <div class="radio-buttons">
                    <input type="radio" id="opcion1" value="0" v-model="selectedSession.diaEspectador" required>
                    <label for="opcion1">NO</label>
                    <input type="radio" id="opcion2" value="1" v-model="selectedSession.diaEspectador">
                    <label for="opcion2">SI</label>
                </div>
                <label for="precio">Precio:</label>
                <input type="decimal" id="precio" v-model="selectedSession.precio" required>
                <button type="submit">Modificar Sesión</button>
            </form>
        </div>
    </div>
    <div class="modal" v-if="showDeleteSessionConfirmation">
        <div class="modal-content">
            <h2>¿Estás seguro de que quieres eliminar esta sesión, tambien eliminaras la pelicula?</h2>
            <div class="modal-buttons">
                <button @click="deleteSessionConfirmed">Sí, eliminar</button>
                <button @click="cancelDeleteSession">Cancelar</button>
            </div>
        </div>
    </div>
    <div class="modal" v-if="showCreateNovedadModal">
        <div class="modal-content">
            <span class="close" @click="closeCreateNovedadModal">&times;</span>
            <h2>Crear Nueva Novedad</h2>
            <form @submit.prevent="submitNewNovedad">
                <!-- Campos de creación de la novedad -->
                <label for="titulo">Título:</label>
                <input type="text" id="titulo" v-model="newNovedad.title" required>
                <label for="genero">Género:</label>
                <input type="text" id="genero" v-model="newNovedad.genero" required>
                <label for="sinopsis">Sinopsis:</label>
                <textarea id="sinopsis" v-model="newNovedad.sinopsis" required></textarea>
                <label for="estreno">Estreno:</label>
                <input type="date" id="estreno" v-model="newNovedad.estreno" required>
                <label for="poster">Poster:</label>
                <input type="text" id="poster" v-model="newNovedad.poster" required>
                <label for="trailer">Trailer:</label>
                <input type="text" id="trailer" v-model="newNovedad.trailer" required>
                <label for="id_youtube">ID Youtube:</label>
                <input type="text" id="id_youtube" v-model="newNovedad.id_youtube" required>
                <button type="submit">Crear Novedad</button>
            </form>
        </div>
    </div>
    <div class="modal" v-if="showEditNovedadModal">
        <div class="modal-content">
            <span class="close" @click="closeEditNovedadModal">&times;</span>
            <h2>Modificar Novedad</h2>
            <form @submit.prevent="submitEditNovedad">
                <!-- Campos de edición de la novedad -->
                <label for="title">Título:</label>
                <input type="text" id="title" v-model="selectedNovedad.title">
                <label for="genero">Género:</label>
                <input type="text" id="genero" v-model="selectedNovedad.genero" >
                <label for="sinopsis">Sinopsis:</label>
                <textarea id="sinopsis" v-model="selectedNovedad.sinopsis" ></textarea>
                <label for="estreno">Estreno:</label>
                <input type="date" id="estreno" v-model="selectedNovedad.estreno" >
                <label for="poster">Poster:</label>
                <input type="text" id="poster" v-model="selectedNovedad.poster" >
                <label for="trailer">Trailer:</label>
                <input type="text" id="trailer" v-model="selectedNovedad.trailer" >
                <label for="id_youtube">ID Youtube:</label>
                <input type="text" id="id_youtube" v-model="selectedNovedad.id_youtube" >
                <button type="submit">Modificar Novedad</button>
            </form>
        </div>
    </div>
    <div class="modal" v-if="showDeleteNovedadConfirmation">
        <div class="modal-content">
            <h2>¿Estás seguro de que quieres eliminar esta novedad?</h2>
            <div class="modal-buttons">
                <button @click="deleteNovedadConfirmed">Sí, eliminar</button>
                <button @click="cancelDeleteNovedad">Cancelar</button>
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
            showDeleteConfirmation: false,
            selectedMovie: null,
            showEditMovieModal: false,
            showCreateSessionModal: false,
            showDeleteSessionConfirmation: false,
            showDeleteNovedadConfirmation: false,
            showEditSessionModal: false,
            selectedSession: null,
            sessionToDeleteId: null,
            movieToDeleteId: null,
            showCreateNovedadModal: false,
            showEditNovedadModal: false,
            selectedNovedad: null,
            newMovie: {
                titulo: '',
                duracion: 0,
                genero: '',
                sinopsis: '',
                cartel: '',
                trailer: '',
                id_youtube: '',
                fechaEstreno: '',
                sesion_id: '',
            },
            newSesion: {
                fecha: '',
                diaEspectador: '',
                precio: 0,
            },
            newNovedad: {
                title: '',
                genero: '',
                sinopsis: '',
                estreno: '',
                poster: '',
                trailer: '',
                id_youtube: '',

            },
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
        openEditMovieModal(movie) {
            this.selectedMovie = movie;
            this.showEditMovieModal = true;
        },

        closeEditMovieModal() {
            this.selectedMovie = null;
            this.showEditMovieModal = false;
        },
        openCreateSessionModal() {
            this.showCreateSessionModal = true; // Mostrar el modal de creación de sesiones al hacer clic en el botón "Crear" de sesiones
        },
        closeCreateSessionModal() {
            this.showCreateSessionModal = false; // Cerrar el modal de creación de sesiones
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
        async submitNewMovie() {
            try {
                const response = await fetch('http://127.0.0.1:8000/api/crearPelicula', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(this.newMovie),
                });
                const responseData = await response.json();
                console.log('Respuesta del servidor:', responseData);

                if (response.ok) {
                    // Limpiar los campos después de la inserción exitosa
                    this.clearFields();
                    // Cerrar el modal
                    this.closeCreateMovieModal();
                } else {
                    throw new Error('Error al crear la película');
                }
            } catch (error) {
                console.error(error);
            }
        },
        async submitNewSesion() {
            try {
                const response = await fetch('http://127.0.0.1:8000/api/crearSesion', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(this.newSesion),
                });
                const responseData = await response.json();
                console.log('Respuesta del servidor:', responseData);

                if (response.ok) {
                    // Limpiar los campos después de la inserción exitosa
                    this.clearFields();
                    // Cerrar el modal
                    this.closeCreateSessionModal();
                } else {
                    throw new Error('Error al crear la sesion');
                }
            } catch (error) {
                console.error(error);
            }
        },
        async submitEditMovie() {
            console.log('Datos a enviar al servidor:', this.selectedMovie);

            try {
                const response = await fetch(`http://127.0.0.1:8000/api/modificarPelicula/${this.selectedMovie.id}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(this.selectedMovie),
                });
                if (!response.ok) {
                    throw new Error('Error al modificar la película');
                }
                // Actualizar la lista de películas después de la modificación exitosa
                await this.fetchMovies();
                // Cerrar el modal de edición
                this.closeEditMovieModal();
            } catch (error) {
                console.error(error);
            }
        },

        clearFields() {
            // Vaciar los campos del formulario después de una inserción exitosa
            this.newMovie = {
                titulo: '',
                duracion: 0,
                genero: '',
                sinopsis: '',
                cartel: '',
                trailer: '',
                id_youtube: '',
                fechaEstreno: '',
                sesion_id: '',
            };
            this.newSesion = {
                fecha: '',
                diaEspectador: '',
                precio: 0,
            };
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
        },
        async deleteCampo(id) {
            // Muestra el modal de confirmación antes de eliminar
            this.showDeleteConfirmation = true;
            // Guarda el ID de la película que se va a eliminar para usarlo en el método deleteConfirmed
            this.movieToDeleteId = id;
        },
        // Método para confirmar la eliminación
        async deleteConfirmed() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/eliminarPelicula/${this.movieToDeleteId}`, {
                    method: 'DELETE'
                });
                if (!response.ok) {
                    throw new Error('Error al eliminar el elemento');
                }
                // Actualiza la lista después de la eliminación exitosa
                await this.fetchMovies();
            } catch (error) {
                console.error(error);
            } finally {
                // Oculta el modal de confirmación
                this.showDeleteConfirmation = false;
            }
        },
        // Método para cancelar la eliminación
        cancelDelete() {
            this.showDeleteConfirmation = false;
        },
        async deleteNovedades(id) {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/eliminarNovedades/${id}`, {
                    method: 'DELETE'
                });
                if (!response.ok) {
                    throw new Error('Error al eliminar el elemento');
                }
                // Actualiza la lista después de la eliminación exitosa
                await this.fetchNovedades();
            } catch (error) {
                console.error(error);
            }
        },
        deleteSesion(id) {
            // Muestra el modal de confirmación antes de eliminar
            this.showDeleteSessionConfirmation = true;
            // Guarda el ID de la sesión que se va a eliminar para usarlo en el método deleteSessionConfirmed
            this.sessionToDeleteId = id;
        },
        deleteNovedad(id) {
            // Muestra el modal de confirmación antes de eliminar
            this.showDeleteNovedadConfirmation = true;
            // Guarda el ID de la sesión que se va a eliminar para usarlo en el método deleteSessionConfirmed
            this.novedadToDeleteId = id;
        },

        async deleteSessionConfirmed() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/eliminarSesion/${this.sessionToDeleteId}`, {
                    method: 'DELETE'
                });
                if (!response.ok) {
                    throw new Error('Error al eliminar la sesión');
                }
                // Actualiza la lista después de la eliminación exitosa
                await this.fetchSessions();
            } catch (error) {
                console.error(error);
            } finally {
                // Oculta el modal de confirmación
                this.showDeleteSessionConfirmation = false;
            }
        },
        async deleteNovedadConfirmed() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/eliminarNovedades/${this.novedadToDeleteId}`, {
                    method: 'DELETE'
                });
                if (!response.ok) {
                    throw new Error('Error al eliminar la novedad');
                }
                // Actualiza la lista después de la eliminación exitosa
                await this.fetchNovedades();
            } catch (error) {
                console.error(error);
            } finally {
                // Oculta el modal de confirmación
                this.showDeleteNovedadConfirmation = false;
            }
        },

        cancelDeleteSession() {
            // Oculta el modal de confirmación sin eliminar la sesión
            this.showDeleteSessionConfirmation = false;
        },
        cancelDeleteNovedad() {
            // Oculta el modal de confirmación sin eliminar la sesión
            this.showDeleteNovedadConfirmation = false;
        },
        openEditSessionModal(session) {
            this.selectedSession = session;
            this.showEditSessionModal = true;
        },
        // Método para cerrar el modal de edición de sesiones
        closeEditSessionModal() {
            this.selectedSession = null;
            this.showEditSessionModal = false;
        },
        // Método para enviar la solicitud de modificación de la sesión al servidor
        async submitEditSession() {
            try {
                const response = await fetch(`http://127.0.0.1:8000/api/modificarSesion/${this.selectedSession.id}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(this.selectedSession),
                });
                if (!response.ok) {
                    throw new Error('Error al modificar la sesión');
                }
                // Actualizar la lista de sesiones después de la modificación exitosa
                await this.fetchSessions();
                // Cerrar el modal de edición de sesiones
                this.closeEditSessionModal();
            } catch (error) {
                console.error(error);
            }
        },
        openCreateNovedadModal() {
            this.showCreateNovedadModal = true;
        },
        // Método para cerrar el modal de creación de novedades
        closeCreateNovedadModal() {
            this.showCreateNovedadModal = false;
        },
        // Método para enviar la solicitud de creación de la novedad al servidor
        async submitNewNovedad() {
            try {
                const response = await fetch('http://127.0.0.1:8000/api/crearNovedades', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(this.newNovedad),
                });
                if (!response.ok) {
                    throw new Error('Error al crear la novedad');
                }
                // Limpiar los campos después de la creación exitosa
                this.clearFields();
                // Cerrar el modal de creación de novedades
                this.closeCreateNovedadModal();
                // Actualizar la lista de novedades
                await this.fetchNovedades();
            } catch (error) {
                console.error(error);
            }
        },
        // Método para limpiar los campos del formulario después de la creación exitosa
        clearFields() {
            this.newNovedad = {
                title: '',
                genero: '',
                estreno: '',
                sinopsis: '',
                poster: '',
                trailer: '',
                id_youtube: '',
            };
        },
        openEditNovedadModal(novedad) {
        this.selectedNovedad = novedad;
        this.showEditNovedadModal = true;
    },

    closeEditNovedadModal() {
        this.selectedNovedad = null;
        this.showEditNovedadModal = false;
    },

    async submitEditNovedad() {
        try {
            const response = await fetch(`http://127.0.0.1:8000/api/modificarNovedades/${this.selectedNovedad.id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(this.selectedNovedad),
            });
            if (!response.ok) {
                throw new Error('Error al modificar la novedad');
            }
            // Actualizar la lista de novedades después de la modificación exitosa
            await this.fetchNovedades();
            // Cerrar el modal de edición de novedades
            this.closeEditNovedadModal();
        } catch (error) {
            console.error(error);
        }
    },
    },
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
    /* Ocultar el modal por defecto */
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
    border-radius: 10px;
    /* Agregar bordes redondeados */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    /* Agregar sombra */
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

.modal-buttons {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
}

.modal-buttons button {
    padding: 10px 20px;
    font-size: 16px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.modal-buttons button:hover {
    background-color: #c00;
}

.modal-content label {
    display: block;
    margin-bottom: 10px;
    font-size: 16px;
}

.modal-content input[type="text"],
.modal-content input[type="number"],
.modal-content input[type="date"],
.modal-content input[type="decimal"],
.modal-content textarea {
    width: calc(100% - 20px);
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-bottom: 10px;
}

.radio-buttons {
    display: flex;
}

.radio-buttons input[type="radio"] {
    display: none;
}

.radio-buttons input[type="radio"]+label {
    padding: 8px 16px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 5px;
    cursor: pointer;
    margin-right: 10px;
}

.radio-buttons input[type="radio"]:checked+label {
    background-color: red;
    color: white;
}

.modal-content button[type="submit"] {
    padding: 10px 20px;
    font-size: 16px;
    background-color: red;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.modal-content button[type="submit"]:hover {
    background-color: #c00;
}
</style>