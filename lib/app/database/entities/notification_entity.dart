// ignore_for_file: sort_constructors_first, avoid_equals_and_hash_code_on_mutable_classes
import 'package:hive/hive.dart';

part 'notification_entity.g.dart';

@HiveType(typeId: 44)
class NotificationEntity {
  @HiveField(0)
  int? idNotification;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isOpen;  
  @HiveField(4)
  DateTime registerDate;
  @HiveField(5)
  String? image;
  @HiveField(6)
  String? url;
  @HiveField(7)
  String? option;
  @HiveField(8)
  int? idApi;

  NotificationEntity({
    this.idNotification,
    this.title = '',
    this.description = '',
    this.isOpen = false,
    DateTime? registerDate,
    this.image,
    this.url,
    this.option,
    this.idApi = 0,
  }) : registerDate = registerDate ?? DateTime.now();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationEntity &&
        other.idNotification == idNotification;
  }

  @override
  int get hashCode => idNotification.hashCode;

  NotificationEntity copyWith({
    int? idNotification,
    String? title,
    String? description,
    bool? isOpen,
    DateTime? registerDate,
    String? image,
    String? url,
    String? option,
  }) {
    return NotificationEntity(
      idNotification: idNotification ?? this.idNotification,
      title: title ?? this.title,
      description: description ?? this.description,
      isOpen: isOpen ?? this.isOpen,
      registerDate: registerDate ?? this.registerDate,
      image: image ?? this.image,
      url: url ?? this.url,
      option: option ?? this.option,
    );
  }
}
