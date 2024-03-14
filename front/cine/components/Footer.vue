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
                        <NuxtLink to="/">Inicio</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/peliculas">Peliculas</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/sesiones">Sesiones</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/novedades">Novedades</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/trailers">Trailers</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/contactanos">Contáctanos</NuxtLink>
                    </li>

                </ul>
            </div>
            <div class="footer-contact">
                <h3>Contacto</h3>
                <p>Dirección: Carrer de Jaume I, 28, 08830 Sant Boi de Llobregat, Barcelona</p>
                <br> <!-- Agregando un salto de línea para separar -->
                <p>Teléfono: 936 61 61 12</p>
                <br> <!-- Agregando un salto de línea para separar -->
                <p>Email: info@cancasteller.com</p>
            </div>
        </div>
        <div class="footer-social">
            <h3>Síguenos</h3>
            <div class="social-icons">
                <a href="#" class="social-icon"><img src="../public/facebook.png"></a>
                <a href="#" class="social-icon"><img src="../public/instagram.png"></a>
                <a href="#" class="social-icon"><img src="../public/twitter.png"></a>
                <a href="#" class="social-icon"><img src="../public/youtube.png"></a>
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
    flex: 1;
    margin-bottom: 20px;
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

.footer-contact p {
    margin-bottom: 20px; /* Ajuste para agregar más espacio entre los elementos */
}

.footer-social {
    text-align: center;
}

.social-icons {
    margin-top: 20px;
}

.social-icon {
    display: inline-block;
    color: #fff;
    font-size: 24px;
    margin: 0 10px;
}

.footer-bottom {
    text-align: center;
    margin-top: 20px;
}

.footer-bottom p {
    font-size: 14px;
}
</style>
