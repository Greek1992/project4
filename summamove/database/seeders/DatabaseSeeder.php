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
            'password' => 'lollol',
        ]);

        User::create([
            'name' => 'x',
            'email' => 'x@x.nl',
            'role' => 'beheerder',
            'password' => 'geheim',
        ]);


        Exercises::create([
            'name' => 'Bench press',
            'instructionEN' => 'Lie your back on an elevated position, hold a bar straight up above your chest',
            'instructieNL' => 'Ga met je rug op een hoge positie, houw een staafobject boven je borst',
        ]);
        Exercises::create([
            'name' => 'Bench press1',
            'instructionEN' => '1',
            'instructieNL' => '1',
        ]);
        Exercises::create([
            'name' => 'Bench press2',
            'instructionEN' => '2',
            'instructieNL' => '2',
        ]);

        Achievements::create([
            'exerciseID' => '3',
            'userID' => '2',
            'datum' => '2024-06-06',
            'amount' => '1',
        ]);

        Achievements::create([
            'exerciseID' => '3',
            'userID' => '2',
            'datum' => '2024-06-07',
            'amount' => '1',
        ]);

        Achievements::create([
            'exerciseID' => '3',
            'userID' => '2',
            'datum' => '2024-06-05',
            'amount' => '1',
        ]);


    }
}
