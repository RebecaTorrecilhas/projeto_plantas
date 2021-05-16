<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlantImagemTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('plant_imagem', function (Blueprint $table) {
            $table->id();
            $table->foreignId('plant_id');
            $table->string('name');

            $table->timestamps();

            $table->foreign('plant_id')->references('id')->on('plants')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('plant_imagem');
    }
}
