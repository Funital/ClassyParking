class PrevPayModel {
  final String carNumber;
  final String location;
  final String parkingTime;
  final int baseFee;
  final int discount;
  final int totalFee;

  PrevPayModel({
    required this.carNumber,
    required this.location,
    required this.parkingTime,
    required this.baseFee,
    required this.discount,
    required this.totalFee,
  });
}