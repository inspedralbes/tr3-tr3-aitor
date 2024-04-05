<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PeliculaController;
use App\Http\Controllers\EntradaController;
use App\Http\Controllers\SesionController;
use App\Http\Controllers\Auth\UserController;
use App\Http\Controllers\NovedadesControlador;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


Route::post('/crearPelicula', [PeliculaController::class, 'crearPelicula']);
Route::get('/listarPeliculas', [PeliculaController::class, 'listarPeliculas']);
Route::put('/modificarPelicula/{id}', [PeliculaController::class, 'modificarPelicula']);
Route::delete('/eliminarPelicula/{id}', [PeliculaController::class, 'eliminarPelicula']);
Route::post('/crearEntrada', [EntradaController::class, 'crearEntrada']);
Route::get('/listarEntradas', [EntradaController::class, 'listarEntradas']);
Route::put('/modificarEntrada/{id}', [EntradaController::class, 'modificarEntrada']);
Route::delete('/eliminarEntrada/{id}', [EntradaController::class, 'eliminarEntrada']);
Route::get('/listarEntradasPorSesion/{idSesion}', [EntradaController::class, 'listarEntradasPorSesion']);
Route::get('/listarEntradasPorUsuario/{idUsuario}', [EntradaController::class, 'listarEntradasPorUsuario']);
Route::post('/crearSesion', [SesionController::class, 'crearSesion']);
Route::get('/listarSesiones', [SesionController::class, 'listarSesiones']);
Route::get('/obtenerSesion/{id}', [SesionController::class, 'obtenerSesion']);
Route::put('/modificarSesion/{id}', [SesionController::class, 'modificarSesion']);
Route::delete('/eliminarSesion/{id}', [SesionController::class, 'eliminarSesion']);
Route::post('/crearNovedades', [NovedadesControlador::class, 'crearNovedades']);
Route::get('/listarNovedades', [NovedadesControlador::class, 'listarNovedades']);
Route::put('/modificarNovedades/{id}', [NovedadesControlador::class, 'modificarNovedades']);
Route::delete('/eliminarNovedades/{id}', [NovedadesControlador::class, 'eliminarNovedades']);


Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);
Route::post('/logout', [UserController::class, 'logout']);
Route::get('/user', [UserController::class, 'user']);
Route::get('/usuari/{id}', [UserController::class, 'mostrarUsuario']);
Route::put('/modificarUsuario/{id}', [UserController::class, 'modificarUsuario']);