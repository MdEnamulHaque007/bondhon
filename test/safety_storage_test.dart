import 'package:bondhon/features/safety/data/safety_storage.dart';
import 'package:bondhon/features/safety/domain/entities/safety_report.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('blocks and unblocks users locally', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = SafetyStorage();

    await storage.blockUser('ayesha-khan');
    await storage.blockUser('tanvir-ahmed');
    expect(
      await storage.readBlockedUserIds(),
      {'ayesha-khan', 'tanvir-ahmed'},
    );

    await storage.unblockUser('ayesha-khan');
    expect(await storage.readBlockedUserIds(), {'tanvir-ahmed'});
  });

  test('saves a structured moderation report', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = SafetyStorage();

    await storage.saveReport(
      SafetyReport(
        id: 'report-1',
        targetType: ReportTargetType.message,
        targetId: 'message-1',
        reason: ReportReason.spam,
        createdAt: DateTime.utc(2026, 9, 17),
      ),
    );

    final encodedReports =
        await SharedPreferencesAsync().getString(SafetyStorage.reportsKey);
    expect(encodedReports, contains('message-1'));
    expect(encodedReports, contains('spam'));
  });
}
