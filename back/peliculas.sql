-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-03-2024 a las 10:40:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cine`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `peliculas`
--

CREATE TABLE `peliculas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `duracion` int(11) NOT NULL,
  `genero` varchar(255) NOT NULL,
  `sinopsis` varchar(255) NOT NULL,
  `cartel` varchar(255) NOT NULL,
  `trailer` varchar(255) NOT NULL,
  `fechaEstreno` datetime NOT NULL,
  `sesion_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `peliculas`
--

INSERT INTO `peliculas` (`id`, `titulo`, `duracion`, `genero`, `sinopsis`, `cartel`, `trailer`, `fechaEstreno`, `sesion_id`) VALUES
(1, 'La monja', 96, 'Terror/Misterio', 'Cuando una joven monja se quita la vida en un aislado monasterio de clausura en Rumanía, el Padre Burke (Demián Bichir).', './monja.jpg', 'https://www.youtube.com/watch?v=eqVjGwYFVqQ', '2024-09-07 00:00:00', NULL),
(2, 'Ant-Man i la Avispa: Quantumania', 125, 'Acción/Aventura', 'Scott Lang (Paul Rudd) está disfrutando de su vida como Vengador y de la fama que ha ganado por ayudar a salvar a la humanidad en Vengadores: Endgame. ', './ant.jpg', 'https://www.youtube.com/watch?v=ZlNFpri-Y40', '2024-04-17 00:00:00', NULL),
(3, 'Night Swim', 98, 'Terror/Misterio', 'Es historia de Ray Waller , una estrella del béisbol obligada a retirarse antes de tiempo debido a una enfermedad que le impide jugar.', './swim.jpg', 'https://www.youtube.com/watch?v=pcSNqteCEtE', '2024-03-09 00:00:00', NULL),
(4, 'Annabelle', 99, 'Terror/Misterio', 'Una pareja comienza a sufrir experiencias terroríficamente supernaturales en su hogar debido a una muñeca vintage.', './anna.jpg', 'https://www.youtube.com/watch?v=8kmLHwKH31M', '2024-10-08 00:00:00', NULL),
(5, 'Guardianes de la Galaxia vol. 3', 149, 'Acción/Aventura', 'Puede que Thanos , así como el padre de Peter Quill , Ego, sean ya historia, pero la horrible huella que han dejado tras de sí aún se palpa en el seno de los Guardianes de la Galaxia. ', '.guardianes.jpg', 'https://www.youtube.com/watch?v=F60FZKt_36s', '2024-05-05 00:00:00', NULL),
(6, 'Torrente, el brazo tonto de la ley', 97, 'Comedia/Acción', 'José Luis Torrente es un incompetente policía madrileño al que el destino va a dar la oportunidad de redimirse.', './torrente.jpg', 'https://www.youtube.com/watch?v=ulJSg4GYbBE', '2024-04-13 00:00:00', NULL),
(7, 'Resacon en las Vegas', 100, 'Comedia/Misterio', 'Después de una noche de excesos, los chicos comienzan el día sin recordar nada de lo que hicieron la noche anterior', './resaca.jpg', 'https://www.youtube.com/watch?v=MckEHmSMg-0', '2024-08-14 00:00:00', NULL),
(8, 'Avengers: Infinity War', 149, 'Acción/Ciencia ficción', 'Un nuevo peligro acecha procedente de las sombras del cosmos. Thanos, el infame tirano intergaláctico, tiene como objetivo reunir las seis Gemas del Infinito.', './infinty.jpg', 'https://www.youtube.com/watch?v=6ZfuNTqbHE8', '2024-04-27 00:00:00', NULL),
(9, 'Jurassic World', 124, 'Acción/Ciencia ficción', ' Isla Nubla tiene ahora un parque temático de dinosaurios en pleno funcionamiento llamado Jurassic World, como lo había previsto John Hammond.', './jurasic.jpg', 'https://www.youtube.com/watch?v=hv9eSCijf6E', '2024-06-10 00:00:00', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `peliculas_sesion_id_foreign` (`sesion_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD CONSTRAINT `peliculas_sesion_id_foreign` FOREIGN KEY (`sesion_id`) REFERENCES `sesions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
