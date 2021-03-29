import '../repositories/plant_repository.dart';
import '../models/plant.dart';

class PlantsController {
  PlantRepository plantRepository;

  List<Plant> get plantas => plantRepository.plantas;

  PlantsController() {
    plantRepository = PlantRepository();
  }
}
