import Flutter
import MediaPlayer
import UIKit

public class MusicInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "music_info_plugin", binaryMessenger: registrar.messenger())
    let instance = MusicInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getCurrentTrackInfo":
      getCurrentTrackInfo(result: result)
    case "requestMediaPermission":
      requestMediaPermission(result: result)
    case "getCurrentTrackArtwork":
      getCurrentTrackArtwork(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func requestMediaPermission(result: @escaping FlutterResult) {
    MPMediaLibrary.requestAuthorization { status in
      switch status {
      case .authorized:
        result(true)
      default:
        result(false)
      }
    }
  }

  private func getCurrentTrackInfo(result: @escaping FlutterResult) {
    guard MPMediaLibrary.authorizationStatus() == .authorized else {
      result(
        FlutterError(
          code: "PERMISSION_DENIED",
          message: "Media Library permission is not granted",
          details: nil))
      return
    }

    if let currentItem = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem {
      let trackInfo: [String: Any?] = [
        "title": currentItem.title,
        "artist": currentItem.artist,
        "albumTitle": currentItem.albumTitle,
        "albumArtist": currentItem.albumArtist,
        "genre": currentItem.genre,
        "duration": currentItem.playbackDuration,
        "releaseDate": currentItem.releaseDate?.timeIntervalSince1970,
        "trackNumber": currentItem.albumTrackNumber,
        "discNumber": currentItem.discNumber,
        "playCount": currentItem.playCount,
        "hasArtwork": currentItem.artwork != nil,
      ]

      // 過濾掉nil值並轉換為字符串
      let filteredInfo = trackInfo.compactMapValues { $0 }.mapValues { "\($0)" }
      result(filteredInfo)
    } else {
      result(nil)  // 沒有正在播放的音樂
    }
  }

  private func getCurrentTrackArtwork(result: @escaping FlutterResult) {
    guard MPMediaLibrary.authorizationStatus() == .authorized else {
      result(
        FlutterError(
          code: "PERMISSION_DENIED",
          message: "Media Library permission is not granted",
          details: nil))
      return
    }

    if let currentItem = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem,
      let artwork = currentItem.artwork
    {
      // 獲取適當尺寸的圖像，預設使用300×300的尺寸
      let targetSize = CGSize(width: 300, height: 300)
      if let image = artwork.image(at: targetSize) {
        if let imageData = image.pngData() {
          result(FlutterStandardTypedData(bytes: imageData))
        } else {
          result(
            FlutterError(
              code: "IMAGE_ENCODING_ERROR",
              message: "Failed to encode artwork image",
              details: nil))
        }
      } else {
        result(
          FlutterError(
            code: "NO_ARTWORK_IMAGE",
            message: "Failed to get artwork image",
            details: nil))
      }
    } else {
      result(nil)  // 沒有專輯封面或沒有正在播放的音樂
    }
  }
}
