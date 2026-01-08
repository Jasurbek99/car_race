import '../models/car_model.dart';

final List<CarModel> allCars = [
  // Starting car - unlocked by default
  const CarModel(
    id: 'mini',
    name: 'Mini Cooper',
    bodyPath: 'mini/car-body.png',
    tirePath: 'mini/tire.png',
    unlockCost: 0, // Free - starting car
    stats: CarStats(
      baseAcceleration: 1.0,
      baseMaxSpeed: 1.0,
      handling: 1.2,
      gearCount: 4,
    ),
  ),

  // Second car - moderate unlock cost
  const CarModel(
    id: 'car1',
    name: 'Street Racer',
    bodyPath: 'car1/car-body.png',
    tirePath: 'car1/tire.png',
    unlockCost: 200,
    stats: CarStats(
      baseAcceleration: 1.2,
      baseMaxSpeed: 1.1,
      handling: 1.0,
      gearCount: 5,
    ),
  ),

  // Third car - muscle car with high speed
  const CarModel(
    id: 'mustang',
    name: 'Mustang GT',
    bodyPath: 'mustang/car-body.gif',
    tirePath: 'mustang/tire.gif',
    unlockCost: 500,
    stats: CarStats(
      baseAcceleration: 1.1,
      baseMaxSpeed: 1.4,
      handling: 0.9,
      gearCount: 5,
    ),
  ),

  // Fourth car - off-road vehicle with good acceleration
  const CarModel(
    id: 'offroad',
    name: 'Off-Road Racer',
    bodyPath: 'off road racing/car-body.png',
    tirePath: 'off road racing/tire.png',
    unlockCost: 350,
    stats: CarStats(
      baseAcceleration: 1.4,
      baseMaxSpeed: 0.9,
      handling: 1.3,
      gearCount: 4,
    ),
  ),
];

// Helper function to get car by ID
CarModel? getCarById(String id) {
  try {
    return allCars.firstWhere((car) => car.id == id);
  } catch (e) {
    return null;
  }
}

// Helper function to get all unlocked cars for a player
List<CarModel> getUnlockedCars(Set<String> unlockedCarIds) {
  return allCars.where((car) => unlockedCarIds.contains(car.id)).toList();
}

// Helper function to get all locked cars for a player
List<CarModel> getLockedCars(Set<String> unlockedCarIds) {
  return allCars.where((car) => !unlockedCarIds.contains(car.id)).toList();
}
