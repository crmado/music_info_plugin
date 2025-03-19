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
  Future<Map<String, String>?> getCurrentTrackInfo() {
    return MusicInfoPluginPlatform.instance.getCurrentTrackInfo();
  }
}
