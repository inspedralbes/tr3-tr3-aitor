<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Pelicula;

class Sesion extends Model
{
    protected $table = 'sesions'; // Nombre de la tabla en la base de datos

    protected $fillable = ['fecha', 'diaEspectador','precio']; // Campos que se pueden asignar de forma masiva

    public function pelicula()
    {
        return $this->hasOne(Pelicula::class, 'sesion_id'); // Relación con el modelo Pelicula
    }
    public $timestamps = false;
}