import 'package:latlong2/latlong.dart';

class ParkingLotModel {
  final LatLng location;
  final String name;
  final String address;
  final String phone;
  final int totalSpaces;
  final int availableSpaces;
  final String feeInfo;
  final String operationInfo;

  ParkingLotModel({
    required this.location,
    required this.name,
    required this.address,
    required this.phone,
    required this.totalSpaces,
    required this.availableSpaces,
    required this.feeInfo,
    required this.operationInfo,
  });
}