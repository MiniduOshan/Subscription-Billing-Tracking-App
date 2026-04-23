<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reminders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('bill_id')->constrained()->cascadeOnDelete();
            $table->enum('type', ['due_tomorrow', 'due_today', 'overdue', 'upcoming']);
            $table->enum('status', ['pending', 'sent', 'snoozed', 'cancelled'])->default('pending');
            $table->timestamp('remind_at');
            $table->timestamp('snoozed_until')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'status']);
            $table->index(['remind_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reminders');
    }
};
