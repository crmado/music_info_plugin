# Music Info Plugin

這是一個 Flutter 插件，專為獲取 iOS 設備上當前正在播放的音樂信息而設計。透過此插件，你可以在 Flutter 應用中輕鬆獲取當前正在播放的音樂標題、藝術家、專輯等信息。

## 功能特點

- 獲取 iOS 設備上當前播放的音樂詳細信息
- 支持獲取以下音樂信息（如果有）：
  - 歌曲標題 (title)
  - 藝術家 (artist)
  - 專輯標題 (albumTitle)
  - 專輯藝術家 (albumArtist)
  - 音樂類型 (genre)
  - 歌曲時長 (duration)
  - 發行日期 (releaseDate)
  - 音軌編號 (trackNumber)
  - 碟片編號 (discNumber)
  - 播放次數 (playCount)
- 內建媒體庫權限請求和狀態檢查
- 簡潔易用的 API 接口

## 系統要求

- iOS 11.0 或更高版本
- Flutter 3.3.0 或更高版本
- Dart 3.7.2 或更高版本

## 安裝方法

將此依賴項添加到你的 `pubspec.yaml` 文件：

```yaml
dependencies:
  music_info_plugin: ^0.1.0
```

或者，如果你想使用 GitHub 倉庫版本：

```yaml
dependencies:
  music_info_plugin:
    git:
      url: https://github.com/你的用戶名/music_info_plugin.git
      ref: main  # 或指定某個標籤/分支
```

然後執行：

```bash
flutter pub get
```

## iOS 設置

在你的 iOS 專案的 `Info.plist` 文件中添加以下權限描述：

```xml
<key>NSAppleMusicUsageDescription</key>
<string>需要訪問您的媒體庫來獲取正在播放的音樂信息</string>
```

## 使用方法

### 基本用法

```dart
import 'package:music_info_plugin/music_info_plugin.dart';

// 創建插件實例
final musicInfoPlugin = MusicInfoPlugin();

// 請求媒體庫權限（在使用前必須先請求）
final bool hasPermission = await musicInfoPlugin.requestMediaPermission();

if (hasPermission) {
  // 獲取當前音樂信息
  final Map<String, String>? trackInfo = await musicInfoPlugin.getCurrentTrackInfo();
  
  if (trackInfo != null) {
    // 處理獲取到的音樂信息
    print('正在播放: ${trackInfo['title']} - ${trackInfo['artist']}');
    print('專輯: ${trackInfo['albumTitle']}');
    // ... 其他信息
  } else {
    print('沒有正在播放的音樂');
  }
} else {
  print('未獲得媒體庫訪問權限');
}
```

### 完整示例

請參考 `example` 目錄中的示例應用，它展示了如何使用此插件獲取音樂信息，並以列表形式顯示所有可用信息。

## 方法說明

| 方法 | 說明 | 返回值 |
|------|------|--------|
| `requestMediaPermission()` | 請求媒體庫訪問權限 | `Future<bool>` |
| `getCurrentTrackInfo()` | 獲取當前正在播放的音樂信息 | `Future<Map<String, String>?>` |
| `getPlatformVersion()` | 獲取平台版本信息 | `Future<String?>` |

## 常見問題與注意事項

1. **僅適用於 iOS 平台**：此插件目前僅支持 iOS 平台，在 Android 平台上調用相關方法會返回錯誤或空值。

2. **權限問題**：使用前必須先請求媒體庫訪問權限，否則無法獲取音樂信息。

3. **音樂播放源限制**：此插件僅能獲取通過系統音樂播放器（如 Apple Music 或 iTunes）播放的音樂信息，無法獲取第三方音樂應用（如 Spotify、YouTube Music 等）播放的音樂信息。

4. **無播放音樂時**：當沒有正在播放的音樂時，`getCurrentTrackInfo()` 方法會返回 `null`。

5. **信息可用性**：返回的音樂信息取決於當前播放音樂的元數據完整性，某些音樂可能缺少部分信息。

## 故障排除

如果你在使用插件時遇到問題，請嘗試以下解決方案：

1. 確認已在 Info.plist 中添加了 `NSAppleMusicUsageDescription` 權限描述。
2. 確認用戶已授予應用媒體庫訪問權限。
3. 確認設備上正在使用系統音樂播放器播放音樂。
4. 檢查是否捕獲了 PlatformException 以獲取詳細錯誤信息。

## 許可證

此插件使用 MIT 許可證。詳情請參閱 [LICENSE](LICENSE) 文件。

## 貢獻

歡迎提交問題報告和改進建議！如果你想貢獻代碼，請先提交 issue 討論你想改變的內容。
 
