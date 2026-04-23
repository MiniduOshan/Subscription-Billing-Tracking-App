<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('subscriptions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('category_id')->nullable()->constrained()->nullOnDelete();
            $table->string('name');
            $table->string('provider')->nullable();
            $table->text('description')->nullable();
            $table->enum('billing_cycle', ['weekly', 'monthly', 'yearly', 'custom'])->default('monthly');
            $table->unsignedInteger('custom_cycle_days')->nullable();
            $table->decimal('amount', 12, 2);
            $table->string('currency', 5)->default('USD');
            $table->date('start_date')->nullable();
            $table->date('due_date')->nullable();
            $table->date('next_due_date')->nullable();
            $table->enum('status', ['active', 'paused', 'cancelled'])->default('active');
            $table->string('payment_method')->nullable();
            $table->unsignedInteger('reminder_days_before')->default(3);
            $table->boolean('auto_renew')->default(true);
            $table->timestamps();

            $table->index(['user_id', 'status']);
            $table->index(['user_id', 'next_due_date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('subscriptions');
    }
};
