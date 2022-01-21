class Event {
  final int id;
  final String creatorName;
  final String? executorName;
  final String status;
  final String name;
  final String category;
  final String address;
  final String description;
  final String date;
  final List<String>? images;

  Event({
    required this.id,
    required this.creatorName,
    this.executorName,
    required this.status,
    required this.name,
    required this.category,
    required this.address,
    required this.description,
    required this.date,
    this.images,
  });
}
