enum ReportTargetType { user, message }

enum ReportReason { harassment, spam, hateSpeech, inappropriateContent, other }

class SafetyReport {
  const SafetyReport({
    required this.id,
    required this.targetType,
    required this.targetId,
    required this.reason,
    required this.createdAt,
  });

  final String id;
  final ReportTargetType targetType;
  final String targetId;
  final ReportReason reason;
  final DateTime createdAt;

  Map<String, Object?> toJson() => {
        'id': id,
        'targetType': targetType.name,
        'targetId': targetId,
        'reason': reason.name,
        'createdAt': createdAt.toIso8601String(),
      };
}
