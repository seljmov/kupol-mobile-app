class Request {
  final int id;
  final String company;
  final String address;
  final String manager;
  final bool highPriority;
  final String creatorName;
  final String description;
  final String date;

  Request({
    required this.id,
    required this.company,
    required this.address,
    required this.manager,
    required this.highPriority,
    required this.creatorName,
    required this.description,
    required this.date,
  });
}
