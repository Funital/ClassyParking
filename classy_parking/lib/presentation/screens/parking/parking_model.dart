class ParkingSpot {
  final String id;
  bool isOccupied;
  bool isSelected;

  ParkingSpot({
    required this.id,
    this.isOccupied = false,
    this.isSelected = false,
  });
}

class ParkingFloor {
  final String name;
  final List<ParkingSpot> spots;

  ParkingFloor({required this.name, required this.spots});
}