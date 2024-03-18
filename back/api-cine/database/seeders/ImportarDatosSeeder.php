<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB; // Asegúrate de importar la clase DB


class ImportarDatosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        $sql = file_get_contents(database_path('seeders/data/datos.sql'));
        DB::unprepared($sql);
    }
}
