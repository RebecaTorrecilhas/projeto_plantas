<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\Auth\ForgotPasswordController;
use App\Http\Controllers\PlantController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);
    Route::post('forgot', [ForgotPasswordController::class, 'sendResetLinkEmail']);
});

Route::middleware('auth:sanctum')->group(function () {
    Route::prefix('user')->group(function () {
        Route::get('/', [UserController::class, 'get']);
        Route::put('/', [UserController::class, 'edit']);
    });

    Route::prefix('plant')->group(function () {
        Route::get('/all', [PlantController::class, 'getAll']);
        Route::get('/{id}', [PlantController::class, 'get']);
        Route::post('/',  [PlantController::class, 'add']);
        Route::put('/{id}', [PlantController::class, 'edit']);
        Route::delete('/{id}', [PlantController::class, 'destroy']);
    });

    Route::get('auth/logout', [AuthController::class, 'logout']);
});
