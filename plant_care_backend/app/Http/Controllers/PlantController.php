<?php

namespace App\Http\Controllers;

use App\Models\Plant;
use Illuminate\Http\Request;

class PlantController extends Controller {

    public function getAll(Request $request) {
        $plants = Plant::where('user_id', $request->user()->id)->get();
        return response()->json($plants);
    }

    public function get(Request $request, $id) {
        $plant = Plant::where([
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

        $plant = Plant::find($id);

        $plant->especie = $request->especie;
        $plant->icon = $request->icon;
        $plant->irrigar = $request->irrigar;
        $plant->obs = $request->obs;

        $plant->save();

        return response(null, 200);
    }

    public function destroy(Request $request, $id) {
        Plant::destroy($id);
        return response(null, 200);
    }

    public function addImagem(Request $request, $id) {
        // to do
    }

    public function removeImagem(Request $request, $id) {
        // to do
    }
}
