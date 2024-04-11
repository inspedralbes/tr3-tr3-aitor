-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-04-2024 a las 10:11:46
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
-- Estructura de tabla para la tabla `entradas`
--

CREATE TABLE `entradas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sesion_id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `fila` int(11) NOT NULL,
  `columna` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`id`, `sesion_id`, `usuario_id`, `fila`, `columna`, `cantidad`) VALUES
(1, 1, 1, 1, 1, 1),
(3, 4, 1, 4, 6, 1),
(4, 4, 1, 4, 7, 1),
(5, 5, 1, 5, 8, 1),
(6, 5, 1, 3, 5, 1),
(32, 2, 1, 2, 2, 1),
(33, 8, 5, 6, 5, 1),
(34, 8, 5, 6, 5, 1),
(35, 8, 5, 6, 6, 1),
(36, 8, 5, 6, 6, 1),
(37, 13, 6, 5, 7, 1),
(38, 13, 6, 5, 8, 1),
(39, 1, 7, 5, 6, 1),
(40, 1, 7, 5, 7, 1),
(41, 4, 1, 2, 5, 1),
(42, 4, 1, 2, 5, 1),
(43, 6, 1, 4, 5, 1),
(44, 2, 9, 4, 5, 1),
(45, 2, 9, 4, 6, 1),
(46, 4, 10, 5, 6, 1),
(47, 5, 1, 5, 4, 1),
(48, 5, 1, 4, 6, 1),
(49, 5, 1, 4, 8, 1),
(50, 5, 1, 4, 7, 1),
(51, 5, 1, 3, 7, 1),
(52, 5, 1, 3, 8, 1),
(53, 5, 1, 3, 9, 1),
(54, 5, 1, 4, 9, 1),
(55, 5, 1, 5, 9, 1),
(56, 5, 1, 5, 7, 1),
(57, 5, 1, 5, 4, 1),
(58, 5, 1, 5, 4, 1),
(59, 5, 1, 4, 6, 1),
(60, 5, 1, 4, 6, 1),
(61, 5, 1, 4, 8, 1),
(62, 5, 1, 4, 8, 1),
(63, 5, 1, 4, 7, 1),
(64, 5, 1, 4, 7, 1),
(65, 5, 1, 3, 7, 1),
(66, 5, 1, 3, 7, 1),
(67, 5, 1, 3, 8, 1),
(68, 5, 1, 3, 8, 1),
(69, 5, 1, 3, 9, 1),
(70, 5, 1, 3, 9, 1),
(71, 5, 1, 4, 9, 1),
(72, 5, 1, 4, 9, 1),
(73, 5, 1, 5, 9, 1),
(74, 5, 1, 5, 9, 1),
(75, 5, 1, 5, 7, 1),
(76, 5, 1, 5, 7, 1),
(77, 14, 11, 5, 6, 1),
(78, 14, 11, 5, 6, 1),
(79, 6, 1, 5, 6, 1),
(80, 6, 1, 5, 7, 1),
(81, 6, 1, 5, 6, 1),
(82, 6, 1, 5, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_03_12_071445_sesions', 1),
(6, '2024_03_12_073928_entrada', 1),
(7, '2024_03_12_073933_peliculas', 1),
(8, '2024_03_15_150759_novedades', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `novedades`
--

CREATE TABLE `novedades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `genero` varchar(255) NOT NULL,
  `sinopsis` varchar(255) NOT NULL,
  `estreno` date NOT NULL,
  `poster` varchar(255) NOT NULL,
  `trailer` varchar(255) NOT NULL,
  `id_youtube` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `novedades`
--

