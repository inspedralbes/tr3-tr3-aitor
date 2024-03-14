<template>
    <footer class="footer">
        <div class="container">
            <div class="footer-info">
                <h2>Can Casteller</h2>
                <p>Somos un cine localizado en la ciudad de Sant Boi de Llobregat, dedicado a brindar una experiencia cinematográfica excepcional a nuestros visitantes.</p>
            </div>
            <div class="footer-links">
                <h3>Enlaces</h3>
                <ul>
                    <li>
                        <NuxtLink to="/" class="footer-link">Inicio</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/peliculas" class="footer-link">Peliculas</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/sesiones" class="footer-link">Sesiones</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/novedades" class="footer-link">Novedades</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/trailers" class="footer-link">Trailers</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/contactanos" class="footer-link">Contáctanos</NuxtLink>
                    </li>
                </ul>
            </div>
            <div class="footer-contact">
                <h3>Contacto</h3>
                <p>Dirección: Carrer de Jaume I, 28, 08830 Sant Boi de Llobregat, Barcelona</p>
                <br>
                <p>Teléfono: 936 61 61 12</p>
                <br>
                <p>Email: info@cancasteller.com</p>
            </div>
        </div>
        <div class="footer-social">
            <h3>Síguenos</h3>
            <div class="social-icons">
                <a href="https://www.facebook.com/CinemesCanCastellet/?locale=es_ES" class="social-icon"><img src="../public/facebook.png" alt="Facebook"></a>
                <a href="https://www.instagram.com/cinemescancastellet/?hl=es" class="social-icon"><img src="../public/instagram.png" alt="Instagram"></a>
                <a href="https://twitter.com/notifications" class="social-icon"><img src="../public/twitter.png" alt="Twitter"></a>
                <a href="https://www.youtube.com/channel/UCSfEoDHK0K6UlHOdRkqGt8Q" class="social-icon"><img src="../public/youtube.png" alt="YouTube"></a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 En Can Casteller. Todos los derechos reservados.</p>
        </div>
    </footer>
</template>

<script>
export default {
    // Opciones del componente, si es necesario
}
</script>

<style scoped>
.footer {
    background-color: black;
    color: #fff;
    padding: 50px 0;
}

.container {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}

.footer-info,
.footer-links,
.footer-contact {
    margin-right: 50px;
    flex: 1;
    margin-bottom: 20px;
}

.footer-info {
    margin-left: 25px;
}

.footer-info h2,
.footer-links h3,
.footer-contact h3 {
    color: #fff;
    margin-bottom: 15px;
}

.footer-links ul {
    list-style: none;
    padding: 0;
}

.footer-links ul li {
    margin-bottom: 10px;
}

.footer-links ul li a {
    color: #fff;
    text-decoration: none;
}

.footer-links ul li a:hover {
    text-decoration: underline;
}

.footer-contact p {
    margin-right: 20px;
}

.footer-social {
    text-align: center;
}

.social-icons {
    margin-top: 20px;
}

.social-icon {
    display: inline-block;
    margin: 0 10px;
}

.social-icon img {
    width: 30px;
    height: 30px;
}

.footer-bottom {
    text-align: center;
    margin-top: 20px;
}

.footer-bottom p {
    font-size: 14px;
}
</style>
