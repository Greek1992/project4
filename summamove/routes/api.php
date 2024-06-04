<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoveController;

Route::get('reservaties', [MoveController::class, 'Reservatieindex']);
Route::get('reservaties/{id}', [MoveController::class, 'Reservatieid']);
Route::get('reservaties/tafels/{id}', [MoveController::class, 'Reservatietafel']);

Route::get('klanten', [MoveController::class, 'Klantindex']);
Route::get('klanten/{id}', [MoveController::class, 'Klantid']);

Route::get('tafels', [MoveController::class, 'Tafelindex']);
Route::get('tafels/{id}', [MoveController::class, 'Tafelid']);

Route::post('/register', [AuthenticationController::class, 'register']);
Route::post('/login', [AuthenticationController::class, 'login']);
Route::group(['middleware' => ['auth:sanctum']], function ()
{
    Route::get('profile', function(Request $request) { return auth()->user();});
    Route::post('/logout', [AuthenticationController::class, 'logout']);

    Route::post('reservaties', [MoveController::class, 'Reservatietoevoegen']);
    Route::put('reservaties/{id}', [MoveController::class, 'updateReservatie']);
    Route::delete('reservaties/{id}', [MoveController::class, 'deleteReservatie']);
});

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});
