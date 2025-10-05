class ParkingPaymentModel {
  final String carNumber;
  final String location;
  final String parkingTime;
  final String entryTime;
  final String exitTime;
  final int baseFee;
  final int discount;
  final int totalFee;

  ParkingPaymentModel({
    required this.carNumber,
    required this.location,
    required this.parkingTime,
    required this.entryTime,
    required this.exitTime,
    required this.baseFee,
    required this.discount,
    required this.totalFee,
  });
}