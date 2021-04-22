<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller {
    
    public function login(Request $request) {
        $request->validate([
            'email' => 'required|email',
            'senha' => 'required|min:6'
        ]);
        
        $user = User::where('email', $request->email)->firstOrFail();

        if(Hash::check($request->senha, $user->password)) {
            $token = $user->createToken('user')->plainTextToken;;

            return response()->json(['token' => $token]);
        }

        return response(null, 403);
    }

    public function register(Request $request) {
        $request->validate([
            'nome' => 'required|min:3',
            'email' => 'required|unique:users',
            'senha' => 'required|min:6'
        ]);

        $user = new User();

        $user->name = $request->nome;
        $user->email = $request->email;
        $user->password = bcrypt($request->senha);

        $user->save();

        $token = $user->createToken('user')->plainTextToken;

        return response()->json(['token' => $token]);
    }

    public function forgot(Request $request) {
        echo  'teste routas';
    }

    public function logout(Request $request) {
        $request->user()->currentAccessToken()->delete();

        return response(null, 200);
    }
}
