<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sesion extends Model
{
    protected $table = 'sesions';
    protected $fillable = ['fecha', 'diaEspectador'];
    public function sesion()
    {
        return $this->belongsTo(Sesion::class, 'sesion_id');
    }
    public $timestamps = false;
}
