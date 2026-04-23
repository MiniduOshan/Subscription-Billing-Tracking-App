<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserManagementController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $users = User::query()
            ->orderBy('created_at', 'desc')
            ->paginate((int) $request->integer('per_page', 20));

        return response()->json($users);
    }

    public function show(User $user): JsonResponse
    {
        return response()->json(['data' => $user]);
    }

    public function updateRole(Request $request, User $user): JsonResponse
    {
        $payload = $request->validate([
            'role' => ['required', 'in:user,admin'],
        ]);

        $user->update(['role' => $payload['role']]);

        return response()->json(['data' => $user->fresh()]);
    }
}
