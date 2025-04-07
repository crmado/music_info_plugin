// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:music_info_plugin/music_info_plugin.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final MusicInfoPlugin plugin = MusicInfoPlugin();

  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    final String? version = await plugin.getPlatformVersion();
    // The version string depends on the host platform running the test, so
    // just assert that some non-empty string is returned.
    expect(version?.isNotEmpty, true);
  });

  // 測試媒體庫權限請求 - 只測試API可用性
  testWidgets('requestMediaPermission API可用性', (WidgetTester tester) async {
    try {
      await plugin.requestMediaPermission();
      // 如果沒有異常，說明API可用
      expect(true, true);
    } on PlatformException catch (e) {
      // 如果是權限相關的異常，這是預期的行為，不算失敗
      if (e.code != 'PERMISSION_DENIED') {
        rethrow;
      }
      // 權限問題不算失敗
      expect(true, true);
    }
  });

  // 測試獲取當前音樂信息 - 只測試API可用性
  testWidgets('getCurrentTrackInfo API可用性', (WidgetTester tester) async {
    try {
      await plugin.getCurrentTrackInfo();
      // 如果沒有異常，說明API可用
      expect(true, true);
    } on PlatformException catch (e) {
      // 如果是權限相關的異常，這是預期的行為，不算失敗
      if (e.code != 'PERMISSION_DENIED') {
        rethrow;
      }
      // 權限問題不算失敗
      expect(true, true);
    }
  });

  // 測試獲取專輯封面 - 只測試API可用性
  testWidgets('getCurrentTrackArtwork API可用性', (WidgetTester tester) async {
    try {
      await plugin.getCurrentTrackArtwork();
      // 如果沒有異常，說明API可用
      expect(true, true);
    } on PlatformException catch (e) {
      // 如果是權限相關的異常，這是預期的行為，不算失敗
      if (e.code != 'PERMISSION_DENIED') {
        rethrow;
      }
      // 權限問題不算失敗
      expect(true, true);
    }
  });
}
