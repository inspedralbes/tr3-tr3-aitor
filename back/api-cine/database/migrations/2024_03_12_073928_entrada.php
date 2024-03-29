<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
{
    Schema::create('entradas', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('sesion_id');
        $table->integer('fila');
        $table->integer('columna');
        $table->integer('cantidad');
        $table->foreign('sesion_id')->references('id')->on('sesions')->onDelete('cascade');
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('entradas');
    }
};