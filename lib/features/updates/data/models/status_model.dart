class StatusModel {
  final String id;
  final Sender sender;
  final DateTime timestamp;
  final List<String> stories; 

  StatusModel({
    required this.id,
    required this.sender,
    required this.timestamp,
    required this.stories,
  });
}

class Sender {
  final String name;
  final String image;

  Sender({
    required this.name,
    required this.image,
  });
}
