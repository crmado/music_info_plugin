import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'music_info_plugin_platform_interface.dart';

/// An implementation of [MusicInfoPluginPlatform] that uses method channels.
class MethodChannelMusicInfoPlugin extends MusicInfoPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('music_info_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<bool> requestMediaPermission() async {
    final bool? result = await methodChannel.invokeMethod<bool>(
      'requestMediaPermission',
    );
    return result ?? false;
  }

  @override
  Future<Map<String, String>?> getCurrentTrackInfo() async {
    final Map<dynamic, dynamic>? result = await methodChannel
        .invokeMethod<Map<dynamic, dynamic>>('getCurrentTrackInfo');

    if (result == null) {
      return null;
    }

    return result.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
  }

  @override
  Future<Uint8List?> getCurrentTrackArtwork() async {
    final Uint8List? result = await methodChannel.invokeMethod<Uint8List>(
      'getCurrentTrackArtwork',
    );
    return result;
  }
}
