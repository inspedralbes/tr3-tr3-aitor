<template>
    <header class="header">
        <div class="container">
            <div class="top">
                <div class="logo">
                    <NuxtLink to="/">
                        <img src="../public/hola.jpg" alt="Logo" class="logo-img">
                    </NuxtLink>
                </div>
                <div class="search">
                    <input type="text" placeholder="Buscar...">
                    <button>Buscar</button>
                </div>
            </div>
            <nav class="navbar">
                <ul>
                    <li>
                        <NuxtLink to="/" class="nav-link">
                            <img src="../public/casa.png" alt="Home" class="navbar-img">
                        </NuxtLink>
                    </li>

                    <li>
                        <NuxtLink to="/peliculas" class="nav-link">Peliculas</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/sesiones" class="nav-link">Sesiones</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/novedades" class="nav-link">Novedades</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/trailers" class="nav-link">Trailers</NuxtLink>
                    </li>
                    <li class="login">
                        <NuxtLink to="/login" class="login-link">Login</NuxtLink>
                    </li>
                </ul>
            </nav>
        </div>
    </header>
</template>

<style scoped>
.header {
    background-color: black;
    color: #fff;
    padding: 10px 0;
}

.container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.top {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.logo img.logo-img {
    width: 80px;
    /* Cambia el tamaño de la imagen del logo a 80px */
    height: auto;
}

.navbar-img {
  width: 50px; /* Cambia el tamaño de la imagen del navbar a 50px */
  height: auto;
}

.search {
    display: flex;
    align-items: center;
}

.search input {
    padding: 5px;
    margin-right: 10px;
}

.search button {
    padding: 5px 10px;
    background-color: red; /* Cambia el color de fondo a rojo */
    color: #fff;
    border: none;
    cursor: pointer;
}

.navbar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.navbar ul li {
    display: inline;
    margin-left: 20px;
}

.navbar ul li:last-child {
    margin-left: auto; /* Alinea el último elemento a la derecha */
}

.navbar ul li a {
    color: #fff;
    text-decoration: none;
}

.navbar ul li a:hover {
    text-decoration: underline;
}

.login {
    margin-left: auto;
}

/* Estilo para el hover del enlace de navegación */
.nav-link:hover {
    color: red;
}

/* Estilo para el hover del enlace de inicio de sesión */
.login-link:hover {
    color: red;
}
</style>
