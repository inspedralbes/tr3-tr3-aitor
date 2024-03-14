<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PeliculaController;
use App\Http\Controllers\EntradaController;

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
