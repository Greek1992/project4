<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Achievements;
use App\Models\Exercises;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'role' => 'beheerder',
            'password' => 'lol',
        ]);

        Exercises::create([
            'name' => 'Bench press',
            'instructionEN' => 'Lie your back on an elevated position, hold a bar straight up above your chest',
            'instructieNL' => 'Ga met je rug op een hoge positie, houw een staafobject boven je borst',
        ]);

        Achievements::create([
            'exerciseID' => '3',
            'userID' => '2',
            'datum' => '2024-06-06',
            'amount' => '1',
        ]);


    }
}
