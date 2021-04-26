<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Plant extends Model {
    use HasFactory;

    protected $table = 'plants';

    protected $fillable = [
        'user_id',
        'especie',
        'icon',
        'irrigar',
        'obs',
    ];

    public function user(){
        return $this->belongsTo(User::class, 'user_id');
    }
}
