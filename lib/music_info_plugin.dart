import 'dart:typed_data';
import 'music_info_plugin_platform_interface.dart';

/// 音樂信息插件，用於獲取iOS設備上當前正在播放的音樂信息
class MusicInfoPlugin {
  /// 獲取平台版本信息
  Future<String?> getPlatformVersion() {
    return MusicInfoPluginPlatform.instance.getPlatformVersion();
  }

  /// 請求訪問媒體庫的權限
  ///
  /// 在iOS上，需要在Info.plist添加NSAppleMusicUsageDescription權限描述
  ///
  /// 返回[bool]表示是否授權成功
  Future<bool> requestMediaPermission() {
    return MusicInfoPluginPlatform.instance.requestMediaPermission();
  }

  /// 獲取當前正在播放的音樂信息
  ///
  /// 如果沒有正在播放的音樂，返回null
  /// 返回的Map可能包含以下鍵：
  /// - title: 歌曲標題
  /// - artist: 藝術家
  /// - albumTitle: 專輯標題
  /// - albumArtist: 專輯藝術家
  /// - genre: 音樂類型
  /// - duration: 歌曲時長（秒）
  /// - releaseDate: 發行日期
  /// - trackNumber: 音軌編號
  /// - discNumber: 碟片編號
  /// - playCount: 播放次數
  /// - hasArtwork: 是否有專輯封面
  Future<Map<String, String>?> getCurrentTrackInfo() {
    return MusicInfoPluginPlatform.instance.getCurrentTrackInfo();
  }

  /// 獲取當前正在播放音樂的專輯封面
  ///
  /// 返回一個 [Uint8List?] 包含PNG格式的圖像數據
  /// 如果當前沒有正在播放的音樂或該音樂沒有專輯封面，則返回null
  ///
  /// 此方法通常會返回300×300大小的圖像，可根據需要自行調整大小
  ///
  /// 範例用法：
  /// ```dart
  /// final Uint8List? artworkData = await musicInfoPlugin.getCurrentTrackArtwork();
  /// if (artworkData != null) {
  ///   Image.memory(artworkData)  // 在Flutter中顯示圖像
  /// }
  /// ```
  Future<Uint8List?> getCurrentTrackArtwork() {
    return MusicInfoPluginPlatform.instance.getCurrentTrackArtwork();
  }
}
