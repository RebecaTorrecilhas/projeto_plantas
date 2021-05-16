<?php

namespace App\Http\Controllers;

use App\Models\Plant;
use App\Models\PlantImagem;
use Illuminate\Http\Request;

class PlantController extends Controller {

    public function getAll(Request $request) {
        $plants = Plant::with('imagens')->where('user_id', $request->user()->id)->get();
        return response()->json($plants);
    }

    public function get(Request $request, $id) {
        $plant = Plant::with('imagens')->where([
            'user_id' => $request->user()->id,
            'id' => $id
        ])->firstOrFail();

        return response()->json($plant);
    }

    public function add(Request $request) {
        $request->validate([
            'especie' => 'required|min:3',
            'icon' => 'required'
        ]);

        $plant = new Plant();

        $plant->user_id = $request->user()->id;
        $plant->especie = $request->especie;
        $plant->icon = $request->icon;
        $plant->irrigar = $request->irrigar;
        $plant->obs = $request->obs;

        $plant->save();

        return response(null, 200);
    }

    public function edit(Request $request, $id) {
        $request->validate([
            'especie' => 'required|min:3',
            'icon' => 'required'
        ]);

        $plant = Plant::where(['user_id' => $request->user()->id, 'id' => $id])->first();

        $plant->especie = $request->especie;
        $plant->icon = $request->icon;
        $plant->irrigar = $request->irrigar;
        $plant->obs = $request->obs;

        $plant->save();

        return response(null, 200);
    }

    public function destroy(Request $request, $id) {
        Plant::where(['user_id' => $request->user()->id, 'id' => $id])->delete();
        return response(null, 200);
    }

    public function addImagem(Request $request, $id) {
        $request->validate([
            'imagem' => 'required|image|mimes:jpg,bmp,png,jpeg',
        ]);

        $image = $request->file('imagem');
        $name = time() . '.' . $image->getClientOriginalExtension();
        $destinationPath = public_path('/images');
        $image->move($destinationPath, $name);

        $plant_image = new PlantImagem();

        $plant_image->plant_id = $id;
        $plant_image->name = $name;

        $plant_image->save();

        return response(null, 200);
    }

    public function removeImagem(Request $request, $id) {
        PlantImagem::where('id', $id)->delete();
        return response(null, 200);
    }
}
