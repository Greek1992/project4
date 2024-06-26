<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoveController;
use App\Http\Controllers\AuthenticationController;

Route::get('items/achievements', [MoveController::class, 'Achievementindex']);
Route::get('items/achievements/{id}', [MoveController::class, 'Achievementid']);
Route::get('items/achievements/exercises/{id}', [MoveController::class, 'Achievementexercise']);


Route::get('items/achievements/users/{id}', [MoveController::class, 'Achievementuser']);

Route::get('items/exercises', [MoveController::class, 'Exerciseindex']);
Route::get('items/exercises/{id}', [MoveController::class, 'Exerciseid']);

Route::get('items/users', [MoveController::class, 'Userindex']);
Route::get('items/users/{id}', [MoveController::class, 'Userid']);

Route::post('/register', [AuthenticationController::class, 'register']);
Route::post('/login', [AuthenticationController::class, 'login']);
Route::group(['middleware' => ['auth:sanctum']], function ()
{
    Route::get('profile', function(Request $request) { return auth()->user();});
    Route::get('/userId', function(Request $request) { return auth()->user()->id;});
    Route::post('/logout', [AuthenticationController::class, 'logout']);

    Route::get('items/achievements/{userId}/{moveId}', [MoveController::class, 'AchievementUserexercise']);
    Route::post('items/achievements', [MoveController::class, 'Achievementtoevoegen']);
    Route::put('items/achievements/{id}', [MoveController::class, 'updateAchievement']);
    Route::delete('items/achievements/{id}', [MoveController::class, 'deleteAchievement']);

    Route::post('items/exercises', [MoveController::class, 'Exercisetoevoegen']);
    Route::put('items/exercises/{id}', [MoveController::class, 'updateExercise']);
    Route::delete('items/exercises/{id}', [MoveController::class, 'deleteExercise']);

    Route::delete('items/users/{id}', [MoveController::class, 'deleteUser']);
    Route::get('items/achievements/users/{id}', [MoveController::class, 'Achievementuser']);
});

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});
