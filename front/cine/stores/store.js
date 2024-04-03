// store.js
import { defineStore } from 'pinia';

// Definir el store para las películas
export const usePeliculasStore = defineStore('peliculas', {
  state: () => ({
    peliculaSeleccionada: null,
  }),
  actions: {
    guardarPeliculaSeleccionada(pelicula) {
      this.peliculaSeleccionada = pelicula;
    },
  },
});

// Definir el store para el usuario
export const useUserStore = defineStore({
  id: 'user',
  state: () => ({
    user: null,
  }),
  actions: {
    setUser(userData) {
      this.user = userData;
    },
    clearUser() {
      this.user = null;
    },
  },
});
