<?php

require __DIR__.'/../vendor/autoload.php';

$app = require __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$user = App\Models\User::updateOrCreate(
    ['email' => 'demo@subscription-tracker.local'],
    [
        'name' => 'Demo User',
        'password' => 'Password123!',
        'role' => 'user',
        'timezone' => 'UTC',
    ]
);

echo 'Created/updated user ID: '.$user->id.PHP_EOL;
