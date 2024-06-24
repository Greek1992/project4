<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Achievements extends Model
{
    use HasFactory, Notifiable, HasApiTokens;
    public $timestamps = false;
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'exerciseID',
        'userID',
        'datum',
        'amount',
    ];

    public function Exercise(): BelongsTo
    {
        return $this->belongsTo(Exercises::class, 'exerciseID');
    }
}
