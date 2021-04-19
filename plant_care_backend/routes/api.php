<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);
    Route::post('forgot', [AuthController::class, 'forgot']);
});

Route::middleware('auth:sanctum')->group(function () {
    Route::get('teste', function () {
        echo 'teste auth';
    });
});
