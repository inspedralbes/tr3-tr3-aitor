<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Novedades extends Model
{
    protected $table = 'novedades';
    protected $fillable = ['title', 'sinopsis', 'estreno', 'poster', 'trailer, id_youtube'];

    public $timestamps = false;
}
