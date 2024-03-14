<template>
    <div>
        <header>
            <img src="../public/logo.jpg" alt="El Rincón del hombre mosca logo" class="header-img">
            <p class="paragraph-header">El cine que todo el mundo quiere estar, está aquí</p>
        </header>
        <nav class="nav">
            <ul>
                <li id="home">
                    <nuxt-link to="/"><img src="../public/casa.png" alt="Home"></nuxt-link>
                </li>
                <li>
                    <nuxt-link to="/peliculas">Peliculas</nuxt-link>
                </li>
                <li>
                    <nuxt-link to="/sesiones">Sesiones</nuxt-link>
                </li>
                <li>
                    <nuxt-link to="/novedades">Novedades</nuxt-link>
                </li>
                <li>
                    <nuxt-link to="/trailers">Trailers</nuxt-link>
                </li>
                <li>
                    <nuxt-link to="/contactanos">Contactanos</nuxt-link>
                </li>
                <li style="float:right">
                    <nuxt-link to="/login">Login</nuxt-link>
                </li>
            </ul>
        </nav>
    </div>
</template>

<style scoped>
header {
    text-align: center;
    background-color: black;
    padding: 10px;
    margin: 0;
}

.header-img {
    height: 30vh; /* Cambia la altura de la imagen del encabezado según sea necesario */
}

.paragraph-header {
    padding-bottom: 1em;
    color: white;
}

.nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: black;
}

.nav li {
    float: left;
}

.nav li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

.nav li a:hover {
    background-color: red;
}

.nav li:first-child {
    border-right: 1px solid #bbb;
}

.nav li a img {
    width: 20px;
    height: auto;
}
</style>
