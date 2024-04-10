<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pelicula;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class PeliculaController extends Controller
{
    public function crearPelicula (Request $request)
    {
        // Validar los datos recibidos del formulario
        $validator = Validator::make($request->all(), [
            'titulo' => 'required|string|max:255',
            'duracion' => 'required|integer',
            'genero' => 'required|string|max:255',
            'sinopsis' => 'required|string',
            'cartel' => 'required|string|max:255',
            'trailer' => 'required|string|max:255',
            'id_youtube' => 'required|string|max:255', 
            'fechaEstreno' => 'required|date_format:Y-m-d',
            'sesion_id' => 'nullable|exists:sesions,id',
        ]);

        // Si la validación falla, devolver una respuesta con los errores de validación
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        // Crear una nueva instancia del modelo Pelicula con los datos recibidos
        $pelicula = new Pelicula();
        $pelicula->titulo = $request->titulo;
        $pelicula->duracion = $request->duracion;
        $pelicula->genero = $request->genero;
        $pelicula->sinopsis = $request->sinopsis;
        $pelicula->cartel = $request->cartel;
        $pelicula->trailer = $request->trailer;
        $pelicula->id_youtube = $request->id_youtube;
        $pelicula->fechaEstreno = $request->fechaEstreno;
        $pelicula->sesion_id = $request->sesion_id;

        // Guardar la película en la base de datos
        $pelicula->save();

        // Devolver una respuesta de éxito
        return response()->json([
            'message' => 'Pelicula creada con éxito',
            'data' => $pelicula
        ], 201);
    }
    public function listarPeliculas()
    {
        // Obtener todas las películas de la base de datos
        $peliculas = Pelicula::all();

        // Devolver una respuesta con todas las películas
        return response()->json([
            'data' => $peliculas
        ]);
    }
    public function modificarPelicula(Request $request, $id)
    {
        // Validar los datos recibidos del formulario
        $validator = Validator::make($request->all(), [
            'titulo' => 'sometimes|string|max:255',
            'duracion' => 'sometimes|integer',
            'genero' => 'sometimes|string|max:255',
            'sinopsis' => 'sometimes|string',
            'cartel' => 'sometimes|string|max:255',
            'trailer' => 'sometimes|string|max:255',
            'fechaEstreno' => 'sometimes|date_format:Y-m-d',
            'sesion_id' => 'nullable|exists:sesions,id',
        ]);        

        // Si la validación falla, devolver una respuesta con los errores de validación
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        // Buscar la película en la base de datos
        $pelicula = Pelicula::find($id);

        // Si la película no existe, devolver una respuesta de error
        if (!$pelicula) {
            return response()->json([
                'message' => 'Pelicula no encontrada'
            ], 404);
        }
        
        // Actualizar la película con los datos recibidos
        if ($request->has('titulo')) {
            $pelicula->titulo = $request->titulo;
        }
        if ($request->has('duracion')) {
            $pelicula->duracion = $request->duracion;
        }
        if ($request->has('genero')) {
            $pelicula->genero = $request->genero;
        }
        if ($request->has('sinopsis')) {
            $pelicula->sinopsis = $request->sinopsis;
        }
        if ($request->has('trailer')) {
            $pelicula->trailer = $request->trailer;
        }
        if ($request->has('fechaEstreno')) {
            $pelicula->fechaEstreno = $request->fechaEstreno;
        }
        if ($request->has('sesion_id')) {
            $pelicula->sesion_id = $request->sesion_id;
        }
        
        // Guardar la película en la base de datos
        $pelicula->save();
        
        // Devolver una respuesta de éxito
        return response()->json([
            'message' => 'Pelicula modificada con éxito',
            'data' => $pelicula
        ]);
    }
    public function eliminarPelicula(Request $request, $id){
        // Buscar la película en la base de datos
        $pelicula = Pelicula::find($id);

        // Si la película no existe, devolver una respuesta de error
        if (!$pelicula) {
            return response()->json([
                'message' => 'Pelicula no encontrada'
            ], 404);
        }

        // Eliminar la película de la base de datos
        $pelicula->delete();

        // Devolver una respuesta de éxito
        return response()->json([
            'message' => 'Pelicula eliminada con éxito'
        ]);
    }
}