INSERT INTO `novedades` (`id`, `title`, `genero`, `sinopsis`, `estreno`, `poster`, `trailer`, `id_youtube`) VALUES
(1, 'Teen Wolf La Pelicula', 'Accion/Thriller', 'Scott Howard juega al baloncesto. No es ni el mejor jugador ni el más alto, pero no por ello desiste de su sueño.', '2024-03-26', 'wolf.jpg', 'https://www.youtube.com/watch?v=e2z8zO7rLSg', 'e2z8zO7rLSg'),
(2, 'Sinister', 'Terror', 'Ellison, es un periodista especializado en escribir artículos y novelas sobre casos de crímenes célebres.', '2024-10-31', 'sinister.jpg', 'https://www.youtube.com/watch?v=_kbQAJR9YWQ', '_kbQAJR9YWQ'),
(3, 'The Flash', 'Accion/Fantasia', 'Los mundos chocan en \"Flash\" cuando Barry utiliza sus superpoderes para viajar en el tiempo y cambiar los acontecimientos del pasado.', '2024-06-16', 'flash.jpg', 'https://www.youtube.com/watch?v=hebWYacbdvc', 'hebWYacbdvc'),
(4, 'Indiginous', 'Terror', 'Cinco amigos se encuentran en Panamá para una vacaciones. En una fiesta escuchan las historias acerca de una bonita cascada.', '2024-04-20', 'indiginous.jpg', 'https://www.youtube.com/watch?v=vDm-hItTkIE', 'vDm-hItTkIE'),
(5, 'Inazuma Eleven La Pelicula', 'Deporte/Animacion', 'El colegio Raimon ha llegado a las semifinales de Fútbol Frontier y deben enfrentarse al Equipo Ogro del colegio Rey Colmillo.', '2024-12-23', 'inazuma.jpg', 'https://www.youtube.com/watch?v=XpqXe3GAjrQ', 'XpqXe3GAjrQ'),
(6, 'Five Nights at Freddy s', 'Terror/Misterio', 'Un hombre comienza un trabajo como guardia de seguridad nocturno en el restaurante Freddy Fazbear s Pizza. ', '2024-10-27', 'five.jpg', 'https://www.youtube.com/watch?v=0VH9WCFV6XQ', '0VH9WCFV6XQ'),
(7, 'Capitan America Civil War', 'Accion/Aventuras', 'Después de que otro incidente internacional involucre a Los Vengadores, causando varios daños colaterales.', '2024-04-29', 'capi.jpg', 'https://www.youtube.com/watch?v=dKrVegVI0Us', 'dKrVegVI0Us'),
(8, 'Imaginary', 'Terror/Misterio', 'Cuando Jessica vuelve con su familia a la casa de su infancia, Alice, su hijastra más pequeña, comienza a desarrollar un extraño apego hacia Chauncey.', '2024-03-15', 'imaginary.jpg', 'https://www.youtube.com/watch?v=8XoNfrgrAGM', '8XoNfrgrAGM'),
(9, 'Escape Room', 'Terror/Thriller', 'Seis personas quedan atrapadas en un escape room cuyo creador ha diseñado una trampa mortal en cada habitación.', '2024-04-04', 'escape.jpg', 'https://www.youtube.com/watch?v=T5z2EwJTr9I', 'T5z2EwJTr9I'),
(10, 'Horror Park', 'Terror', 'La encargada de un parque de atracciones, Fiona (Wilma Lidén), debe cuidar de una pareja de antiguos amigos que han ganado un concurso de Halloween', '2024-05-23', 'horror.jpg', 'https://www.youtube.com/watch?v=dqxSrZDTDgo', 'dqxSrZDTDgo'),
(11, 'Insidious', 'Terror/Misterio', 'Josh , su esposa Renai y sus tres hijos acaban de mudarse a una vieja casa. Pero, tras un desgraciado accidente, uno de los niños entra en coma.', '2024-06-10', 'insidious.jpg', 'https://www.youtube.com/watch?v=FRW3K0LlsD0', 'FRW3K0LlsD0'),
(12, 'Verdad o Reto', 'Terror/Policiaco', 'Una inofensiva partida de Verdad o reto entre un grupo de amigos acaba convirtiéndose en un juego letal cuando alguien empieza a castigar a los que mienten o no aceptan el reto.', '2024-04-13', 'reto.jpg', 'https://www.youtube.com/watch?v=YhSPDqqgO3Y', 'YhSPDqqgO3Y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id_youtube` varchar(255) NOT NULL,
  `fechaEstreno` datetime NOT NULL,
  `sesion_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `peliculas`
--

INSERT INTO `peliculas` (`id`, `titulo`, `duracion`, `genero`, `sinopsis`, `cartel`, `trailer`, `id_youtube`, `fechaEstreno`, `sesion_id`) VALUES
(1, 'La monja', 96, 'Terror/Misterio', 'Cuando una joven monja se quita la vida en un aislado monasterio de clausura en Rumanía.', './monja.jpg', 'https://www.youtube.com/watch?v=eqVjGwYFVqQ', 'eqVjGwYFVqQ', '2024-09-07 00:00:00', 2),
(2, 'Ant-Man i la Avispa: Quantumania', 125, 'Acción/Aventura', 'Scott Lang (Paul Rudd) está disfrutando de su vida como Vengador y de la fama que ha ganado por ayudar a salvar a la humanidad en Vengadores: Endgame. ', './ant.jpg', 'https://www.youtube.com/watch?v=ZlNFpri-Y40', 'ZlNFpri-Y40', '2024-04-17 00:00:00', 3),
(3, 'Night Swim', 98, 'Terror/Misterio', 'Es historia de Ray Waller , una estrella del béisbol obligada a retirarse antes de tiempo debido a una enfermedad que le impide jugar.', './swim.jpg', 'https://www.youtube.com/watch?v=pcSNqteCEtE', 'pcSNqteCEtE', '2024-03-09 00:00:00', 6),
(4, 'Annabelle', 99, 'Terror/Misterio', 'Una pareja comienza a sufrir experiencias terroríficamente supernaturales en su hogar debido a una muñeca vintage.', './anna.jpg', 'https://www.youtube.com/watch?v=8kmLHwKH31M', '8kmLHwKH31M', '2024-10-08 00:00:00', 7),
(5, 'Guardianes de la Galaxia vol. 3', 149, 'Acción/Aventura', 'Puede que Thanos , así como el padre de Peter Quill , Ego, sean ya historia, pero la horrible huella que han dejado tras de sí aún se palpa en el seno de los Guardianes de la Galaxia. ', './guardianes.jpg', 'https://www.youtube.com/watch?v=F60FZKt_36s', 'F60FZKt_36s', '2024-05-05 00:00:00', 9),
(6, 'Torrente, el brazo tonto de la ley', 97, 'Comedia/Acción', 'José Luis Torrente es un incompetente policía madrileño al que el destino va a dar la oportunidad de redimirse.', './torrente.jpg', 'https://www.youtube.com/watch?v=ulJSg4GYbBE', 'ulJSg4GYbBE', '2024-04-13 00:00:00', 10),
(7, 'Resacon en las Vegas', 100, 'Comedia/Misterio', 'Después de una noche de excesos, los chicos comienzan el día sin recordar nada de lo que hicieron la noche anterior', './resaca.jpg', 'https://www.youtube.com/watch?v=MckEHmSMg-0', 'MckEHmSMg-0', '2024-08-14 00:00:00', 12),
(8, 'Avengers: Infinity War', 149, 'Acción/Ciencia ficción', 'Un nuevo peligro acecha procedente de las sombras del cosmos. Thanos, el infame tirano intergaláctico, tiene como objetivo reunir las seis Gemas del Infinito.', './infinty.jpg', 'https://www.youtube.com/watch?v=6ZfuNTqbHE8', '6ZfuNTqbHE8', '2024-04-27 00:00:00', 13),
(9, 'Jurassic World', 124, 'Acción/Ciencia ficción', ' Isla Nubla tiene ahora un parque temático de dinosaurios en pleno funcionamiento llamado Jurassic World, como lo había previsto John Hammond.', './jurasic.jpg', 'https://www.youtube.com/watch?v=hv9eSCijf6E', 'hv9eSCijf6E', '2024-06-10 00:00:00', 16),
(10, 'Dune', 155, 'Ciencia ficción/Aventura', 'Dune sigue la historia de Paul Atreides, un joven brillante y talentoso nacido en un futuro lejano en el planeta Arrakis, que es conocido como Dune.', './dune.jpg', 'https://www.youtube.com/watch?v=TTgk_iT8Uts', 'TTgk_iT8Uts', '2024-10-22 00:00:00', 15),
(11, 'Spider-Man: No Way Home', 148, 'Acción/Aventura', 'Spider-Man: No Way Home sigue la historia de Peter Parker, quien busca la ayuda del Doctor Strange para alterar la realidad después de que su identidad como Spider-Man es revelada.', './spiderman.jpg', 'https://www.youtube.com/watch?v=SkmRT3M4Vx4', 'SkmRT3M4Vx4', '2024-12-17 00:00:00', 14),
(12, 'Shang-Chi y la leyenda de los Diez Anillos', 132, 'Acción/Aventura', 'Shang-Chi y la leyenda de los Diez Anillos sigue la historia de Shang-Chi, quien debe enfrentarse a su pasado cuando es atraído por la organización terrorista de su padre, los Diez Anillos.', './shangchi.jpg', 'https://www.youtube.com/watch?v=MQRF_YezCgA', 'MQRF_YezCgA', '2024-09-03 00:00:00', 11),
(13, 'Shin-chan: Aventuras en Henderland', 97, 'Infantil/Aventures', 'Henderland es el parque de atracciones más popular de Kasukabe, y Shin-chan consigue asistir como invitado.', './shin.jpg', 'https://www.youtube.com/watch?v=7E2tfw4j6q4', '7E2tfw4j6q4', '2024-04-01 00:00:00', 8),
(14, 'Wall-e', 98, 'Infantil/CF', '700 años atrás, el planeta Tierra tuvo que ser evacuado debido a una enorme acumulación de basura, encomendando a una serie de robots la misión de limpiarla.', './wall.jpg', 'https://www.youtube.com/watch?v=qF7p4lZ00RA', 'qF7p4lZ00RA', '2024-04-17 00:00:00', 5),
(15, 'Doraemon, El Gladiador', 81, 'Infantil/Aventures', 'En esta nueva aventura de Doraemon y Nobita conoceremos a Poko, un niño robot que llega desde el futuro con una de las máquinas del tiempo del gato cósmico.', './doraemon.jpg', 'https://www.youtube.com/watch?v=MwA6yK-gjSU', 'MwA6yK-gjSU', '2024-03-31 00:00:00', 4),
(16, 'Cars', 117, 'Infantil/Comèdia', 'Un pequeño y nuevo coche de carreras, llamado Rayo McQueen, se está preparando para ser un experto corredor y convertirse en uno de los automóviles más respetados en el panorama internacional.', './cars.jpg', 'https://www.youtube.com/watch?v=8ZMklX5BzTo', '8ZMklX5BzTo', '2024-04-22 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '3764485d09dca6fdb8558dc2ee1e565c0000bf3d5546e7382b9fbf5703e3f8c8', '[\"*\"]', NULL, NULL, '2024-04-05 08:27:59', '2024-04-05 08:27:59'),
(2, 'App\\Models\\User', 2, 'auth_token', '263a91744982ee7e349d905454f554741e00306ff8eceaa6c7a6c9718b9a8f28', '[\"*\"]', NULL, NULL, '2024-04-08 10:19:05', '2024-04-08 10:19:05'),
(3, 'App\\Models\\User', 1, 'auth_token', '12495885337be91271b35c5b8e2e24c632e96e8f1087132487762ccdc3967408', '[\"*\"]', NULL, NULL, '2024-04-08 10:36:29', '2024-04-08 10:36:29'),
(4, 'App\\Models\\User', 1, 'auth_token', 'eb83774cac51975c9d199fdccd5c4bb1273dd515397e2583dbc096c5a90dcef4', '[\"*\"]', NULL, NULL, '2024-04-08 10:36:30', '2024-04-08 10:36:30'),
(5, 'App\\Models\\User', 1, 'auth_token', 'b69eedc8b68f998336e399317e84ed79530b08f2172d509492e0ce826d73cd3b', '[\"*\"]', NULL, NULL, '2024-04-08 14:11:44', '2024-04-08 14:11:44'),
(6, 'App\\Models\\User', 10, 'auth_token', 'a1d8d5afb0c9df5b4f42413491fb65d0a52138e9f0437aba4d136a73ac63dce2', '[\"*\"]', NULL, NULL, '2024-04-08 17:05:22', '2024-04-08 17:05:22'),
(7, 'App\\Models\\User', 1, 'auth_token', 'bfeecb7816bcffd59148581c83f7df0844810d84a28f72a26c1a64faac9a83c6', '[\"*\"]', NULL, NULL, '2024-04-09 04:19:37', '2024-04-09 04:19:37'),
(8, 'App\\Models\\User', 1, 'auth_token', '343acba149cffc2cc63ab83e0b6eb58e0399636c7c21309fd7cd4e5b7003625e', '[\"*\"]', NULL, NULL, '2024-04-09 04:50:16', '2024-04-09 04:50:16'),
(9, 'App\\Models\\User', 1, 'auth_token', '60dbd7c114dac9431e362b520e6ba7e4492ad8c389f993d9bd959036b9886e9b', '[\"*\"]', NULL, NULL, '2024-04-09 04:52:45', '2024-04-09 04:52:45'),
(10, 'App\\Models\\User', 1, 'auth_token', '840927bea04ec4dcd4ef9e9f8b7a7281a8865646a005cff4ca68691cdd8024cf', '[\"*\"]', NULL, NULL, '2024-04-09 04:59:52', '2024-04-09 04:59:52'),
(11, 'App\\Models\\User', 8, 'auth_token', 'acfca89bc1bbfc2069cd4f269039dccaaa1ab988bc0d4ea0caccf394374d310c', '[\"*\"]', NULL, NULL, '2024-04-09 05:01:45', '2024-04-09 05:01:45'),
(12, 'App\\Models\\User', 1, 'auth_token', '5704e2d6f2d0675aba71cc7db8d79f405d0a7663e408ce43e0ee637d7701f9c3', '[\"*\"]', NULL, NULL, '2024-04-09 05:01:59', '2024-04-09 05:01:59'),
(13, 'App\\Models\\User', 1, 'auth_token', '6ae6b8fef7941b3461cf3198daabec042965ed10d441e17184ef039e80cfc352', '[\"*\"]', NULL, NULL, '2024-04-10 06:47:39', '2024-04-10 06:47:39'),
(14, 'App\\Models\\User', 1, 'auth_token', '59f3e135558d165ba4262a0119868c0c3f10431bd8511698e13fe6dfbd44b7eb', '[\"*\"]', NULL, NULL, '2024-04-11 06:10:46', '2024-04-11 06:10:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesions`
--

CREATE TABLE `sesions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `diaEspectador` tinyint(1) NOT NULL,
  `precio` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sesions`
--

INSERT INTO `sesions` (`id`, `fecha`, `diaEspectador`, `precio`) VALUES
(1, '2024-03-21 12:47:57', 0, 5.50),
(2, '2024-03-22 17:40:00', 0, 4.50),
(3, '2024-03-24 16:00:00', 0, 4.50),
(4, '2024-03-20 17:00:00', 0, 5.50),
(5, '2024-03-20 09:50:57', 0, 5.50),
(6, '2024-03-20 18:30:00', 0, 5.50),
(7, '2024-03-20 12:00:00', 0, 4.50),
(8, '2024-03-21 14:55:20', 0, 5.50),
(9, '2024-03-21 15:00:56', 0, 5.50),
(10, '2024-03-21 10:56:49', 0, 5.50),
(11, '2024-03-22 12:55:49', 0, 4.50),
(12, '2024-03-22 11:39:01', 0, 5.50),
(13, '2024-03-22 11:39:01', 0, 4.50),
(14, '2024-03-24 15:40:19', 0, 5.50),
(15, '2024-03-24 20:41:19', 0, 4.50),
(16, '2024-03-24 12:42:16', 0, 4.50),
(20, '2004-02-23 00:00:00', 0, 5.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuaris`
--

CREATE TABLE `usuaris` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nom` varchar(255) NOT NULL,
  `cognoms` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `foto_perfil` enum('1','2','3','4','5','6','7','8','9') NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuaris`
--

INSERT INTO `usuaris` (`id`, `nom`, `cognoms`, `email`, `password`, `foto_perfil`, `remember_token`) VALUES
(1, 'Aitor', 'Barreiro Escobar', 'a20aitbaresc@inspedralbes.cat', '$2y$12$1AuaxXyFy3hThpjdEfr.3upWtrGKs9zT06Bx8x1JeoKJWjKP/qc9a', '6', NULL),
(5, 'Laia', 'Polo', 'ilec.laiapolo@gmail.com', '$2y$12$6hrhU8GB1hdoKuWmp/dn9OWrJCiM9FlrUeD4g1USRx6kYgQmPf0pO', '1', NULL),
(6, 'Maria', 'Martinez', 'Mariamartinrodrigo83@gmail.com', '$2y$12$YRoODNJotkUFttEi0Ak05uCzVYxhdPrcIPF6FMOL5AAyIQtG3rGAG', '9', NULL),
(7, 'Alex', 'Delgado', 'a21aledelfel@inspedralbes.cat', '$2y$12$SZH3XJ.VVwz0bogiY6KriO27q9OjLsO/M7AcYzMnSSqnIpNw36O7O', '8', NULL),
(8, 'Aitor', 'Barreiro Escobar', 'aitorbares018@gmail.com', '$2y$12$Pci1g.PVy9mTIc30vw.DOuJzrSgRmOr1SG922dcdmDQxPo97bG4KK', '1', NULL),
(9, 'Espe', 'Ruiz Clavijo', 'meruizclavijoc@gmail.com', '$2y$12$RGAzHNfud.vRfjfdCCCipunubCeOAJEn3t8Nobkuv7x1hcPnXNqVe', '9', NULL),
(10, 'Carlos', 'Barreiro Nuñez', 'carlosbanu@gmail.com', '$2y$12$1ihej8sJzcJrn3/iOPasIu2D/EcIyCOy91AUA/CqJ2ZlfuKZaGF0y', '2', NULL),
(11, 'Eric', 'Rodriguez Nos', 'a22erirodnos@inspedralbes.cat', '$2y$12$cu41AHGEK9T4tkuy6IWEjOatsBWF9RHys/b7y7b267NXBEcyAKYdO', '4', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entradas_sesion_id_foreign` (`sesion_id`),
  ADD KEY `entradas_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `novedades`
--
ALTER TABLE `novedades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `peliculas_sesion_id_foreign` (`sesion_id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `sesions`
--
ALTER TABLE `sesions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuaris`
--
ALTER TABLE `usuaris`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuaris_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `novedades`
--
ALTER TABLE `novedades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `peliculas`
--
ALTER TABLE `peliculas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `sesions`
--
ALTER TABLE `sesions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `usuaris`
--
ALTER TABLE `usuaris`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `entradas_sesion_id_foreign` FOREIGN KEY (`sesion_id`) REFERENCES `sesions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `entradas_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuaris` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `peliculas`
--
ALTER TABLE `peliculas`
  ADD CONSTRAINT `peliculas_sesion_id_foreign` FOREIGN KEY (`sesion_id`) REFERENCES `sesions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
