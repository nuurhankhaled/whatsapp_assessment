
class StatusModel {
  final String id;
  final Sender sender;
  final DateTime timestamp;
  final String status;

  StatusModel({
    required this.id,
    required this.sender,
    required this.timestamp,
    required this.status,
  });
}

class Sender {
  final String name;
  final String image;
  Sender({required this.name, required this.image});
}
