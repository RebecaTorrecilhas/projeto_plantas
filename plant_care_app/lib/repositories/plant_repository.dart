import '../models/plant.dart';

class PlantRepository {
  final List<Plant> _plantas = [];

  get plantas => this._plantas;

  PlantRepository() {
    _plantas.addAll([
      Plant(
        especie: 'Coroa de Frade',
        icon: 'images/031-botanic.png',
        obs: 'Essa espécie não é exigente quanto ao solo e a disponibilidade de água.',
        irrigacao: 'Todo dia',
      ),
      Plant(
        especie: 'Planta fantasma',
        icon: 'images/046-botanic.png',
        obs: 'Essa espécie não necessita de muita água.',
        irrigacao: 'Uma vez na semana',
      ),
      Plant(
        especie: 'Tulipa',
        icon: 'images/050-botanic.png',
        obs: 'Prefere lugares frescos e arejados. Deve-se evitar expor a mesma à iluminosidade intensa.',
        irrigacao: 'Duas vezes na semana',
      ),
      Plant(
        especie: 'Espada de São jorge',
        icon: 'images/042-botanic.png',
        obs: 'Pode ser acomodada em lugares internos e com pouca luz, sendo uma das poucas espécies que resistem a falta da mesma.',
        irrigacao: 'Uma vez na semana',
      ),
      Plant(
        especie: 'Azulzinha',
        icon: 'images/013-botanic.png',
        obs: 'Pode ser cultivada em pleno sol ou meia sombra, nas areas quentes meia sombra.',
        irrigacao: 'A cada dois dias',
      ),
      Plant(
        especie: 'Girasol',
        icon: 'images/015-botanic.png',
        obs: 'Deve-se por expor a mesma em locais que recebem sol na maior parte do dia.',
        irrigacao: 'Todo dia',
      ),

    ]);
  }
}