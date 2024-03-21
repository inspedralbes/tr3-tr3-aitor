import { defineStore } from 'pinia';

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
