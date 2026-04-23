<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $categories = Category::query()
            ->where(function ($query) use ($request) {
                $query->where('is_system', true)
                    ->orWhere('user_id', $request->user()->id);
            })
            ->orderBy('name')
            ->get();

        return response()->json(['data' => $categories]);
    }

    public function store(Request $request): JsonResponse
    {
        $payload = $request->validate([
            'name' => ['required', 'string', 'max:120'],
            'color' => ['nullable', 'string', 'max:20'],
            'icon' => ['nullable', 'string', 'max:50'],
        ]);

        $category = Category::create([
            ...$payload,
            'user_id' => $request->user()->id,
            'is_system' => false,
        ]);

        return response()->json(['data' => $category], 201);
    }

    public function update(Request $request, Category $category): JsonResponse
    {
        abort_if($category->is_system || $category->user_id !== $request->user()->id, 403);

        $payload = $request->validate([
            'name' => ['sometimes', 'string', 'max:120'],
            'color' => ['nullable', 'string', 'max:20'],
            'icon' => ['nullable', 'string', 'max:50'],
        ]);

        $category->update($payload);

        return response()->json(['data' => $category->fresh()]);
    }

    public function destroy(Request $request, Category $category): JsonResponse
    {
        abort_if($category->is_system || $category->user_id !== $request->user()->id, 403);

        $category->delete();

        return response()->json(['message' => 'Category deleted']);
    }
}
