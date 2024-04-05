<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\Entrada;
use App\Models\Sesion; 
use App\Models\Usuer;

use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class EntradaController extends Controller
{
    public function crearEntrada(Request $request)
{
    try {
        $validator = Validator::make($request->all(), [
            'cantidad' => 'required|integer',
            'fila' => 'required|integer',
            'columna' => 'required|integer',
            'sesion_id' => 'required|exists:sesions,id',
            'usuario_id' => 'required|exists:usuarios,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        $entrada = new Entrada();
        $entrada->cantidad = $request->cantidad;
        $entrada->fila = $request->fila;
        $entrada->columna = $request->columna;
        $entrada->sesion_id = $request->sesion_id;
        $entrada->usuario_id = $request->usuario_id;
        $entrada->save();

        return response()->json([
            'message' => 'Entrada creada con éxito',
            'data' => $entrada
        ], 201);
    } catch (\Exception $e) {
        \Log::error('Error al comprar entrada: ' . $e->getMessage());
        return response()->json([
            'error' => 'Error al comprar entrada: ' . $e->getMessage()
        ], 500);
    }
}

    public function listarEntradas(){
        $entradas=Entrada::all();
        return response()->json([
            'data'=>$entradas
        ]);
    }
    public function modificarEntrada(Request $request, $id){
        $validator=Validator::make($request->all(),[
            'cantidad'=>'sometimes|integer',
            'fila'=>'sometimes|integer',
            'columna'=>'sometimes|integer',
            'sesion_id'=>'sometimes|exists:sesions,id',
            'usuario_id'=>'sometimes|exists:usuarios,id',
        ]);
        if($validator->fails()){
            return response()->json([
                'errors'=>$validator->errors()
            ],422);
        }
        $entrada=Entrada::find($id);
        if(!$entrada){
            return response()->json([
                'message'=>'Entrada no encontrada'
            ],404);
        }
        if($request->has('cantidad')){
            $entrada->cantidad=$request->cantidad;
        }
        if($request->has('sesion_id')){
            $entrada->sesion_id=$request->sesion_id;
        }
        if($request->has('usuario_id')){
            $entrada->usuario_id=$request->usuario_id;
        }
        $entrada->save();
        return response()->json([
            'message'=>'Entrada modificada con éxito',
            'data'=>$entrada
        ]);
    }
    public function eliminarEntrada(Request $request, $id){
        $entrada=Entrada::find($id);
        if(!$entrada){
            return response()->json([
                'message'=>'Entrada no encontrada'
            ],404);
        }
        $entrada->delete();
        return response()->json([
            'message'=>'Entrada eliminada con éxito'
        ]);
    }
    public function listarEntradasPorSesion($idSesion)
    {
        try {
            // Verifica si la sesión existe
            $sesion = Sesion::find($idSesion);
            if (!$sesion) {
                return response()->json([
                    'message' => 'La sesión no existe'
                ], 404);
            }

            // Busca las entradas asociadas a la sesión
            $entradas = Entrada::where('sesion_id', $idSesion)->get();

            return response()->json([
                'message' => 'Entradas de la sesión obtenidas con éxito',
                'data' => $entradas
            ]);
        } catch (\Exception $e) {
            \Log::error('Error al obtener las entradas de la sesión: ' . $e->getMessage());
            return response()->json([
                'error' => 'Error al obtener las entradas de la sesión: ' . $e->getMessage()
            ], 500);
        }
    }
}
