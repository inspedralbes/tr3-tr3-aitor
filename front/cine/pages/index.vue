<template>
  <div>
    <div class="container">
      <div class="box">
        <span style="--i: 1;"><img src="../public/infinty.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 2;"><img src="../public/monja.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 3;"><img src="../public/ant.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 4;"><img src="../public/swim.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 5;"><img src="../public/anna.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 6;"><img src="../public/guardianes.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 7;"><img src="../public/torrente.jpg" alt="Próximo Estreno"></span>
        <span style="--i: 8;"><img src="../public/resaca.jpg" alt="Próximo Estreno"></span>
      </div>
    </div>

    <div class="main-page">
      <div class="section" id="recipes">
        <nuxt-link to="/peliculas">
          <img src="../public/peliculas.jpg" alt="Nuestros Productos" class="rectangular-img" />
          <div class="text-overlay">
            <h2>NUESTRAS PELICULAS</h2>
            <p>Peliculas de alta categoría</p>
          </div>
        </nuxt-link>
      </div>
      <div class="sidebar">
        <div class="section" id="franchise">
          <nuxt-link to="/novedades">
            <img src="../public/novedades.jpg" alt="novedades" class="square-img" />
            <div class="text-overlay">
              <h2>Novedades</h2>
            </div>
          </nuxt-link>
        </div>
        <div class="section" id="contact">
          <nuxt-link to="/contactanos">
            <img src="../public/contact.jpg" alt="Contacta con Nosotros" class="square-img" />
            <div class="text-overlay">
              <h2>CONTACTA CON NOSOTROS</h2>
            </div>
          </nuxt-link>
        </div>
      </div>

      <section class="section">
        <h2>Horarios de Función:</h2>
        <p>Lunes a Viernes: [Horarios]</p>
        <p>Sábados y Domingos: [Horarios]</p>
      </section>
      <section class="section">
        <h2>Explora nuestras Instalaciones:</h2>
        <p>Salas de Cine Modernas</p>
        <p>Sonido Dolby Atmos</p>
        <p>Amplia Selección de Snacks y Bebidas</p>
      </section>
    </div>
  </div>
</template>

<script>
export default {
  name: "RotatingImages"
};
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
}

.box {
  position: relative;
  width: 600px;
  /* Ajusta el ancho de la caja del carrusel */
  height: 300px;
  /* Ajusta la altura de la caja del carrusel */
  transform-style: preserve-3d;
  animation: animado 20s linear infinite;
}

.box span {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  transform-origin: center;
  transform-style: preserve-3d;
  transform: rotateY(calc(var(--i) * 45deg)) translateZ(400px);
  -webkit-box-reflect: below 0px linear-gradient(transparent, transparent, #0004);
}

.box span img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: contain;
  /* Cambiado de cover a contain */
}

.main-page {
  display: flex;
  justify-content: center;
}

.section {
  width: calc(50% - 10px);
  margin-bottom: 20px;
  overflow: hidden;
  position: relative;
}

.section:last-child {
  margin-bottom: 20px;
}

.section img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.text-overlay {
  position: absolute;
  bottom: 20px;
  left: 20px;
  color: white;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  opacity: 1;
  transition: opacity 0.3s ease;
}

.section:hover .text-overlay {
  opacity: 0;
}

.sidebar {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.rectangular-img {
  width: 100%;
  height: 100%;
  max-width: 600px;
  max-height: 400px;
  object-fit: cover;
}

.square-img {
  width: 100%;
  height: 50%;
}

@keyframes animado {
  0% {
    transform: perspective(1000px) rotateY(0deg);
  }

  100% {
    transform: perspective(1000px) rotateY(360deg);
  }
}
</style>