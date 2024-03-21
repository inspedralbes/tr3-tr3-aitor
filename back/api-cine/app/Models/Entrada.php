<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Entrada extends Model
{
    protected $table = 'entradas';
    protected $fillable = ['cantidad','fila','columna', 'sesion_id'];
    public function sesion()
    {
        return $this->belongsTo(Sesion::class, 'sesion_id');
    }
    public $timestamps = false;
}
