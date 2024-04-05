<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Novedades;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class NovedadesControlador extends Controller
{
    public function crearNovedades(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'genero' => 'required|string', 
            'sinopsis' => 'required|string',
            'estreno' => 'required|date_format:Y-m-d',
            'poster' => 'required|string|max:255',
            'trailer' => 'required|string|max:255',
            'id_youtube' => 'required|string|max:255',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }
        $novedades = new Novedades();
        $novedades->title = $request->title;
        $novedades->genero = $request->genero;
        $novedades->sinopsis = $request->sinopsis;
        $novedades->estreno = $request->estreno;
        $novedades->poster = $request->poster;
        $novedades->trailer = $request->trailer;
        $novedades->id_youtube = $request->id_youtube;
        $novedades->save();
        return response()->json([
            'message' => 'Novedades creada con éxito',
            'data' => $novedades
        ], 201);
    }
    public function listarNovedades()
    {
        $novedades = Novedades::all();
        return response()->json([
            'data' => $novedades
        ]);
    }
    public function modificarNovedades(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'sometimes|string|max:255',
            'genero' => 'sometimes|string',
            'sinopsis' => 'sometimes|string',
            'estreno' => 'sometimes|date_format:Y-m-d',
            'poster' => 'sometimes|string|max:255',
            'trailer' => 'sometimes|string|max:255',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }
        $novedades = Novedades::find($id);
        if (!$novedades) {
            return response()->json([
                'message' => 'Novedades no encontrada'
            ], 404);
        }
        if($request->has('title')) {
            $novedades->title = $request->title;
        }
        if($request->has('genero')) {
            $novedades->genero = $request->genero;
        }
        if($request->has('sinopsis')) {
            $novedades->sinopsis = $request->sinopsis;
        }
        if($request->has('estreno')) {
            $novedades->estreno = $request->estreno;
        }
        if($request->has('poster')) {
            $novedades->poster = $request->poster;
        }
        if($request->has('trailer')) {
            $novedades->trailer = $request->trailer;
        }
        $novedades->save();
        return response()->json([
            'message' => 'Novedades modificada con éxito',
            'data' => $novedades
        ]);

    }
    public function eliminarNovedades(Request $request, $id)
    {
        $novedades = Novedades::find($id);
        if (!$novedades) {
            return response()->json([
                'message' => 'Novedades no encontrada'
            ], 404);
        }
        $novedades->delete();
        return response()->json([
            'message' => 'Novedades eliminada con éxito'
        ]);
    }
}
