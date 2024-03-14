<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Sesion;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class SesionController extends Controller
{
    public function crearSesion(Request $request){
        $validator=Validator::make($request->all(),[
            'fecha'=>'required|date_format:Y-m-d',
            'diaEspectador'=>'required|boolean'
        ]);
        if($validator->fails()){
            return response()->json([
                'errors'=>$validator->errors()
            ],422);
        }
        $sesion=new Sesion();
        $sesion->fecha=$request->fecha;
        $sesion->diaEspectador=$request->diaEspectador;
        $sesion->save();
        return response()->json([
            'message'=>'Sesion creada con éxito',
            'data'=>$sesion
        ],201);
    }
    
    public function listarSesiones(){
        $sesiones=Sesion::all();
        return response()->json([
            'data'=>$sesiones
        ]);
    }
    public function modificarSesion(Request $request, $id){
        $validator=Validator::make($request->all(),[
            'fecha'=>'sometimes|date_format:Y-m-d',
            'diaEspectador'=>'sometimes|boolean'
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
}
