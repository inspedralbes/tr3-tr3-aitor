<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Sesion;
use Illuminate\Support\Facades\Validator;

class SesionController extends Controller
{
    public function crearSesion(Request $request){
        $validator=Validator::make($request->all(),[
            'fecha'=>'required|date_format:Y-m-d',
            'diaEspectador'=>'required|boolean',
            'precio'=>'required|numeric'
        ]);
        if($validator->fails()){
            return response()->json([
                'errors'=>$validator->errors()
            ],422);
        }
        $sesion=new Sesion();
        $sesion->fecha=$request->fecha;
        $sesion->diaEspectador=$request->diaEspectador;
        $sesion->precio=$request->precio;
        $sesion->save();
        return response()->json([
            'message'=>'Sesion creada con éxito',
            'data'=>$sesion
        ],201);
    }
    
    public function listarSesiones() {
        $sesiones = Sesion::with('pelicula')->get();
        return response()->json([
            'data' => $sesiones
        ]);
    }
    public function obtenerSesion($id){
        $sesion=Sesion::find($id);
        if(!$sesion){
            return response()->json([
                'message'=>'Sesion no encontrada'
            ],404);
        }
        return response()->json([
            'data'=>$sesion
        ]);
    }
    
    public function modificarSesion(Request $request, $id){
        $validator=Validator::make($request->all(),[
            'fecha'=>'sometimes|date_format:Y-m-d',
            'diaEspectador'=>'sometimes|boolean',
            'precio'=>'sometimes|numeric'
        ]);
        if($validator->fails()){
            return response()->json([
                'errors'=>$validator->errors()
            ],422);
        }
        $sesion=Sesion::find($id);
        if(!$sesion){
            return response()->json([
                'message'=>'Sesion no encontrada'
            ],404);
        }
        if($request->has('fecha')){
            $sesion->fecha=$request->fecha;
        }
        if($request->has('diaEspectador')){
            $sesion->diaEspectador=$request->diaEspectador;
        }
        if($request->has('precio')){
            $sesion->precio=$request->precio;
        }
        $sesion->save();
        return response()->json([
            'message'=>'Sesion modificada con éxito',
            'data'=>$sesion
        ]);
    }
    
    public function eliminarSesion($id){
        $sesion=Sesion::find($id);
        if(!$sesion){
            return response()->json([
                'message'=>'Sesion no encontrada'
            ],404);
        }
        $sesion->delete();
        return response()->json([
            'message'=>'Sesion eliminada con éxito'
        ]);
    }
    public function listarSesionesPorId($id) {
        // Buscar la sesión por ID
        $sesion = Sesion::with('pelicula')->find($id);
    
        // Verificar si la sesión fue encontrada
        if (!$sesion) {
            return response()->json([
                'error' => 'Sesión no encontrada'
            ], 404);
        }
    
        // Devolver la respuesta JSON con la sesión encontrada
        return response()->json([
            'data' => $sesion
        ]);
    }
}
