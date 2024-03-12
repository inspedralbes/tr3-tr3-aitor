<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pelicula extends Model
{
    public function peliculas()
    {
        return $this->hasMany(Pelicula::class, 'sesion_id');
    }

    public function entradas()
    {
        return $this->hasMany(Entrada::class, 'sesion_id');
    }
}
