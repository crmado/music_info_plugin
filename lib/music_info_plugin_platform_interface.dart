import 'dart:typed_data';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'music_info_plugin_method_channel.dart';

abstract class MusicInfoPluginPlatform extends PlatformInterface {
  /// Constructs a MusicInfoPluginPlatform.
  MusicInfoPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MusicInfoPluginPlatform _instance = MethodChannelMusicInfoPlugin();

  /// The default instance of [MusicInfoPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMusicInfoPlugin].
  static MusicInfoPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MusicInfoPluginPlatform] when
  /// they register themselves.
  static set instance(MusicInfoPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 請求訪問媒體庫的權限
  /// 返回 [bool] 表示是否授權成功
  Future<bool> requestMediaPermission() {
    throw UnimplementedError(
      'requestMediaPermission() has not been implemented.',
    );
  }

  /// 獲取當前正在播放的音樂信息
  /// 返回一個 [Map<String, String>?] 包含音樂信息，如果沒有正在播放的音樂則返回 null
  Future<Map<String, String>?> getCurrentTrackInfo() {
    throw UnimplementedError('getCurrentTrackInfo() has not been implemented.');
  }

  /// 獲取當前正在播放音樂的專輯封面
  /// 返回 [Uint8List?] 包含圖片數據，如果沒有專輯封面或沒有正在播放的音樂則返回 null
  Future<Uint8List?> getCurrentTrackArtwork() {
    throw UnimplementedError(
      'getCurrentTrackArtwork() has not been implemented.',
    );
  }
}
