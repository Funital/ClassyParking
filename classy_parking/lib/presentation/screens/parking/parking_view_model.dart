import 'package:flutter/material.dart';
import 'parking_model.dart';

class ParkingViewModel extends ChangeNotifier {
  List<ParkingFloor> _floors = [];
  int _selectedFloorIndex = 0;

  ParkingViewModel() {
    _initializeFloors();
  }

  List<ParkingFloor> get floors => _floors;
  int get selectedFloorIndex => _selectedFloorIndex;
  ParkingFloor get currentFloor => _floors[_selectedFloorIndex];

  void _initializeFloors() {
    _floors = [
      ParkingFloor(name: "1st floor", spots: [
        ParkingSpot(id: "A1", isOccupied: true),
        ParkingSpot(id: "A2"),
        ParkingSpot(id: "A3"),
        ParkingSpot(id: "A4", isOccupied: true),
        ParkingSpot(id: "A5"),
        ParkingSpot(id: "A6"),
        ParkingSpot(id: "A7", isOccupied: true),
        ParkingSpot(id: "A8"),
        ParkingSpot(id: "A9", isOccupied: true),
        ParkingSpot(id: "A10", isOccupied: true),
        ParkingSpot(id: "A11"),
        ParkingSpot(id: "A12"),
        ParkingSpot(id: "A13"),
        ParkingSpot(id: "A14", isOccupied: true),
      ]),
      ParkingFloor(name: "2nd floor", spots: [
        ParkingSpot(id: "B1"),
        ParkingSpot(id: "B2"),
        ParkingSpot(id: "B3", isOccupied: true),
        ParkingSpot(id: "B4"),
        ParkingSpot(id: "B5", isOccupied: true),
        ParkingSpot(id: "B6"),
        ParkingSpot(id: "B7"),
        ParkingSpot(id: "B8", isOccupied: true),
        ParkingSpot(id: "B9"),
        ParkingSpot(id: "B10", isOccupied: true),
        ParkingSpot(id: "B11"),
        ParkingSpot(id: "B12", isOccupied: true),
        ParkingSpot(id: "B13"),
        ParkingSpot(id: "B14", isOccupied: true),
      ]),
      ParkingFloor(name: "3nd floor", spots: [
        ParkingSpot(id: "C1"),
        ParkingSpot(id: "C2"),
        ParkingSpot(id: "C3", isOccupied: true),
        ParkingSpot(id: "C4"),
        ParkingSpot(id: "C5", isOccupied: true),
        ParkingSpot(id: "C6", isOccupied: true),
        ParkingSpot(id: "C7"),
        ParkingSpot(id: "C8"),
        ParkingSpot(id: "C9"),
        ParkingSpot(id: "C10"),
        ParkingSpot(id: "C11"),
        ParkingSpot(id: "C12", isOccupied: true),
        ParkingSpot(id: "C13"),
        ParkingSpot(id: "C14", isOccupied: true),
      ]),
      ParkingFloor(name: "4nd floor", spots: [
        ParkingSpot(id: "D1"),
        ParkingSpot(id: "D2"),
        ParkingSpot(id: "D3"),
        ParkingSpot(id: "D4"),
        ParkingSpot(id: "D5", isOccupied: true),
        ParkingSpot(id: "D6"),
        ParkingSpot(id: "D7"),
        ParkingSpot(id: "D8"),
        ParkingSpot(id: "D9"),
        ParkingSpot(id: "D10", isOccupied: true),
        ParkingSpot(id: "D11"),
        ParkingSpot(id: "D12", isOccupied: true),
        ParkingSpot(id: "D13"),
        ParkingSpot(id: "D14", isOccupied: true),
      ]),
    ];
  }

  void changeFloor(int index) {
    _selectedFloorIndex = index;
    notifyListeners();
  }

  void selectSpot(String id) {
    for (var spot in currentFloor.spots) {
      spot.isSelected = false;
    }
    final selected = currentFloor.spots.firstWhere((s) => s.id == id);
    selected.isSelected = true;
    notifyListeners();
  }
}