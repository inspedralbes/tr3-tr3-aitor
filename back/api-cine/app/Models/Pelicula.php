<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pelicula extends Model
{
    protected $table = 'peliculas';

    protected $fillable = ['titulo', 'duracion', 'genero', 'sinopsis', 'cartel', 'trailer', 'fechaEstreno', 'sesion_id'];


    // Relación con la tabla 'sesions'
    public function sesion()
    {
        return $this->belongsTo(Sesion::class, 'sesion_id');
    }
    public $timestamps = false;
}

