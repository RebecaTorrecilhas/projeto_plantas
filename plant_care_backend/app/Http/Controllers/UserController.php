<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller {
    public function get(Request $request) {
        $user = $request->user();

        return response()->json($user);
    }

    public function edit(Request $request) {
        $request->validate([
            "nome" => "required|min:3",
            "email" => "required|email",
            "senha" => "min:6"
        ]);

        $user = User::find($request->user()->id);

        $user->name = $request->nome;
        $user->email = $request->email;

        if (isset($request->senha)) {
            $user->password = bcrypt($request->senha);
        }

        $user->save();

        return response(null, 200);
    }
}
