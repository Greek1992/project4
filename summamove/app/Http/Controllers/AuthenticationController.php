<?php // AuthenticationController

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Validation\ValidationException;

class AuthenticationController extends Controller
{
    public function register(Request $request)
    {
        try
        {
            $attr = $request->validate([
                'name' => 'required|string|max:255',
                'role' => 'required|string|max:255',
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string|min:6|confirmed',
            ]);

            $user = User::create([
                'name' => $attr['name'],
                'role' => $attr['role'],
                'password' => bcrypt($attr['password']),
                'email' => $attr['email']
            ]);

            return response()->json(['message' => 'Registration successful'], 200);
        }
        catch (ValidationException $e)
        {
            return response()->json(['message' => $e->validator->errors()->first()], 422);
        }
    }

    public function login(Request $request)
    {
        $attr = $request->validate(['email' => 'required|string|email|','password' => 'required|string|min:6']);
        if (!Auth::attempt($attr))
        {
            return response()->json(['message' => 'Credentials not match'], 401);
        }
        $response = ['access_token' => auth()->user()->createToken('API Token')->plainTextToken,'token_type' => 'Bearer'];

        return response()->json($response, 200);
    }

    public function logout()
    {
        auth()->user()->tokens()->delete();

        return response()->json(['message' => 'Tokens Revoked'], 200);
    }
}
