enum AppNotificationType { friendRequest, friendAccepted, message, roomActivity }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.titleEn,
    required this.titleBn,
    required this.bodyEn,
    required this.bodyBn,
    required this.timeEn,
    required this.timeBn,
    required this.targetRoute,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final AppNotificationType type;
  final String titleEn;
  final String titleBn;
  final String bodyEn;
  final String bodyBn;
  final String timeEn;
  final String timeBn;
  final String targetRoute;
  final DateTime createdAt;
  final bool isRead;

  String title(bool isBangla) => isBangla ? titleBn : titleEn;
  String body(bool isBangla) => isBangla ? bodyBn : bodyEn;
  String timeLabel(bool isBangla) => isBangla ? timeBn : timeEn;

  AppNotification copyWith({bool? isRead}) => AppNotification(
        id: id,
        type: type,
        titleEn: titleEn,
        titleBn: titleBn,
        bodyEn: bodyEn,
        bodyBn: bodyBn,
        timeEn: timeEn,
        timeBn: timeBn,
        targetRoute: targetRoute,
        createdAt: createdAt,
        isRead: isRead ?? this.isRead,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'type': type.name,
        'titleEn': titleEn,
        'titleBn': titleBn,
        'bodyEn': bodyEn,
        'bodyBn': bodyBn,
        'timeEn': timeEn,
        'timeBn': timeBn,
        'targetRoute': targetRoute,
        'createdAt': createdAt.toIso8601String(),
        'isRead': isRead,
      };

  factory AppNotification.fromJson(Map<String, Object?> json) {
    return AppNotification(
      id: json['id']! as String,
      type: AppNotificationType.values.byName(json['type']! as String),
      titleEn: json['titleEn']! as String,
      titleBn: json['titleBn']! as String,
      bodyEn: json['bodyEn']! as String,
      bodyBn: json['bodyBn']! as String,
      timeEn: json['timeEn']! as String,
      timeBn: json['timeBn']! as String,
      targetRoute: json['targetRoute']! as String,
      createdAt: DateTime.parse(json['createdAt']! as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}
