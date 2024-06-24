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
            'name' => 'adel',
            'email' => 'adel@gmail.com',
            'role' => 'beheerder',
            'password' => 'adel123',
        ]);

        User::create([
            'name' => 'maik',
            'email' => 'maik@gmail.com',
            'role' => 'beheerder',
            'password' => 'maik1234',
        ]);

        $exercises = [
            [
                'name' => 'Squat',
                'instructionEN' => 'Squat instruction',
                'instructieNL' => 'Squat instructie',
            ],
            [
                'name' => 'Pushup',
                'instructionEN' => 'Pushup instruction',
                'instructieNL' => 'Pushup instructie',
            ],
            [
                'name' => 'Dip',
                'instructionEN' => 'Dip instruction',
                'instructieNL' => 'Dip instructie',
            ],
            [
                'name' => 'Plank',
                'instructionEN' => 'Plank instruction',
                'instructieNL' => 'Plank instructie',
            ],
            [
                'name' => 'Paardentrap',
                'instructionEN' => 'Paardentrap instruction',
                'instructieNL' => 'Paardentrap instructie',
            ],
            [
                'name' => 'Mountain climber',
                'instructionEN' => 'Mountain climber instruction',
                'instructieNL' => 'Mountain climber instructie',
            ],
            [
                'name' => 'Burpee',
                'instructionEN' => 'Burpee instruction',
                'instructieNL' => 'Burpee instructie',
            ],
            [
                'name' => 'Lunge',
                'instructionEN' => 'Lunge instruction',
                'instructieNL' => 'Lunge instructie',
            ],
            [
                'name' => 'Wall sit',
                'instructionEN' => 'Wall sit instruction',
                'instructieNL' => 'Wall sit instructie',
            ],
            [
                'name' => 'Crunch',
                'instructionEN' => 'Crunch instruction',
                'instructieNL' => 'Crunch instructie',
            ],
        ];

        Exercises::insert($exercises);

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
