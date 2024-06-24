<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Exercises extends Model
{
    use HasFactory, Notifiable, HasApiTokens;
    public $timestamps = false;


    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'instructionEN',
        'instructieNL',
    ];

    public function Achievements(): HasMany
    {
        return $this->hasMany(Achievements::class, 'id', 'exerciseID');
    }
}
