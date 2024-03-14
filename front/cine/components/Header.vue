<template>
    <header class="container-header">
        <div class="logo-container">
            <img src="../public/hola.jpg" alt="El Rincón del hombre mosca logo" class="logo">
            <p class="slogan">Cine, música y algo de arte. La cabeza del hombre mosca</p>
        </div>
        <nav class="nav">
            <ul>
                <li><a href="#">Home</a></li>
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
                <li style="float:right"><a href="#about">Login</a></li>
            </ul>
        </nav>
    </header>
</template>

<script>
export default {
    // Opciones del componente, si es necesario
}
</script>

<style scoped>
body {
    background-image: url("http://3.bp.blogspot.com/-LuEXvYzBnqU/VTKVi3K7FxI/AAAAAAAAAD4/ks4SrvUR_5Y/s0/fondo.jpg");
    color: white;
    font-family: "Courier New", "Courier", monospace;
}

.container-header {
    text-align: center;
    background-color: #222;
    padding: 20px 0;
}

.logo-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}

.logo {
    max-width: 150px;
    margin-right: 20px;
}

.slogan {
    font-size: 18px;
}

.nav {
    background-color: #333;
    display: flex;
    justify-content: center;
}

.nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    display: flex;
}

.nav li {
    border-right: 1px solid #555;
}

.nav li:last-child {
    border-right: none;
}

.nav li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 20px;
    text-decoration: none;
}

.nav li a:hover {
    background-color: #555;
}
</style>