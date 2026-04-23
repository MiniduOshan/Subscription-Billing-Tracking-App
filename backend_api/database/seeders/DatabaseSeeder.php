<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        User::factory()->create([
            'name' => 'System Admin',
            'email' => 'admin@subscription-tracker.local',
            'role' => 'admin',
            'timezone' => 'UTC',
        ]);

        User::factory()->create([
            'name' => 'Test User',
            'email' => 'user@subscription-tracker.local',
            'role' => 'user',
            'timezone' => 'UTC',
        ]);

        $defaultCategories = [
            'Entertainment',
            'Utilities',
            'Hosting',
            'Software',
            'Education',
            'Insurance',
            'Business',
        ];

        foreach ($defaultCategories as $category) {
            Category::firstOrCreate([
                'name' => $category,
                'is_system' => true,
            ]);
        }
    }
}
