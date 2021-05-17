<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlantImagem extends Model {
    use HasFactory;

    protected $table = 'plant_imagem';

    protected $fillable = [
        'plant_id',
        'name',
    ];

    public function plant() {
        return $this->hasOne(Plant::class, 'plant_id');
    }
}
