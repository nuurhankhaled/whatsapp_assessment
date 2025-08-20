import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_assessment/features/updates/data/models/status_model.dart';
part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(StatusInitial());

  static StatusCubit get(BuildContext context) =>
      BlocProvider.of<StatusCubit>(context);

  List<StatusModel> statusList = [
    StatusModel(
      id: "status_001",
      sender: Sender(
        name: "Sarah Johnson",
        image:
            "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(minutes: 30),
      ), // 30m ago
      stories: [
        "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=600",
        "https://images.unsplash.com/photo-1540979388789-6cee28a1cdc9?w=400&h=600",
        "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_002",
      sender: Sender(
        name: "Mike Chen",
        image:
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 1),
      ), // 1h ago
      stories: [
        "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&h=600",
        "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_003",
      sender: Sender(
        name: "Emma Rodriguez",
        image:
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 2),
      ), // 2h ago
      stories: [
        "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_004",
      sender: Sender(
        name: "Alex Thompson",
        image:
            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 3),
      ), // 3h ago
      stories: [
        "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=600",
        "https://images.unsplash.com/photo-1551632811-561732d1e306?w=400&h=600",
        "https://images.unsplash.com/photo-1502161254066-6c74afbf07aa?w=400&h=600",
        "https://images.unsplash.com/photo-1540979388789-6cee28a1cdc9?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_005",
      sender: Sender(
        name: "Priya Patel",
        image:
            "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 4),
      ), // 4h ago
      stories: [
        "https://images.unsplash.com/photo-1551892374-ecf8754cf8b0?w=400&h=600",
        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_006",
      sender: Sender(
        name: "David Wilson",
        image:
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 5),
      ), // 5h ago
      stories: [
        "https://images.unsplash.com/photo-1551632811-561732d1e306?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_007",
      sender: Sender(
        name: "Lisa Anderson",
        image:
            "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 6),
      ), // 6h ago
      stories: [
        "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400&h=600",
        "https://images.unsplash.com/photo-1499336315816-097655dcfbda?w=400&h=600",
        "https://images.unsplash.com/photo-1506377711776-dbdc2f3c20d9?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_008",
      sender: Sender(
        name: "James Miller",
        image:
            "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 7),
      ), // 7h ago
      stories: [
        "https://images.unsplash.com/photo-1502161254066-6c74afbf07aa?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_009",
      sender: Sender(
        name: "Maya Singh",
        image:
            "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 8),
      ), // 8h ago
      stories: [
        "https://images.unsplash.com/photo-1540979388789-6cee28a1cdc9?w=400&h=600",
        "https://images.unsplash.com/photo-1520637836862-4d197d17c92a?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_010",
      sender: Sender(
        name: "Ryan O'Connor",
        image:
            "https://images.unsplash.com/photo-1556157382-97eda2d62296?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 9),
      ), // 9h ago
      stories: [
        "https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=600",
        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=600",
        "https://images.unsplash.com/photo-1499336315816-097655dcfbda?w=400&h=600",
        "https://images.unsplash.com/photo-1506377711776-dbdc2f3c20d9?w=400&h=600",
        "https://images.unsplash.com/photo-1551632811-561732d1e306?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_011",
      sender: Sender(
        name: "Zara Ahmed",
        image:
            "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 10),
      ), // 10h ago
      stories: [
        "https://images.unsplash.com/photo-1520637836862-4d197d17c92a?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_012",
      sender: Sender(
        name: "Tom Jackson",
        image:
            "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 11),
      ), // 11h ago
      stories: [
        "https://images.unsplash.com/photo-1540979388789-6cee28a1cdc9?w=400&h=600",
        "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_013",
      sender: Sender(
        name: "Nina Kowalski",
        image:
            "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 12),
      ), // 12h ago
      stories: [
        "https://images.unsplash.com/photo-1506377711776-dbdc2f3c20d9?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_014",
      sender: Sender(
        name: "Carlos Martinez",
        image:
            "https://images.unsplash.com/photo-1541101767792-f9b2b1c4f127?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(hours: 15),
      ), // 15h ago
      stories: [
        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=600",
        "https://images.unsplash.com/photo-1499336315816-097655dcfbda?w=400&h=600",
        "https://images.unsplash.com/photo-1506377711776-dbdc2f3c20d9?w=400&h=600",
      ],
    ),
    StatusModel(
      id: "status_015",
      sender: Sender(
        name: "Aisha Hassan",
        image:
            "https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?w=150",
      ),
      timestamp: DateTime.now().toUtc().subtract(
        const Duration(days: 1),
      ), // 1d ago
      stories: [
        "https://images.unsplash.com/photo-1499336315816-097655dcfbda?w=400&h=600",
      ],
    ),
  ];




}
