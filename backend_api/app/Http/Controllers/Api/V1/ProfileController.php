<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function show(Request $request): JsonResponse
    {
        return response()->json([
            'data' => $request->user(),
        ]);
    }

    public function update(Request $request): JsonResponse
    {
        $payload = $request->validate([
            'name' => ['sometimes', 'string', 'max:255'],
            'timezone' => ['sometimes', 'string', 'max:120'],
            'avatar_url' => ['nullable', 'url', 'max:2000'],
        ]);

        $request->user()->update($payload);

        return response()->json([
            'message' => 'Profile updated',
            'data' => $request->user()->fresh(),
        ]);
    }
}
