<template>
    <div>
      <h2>Novedades de Películas</h2>
      <div v-if="loading" class="loading">Cargando...</div>
      <div v-else class="movies-container">
        <article v-for="movie in sortedMovies" :key="movie.id" class="movie-card">
          <div class="movie-poster-wrapper">
            <img :src="`${movie.poster}`" :alt="movie.title" class="movie-poster">
          </div>
          <div class="movie-info">
            <h3 class="movie-title">{{ movie.title }}</h3>
            <p class="movie-synopsis">{{ movie.sinopsis }}</p>
            <p class="movie-release">Fecha de lanzamiento: {{ movie.estreno }}</p>
          </div>
        </article>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        movies: [
            {
                id: 1,
                title: 'Teen Wolf La Pelicula',
                sinopsis: 'Scott Howard juega al baloncesto. No es ni el mejor jugador ni el más alto, pero no por ello desiste de su sueño: triunfar con el equipo del instituto. ',
                estreno: '26-03-2024',
                poster: 'wolf.jpg'
            },
            {
                id: 2,
                title: 'Sinister',
                sinopsis: 'Ellison, es un periodista especializado en escribir artículos y novelas sobre casos de crímenes célebres.',
                estreno: '31-10-2024',
                poster: 'sinister.jpg'
            },
            {
                id: 3,
                title: 'The Flash',
                sinopsis: 'Los mundos chocan en "Flash" cuando Barry utiliza sus superpoderes para viajar en el tiempo y cambiar los acontecimientos del pasado.',
                estreno: '16-06-2024',
                poster: 'flash.jpg'
            },
            {
                id: 4,
                title: 'Indiginous',
                sinopsis: 'inco amigos se encuentran en Panamá para una vacaciones. En una fiesta escuchan las historias acerca de una bonita cascada en el interior de la selva y, sin hacer caso a las advertencias, deciden ir a buscarla.',
                estreno: '20-04-2024',
                poster: 'indiginous.jpg'
            },
            {
                id: 5,
                title: 'Inazuma Eleven La Pelicula',
                sinopsis: 'El colegio Raimon ha llegado a las semifinales de Fútbol Frontier y deben enfrentarse al Equipo Ogro del colegio Rey Colmillo. En la lucha se darán cuenta que las técnicas habituales no tendrán el mismo resultado, además de que la táctica empleada por el equipo contrincante no es común.',
                estreno: '23-12-2024',
                poster: 'inazuma.jpg'
            },
            {
                id: 6,
                title: 'Five Nights at Freddy s',
                sinopsis: 'n hombre comienza un trabajo como guardia de seguridad nocturno en el restaurante Freddy Fazbear s Pizza, donde descubre que los animatrónicos se mueven por la noche y matan a cualquiera que vean. ',
                estreno: '27-10-2024',
                poster: 'five.jpg'
            },
            {
                id: 7,
                title: 'Capitan America Civil War',
                sinopsis: 'Después de que otro incidente internacional involucre a Los Vengadores, causando varios daños colaterales, aumentan las presiones políticas para instaurar un sistema que exija más responsabilidades y que determine cuándo deben contratar los servicios del grupo de superhéroes.',
                estreno: '29-04-2024',
                poster: 'capi.jpg'
            },
            {
                id: 8,
                title: 'Imaginary',
                sinopsis: 'Cuando Jessica vuelve con su familia a la casa de su infancia, Alice, su hijastra más pequeña, comienza a desarrollar un extraño apego hacia Chauncey, el oso de peluche que encuentra en el sótano.',
                estreno: '15-03-2024',
                poster: 'imaginary.jpg'
            },
            {
                id: 9,
                title: 'Escape Room',
                sinopsis: 'Seis personas quedan atrapadas en un escape room cuyo creador ha diseñado una trampa mortal en cada habitación. No saben por qué les está haciendo esto, pero sí saben que un solo error les costará la vida.',
                estreno: '04-04-2024',
                poster: 'escape.jpg'
            },
            {
                id: 10,
                title: 'Horror Park',
                sinopsis: 'El Padrino V es una película de 2024 dirigida por Francis Ford Coppola, secuela de El Padrino IV. La película cuenta la historia de la familia Corleone, con Vito Corleone a la cabeza, y su hijo Michael Corleone.',
                estreno: '23-05-2024',
                poster: 'horror.jpg'
            },
            {
                id: 11,
                title: 'Insidious',
                sinopsis: 'Josh (Patrick Wilson), su esposa Renai (Rose Byrne) y sus tres hijos acaban de mudarse a una vieja casa. Pero, tras un desgraciado accidente, uno de los niños entra en coma y, al mismo tiempo, empiezan a producirse en la casa extraños fenómenos que aterrorizan a la familia.',
                estreno: '10-06-2024',
                poster: 'insidious.jpg'
            },
            {
                id: 12,
                title: 'Verdad o Reto',
                sinopsis: 'Una inofensiva partida de Verdad o reto entre un grupo de amigos acaba convirtiéndose en un juego letal cuando alguien -o algo- empieza a castigar a los que mienten o no aceptan el reto.',
                estreno: '13-04-2024',
                poster: 'reto.jpg'
            },

        ],
        loading: false
      };
    },
    computed: {
      sortedMovies() {
        return this.movies.slice().sort((a, b) => {
          // Convertir las fechas a objetos Date para poder compararlas
          const dateA = new Date(a.estreno);
          const dateB = new Date(b.estreno);
          // Ordenar por fecha de lanzamiento descendente (más reciente primero)
          return dateB - dateA;
        });
      }
    }
  };
  </script>
  
  <style scoped>
  :root {
    --color-primary: #0056b3;
    --color-secondary: #6c757d;
    --color-border: #e2e2e2;
    --background-card: #ffffff;
    --font-family-base: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    --border-radius-base: 8px;
  }
  
  .movies-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 20px; /* Margen inferior agregado */
  }
  
  @media (min-width: 768px) {
    .movies-container {
      grid-template-columns: repeat(2, 1fr);
    }
  }
  
  @media (min-width: 992px) {
    .movies-container {
      grid-template-columns: repeat(3, 1fr);
    }
  }
  
  @media (min-width: 1200px) {
    .movies-container {
      grid-template-columns: repeat(4, 1fr);
    }
  }
  
  .movie-card {
    display: flex;
    flex-direction: column;
    border: 1px solid var(--color-border);
    border-radius: var(--border-radius-base);
    overflow: hidden;
    background-color: var(--background-card);
    transition: box-shadow 0.3s ease;
    cursor: pointer;
  }
  
  .movie-card:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }
  
  .movie-poster-wrapper {
    line-height: 0;
    margin-bottom: 10px;
  }
  
  .movie-poster {
    width: 100%;
    height: auto;
    display: block;
    border-radius: var(--border-radius-base) var(--border-radius-base) 0 0;
  }
  
  .movie-info {
    padding: 15px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
  }
  
  .movie-title {
    margin: 0;
    font-size: 1.2rem;
    color: var(--color-primary);
  }
  
  .movie-synopsis {
    margin: 5px 0 10px 0;
    font-size: 1rem;
    color: #444;
  }
  
  .movie-release {
    margin: 0;
    font-style: italic;
    color: var(--color-secondary);
  }
  
  .loading {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 200px;
    font-size: 1.2rem;
  }
  </style>
  