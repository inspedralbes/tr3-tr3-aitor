<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\Entrada;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class EntradaController extends Controller
{
    public function crearEntrada(Request $request){
        $validator=Validator::make($request->all(),[
            'cantidad'=>'required|integer',
            'fila'=>'required|integer',
            'columna'=>'required|integer',
            'precio'=>'required|numeric',
            'sesion_id'=>'required|exists:sesions,id'
        ]);
        if($validator->fails()){
            return response()->json([
                'errors'=>$validator->errors()
            ],422);
        }
        $entrada=new Entrada();
        $entrada->cantidad=$request->cantidad;
        $entrada->fila=$request->fila;
        $entrada->columna=$request->columna;
        $entrada->precio=$request->precio;
        $entrada->sesion_id=$request->sesion_id;
        $entrada->save();
        return response()->json([
            'message'=>'Entrada creada con éxito',
            'data'=>$entrada
        ],201);
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
            'precio'=>'sometimes|numeric',
            'sesion_id'=>'sometimes|exists:sesions,id'
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
        if($request->has('precio')){
            $entrada->precio=$request->precio;
        }
        if($request->has('sesion_id')){
            $entrada->sesion_id=$request->sesion_id;
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
}
