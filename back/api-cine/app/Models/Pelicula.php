<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Sesion;

class Pelicula extends Model
{
    protected $table = 'peliculas'; // Nombre de la tabla en la base de datos

    protected $fillable = ['titulo', 'duracion', 'genero', 'sinopsis', 'cartel', 'trailer', 'fechaEstreno', 'sesion_id', 'id_youtube']; // Campos que se pueden asignar de forma masiva

    public function sesion()
    {
        return $this->belongsTo(Sesion::class, 'sesion_id'); // Relación con el modelo Sesion
    }
    public $timestamps = false;
}