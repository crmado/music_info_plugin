import 'package:flutter_test/flutter_test.dart';
import 'package:music_info_plugin/music_info_plugin.dart';
import 'package:music_info_plugin/music_info_plugin_platform_interface.dart';
import 'package:music_info_plugin/music_info_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMusicInfoPluginPlatform
    with MockPlatformInterfaceMixin
    implements MusicInfoPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MusicInfoPluginPlatform initialPlatform = MusicInfoPluginPlatform.instance;

  test('$MethodChannelMusicInfoPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMusicInfoPlugin>());
  });

  test('getPlatformVersion', () async {
    MusicInfoPlugin musicInfoPlugin = MusicInfoPlugin();
    MockMusicInfoPluginPlatform fakePlatform = MockMusicInfoPluginPlatform();
    MusicInfoPluginPlatform.instance = fakePlatform;

    expect(await musicInfoPlugin.getPlatformVersion(), '42');
  });
}
