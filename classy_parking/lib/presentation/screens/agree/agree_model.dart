class AgreeModel {
  final String title;
  final bool isRequired;
  bool isChecked;

  AgreeModel({
    required this.title,
    required this.isRequired,
    this.isChecked = false,
  });
}