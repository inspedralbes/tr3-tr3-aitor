<template>
  <footer class="site-footer">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <div class="row">
            <div class="col-xs-12">
              <h6 class="footer-title">About</h6>
              <p class="footer-text">El Cine de Can Casteller es un espacio dedicado a la proyección de películas que abarcan una amplia variedad de géneros y estilos. Nuestro objetivo es proporcionar una experiencia cinematográfica única para todos nuestros espectadores. Desde clásicos del cine hasta las últimas novedades, en el Cine de Can Casteller encontrarás una selección cuidadosamente curada de películas que te harán reír, llorar, reflexionar y emocionarte.</p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="row">
            <div class="col-xs-12">
              <h6 class="footer-title">Quick Links</h6>
              <ul class="footer-links">
                <li><a href="http://scanfcode.com/about/">Home</a></li>
                <li><a href="http://scanfcode.com/contact/">Peliculas</a></li>
                <li><a href="http://scanfcode.com/contribute-at-scanfcode/">Novedades</a></li>
                <li><a href="http://scanfcode.com/privacy-policy/">Trailers</a></li>
                <li><a href="http://scanfcode.com/sitemap/">Contactanos</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <hr class="footer-hr">
    </div>
    <div class="container">
      <div class="row">
        <div class="col-md-8 col-sm-6 col-xs-12">
          <p class="copyright-text">Copyright &copy; 2024 Todos los derecho reservador para
            <a href="#" class="copyright-link">Can Casteller</a>.
          </p>
        </div>

        <div class="col-md-4 col-sm-6 col-xs-12">
          <ul class="social-icons">
            <li><a class="social-icon" href="#"><img src="../public/facebook.png" alt="Facebook"></a></li>
            <!-- Agrega aquí los otros íconos sociales -->
          </ul>
        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped>
/* Estilos para el footer */
.site-footer {
  background-color: black;
  padding: 45px 0 20px;
  color: white;
}

.footer-title {
  font-size: 16px;
  text-transform: uppercase;
  margin-top: 5px;
  letter-spacing: 2px;
}

.footer-text {
  font-size: 15px;
  line-height: 24px;
}

.footer-links {
  padding-left: 0;
  list-style: none;
}

.footer-links li {
  display: block;
}

.footer-links a {
  color: white;
}

.footer-links a:hover {
  color: #3366cc;
  text-decoration: none;
}

.footer-hr {
  border-top-color: #bbb;
  opacity: 0.5;
  margin: 20px 0;
}

.copyright-text {
  font-size: 15px;
  line-height: 24px;
}

.copyright-link {
  color: #29aafe;
}

.social-icons {
  text-align: center;
}

.social-icon {
  display: inline-block;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background-color: #33353d;
  margin-right: 8px;
}

.social-icon img {
  width: 100%;
  height: 100%;
}

@media (max-width: 767px) {
  .site-footer [class^="col-"] {
    margin-bottom: 30px;
  }

  .site-footer hr {
    margin: 20px auto;
  }

  .site-footer .copyright-text,
  .site-footer .social-icons {
    text-align: center;
  }

  .social-icons li.title {
    display: block;
    margin-right: 0;
    font-weight: 600;
  }
}
</style>
