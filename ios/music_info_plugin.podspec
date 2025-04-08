#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint music_info_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'music_info_plugin'
  s.version          = '0.1.3'
  s.summary          = 'Flutter 插件，用於獲取 iOS 設備上當前正在播放的音樂信息'
  s.description      = <<-DESC
Flutter 插件，用於獲取 iOS 設備上當前正在播放的音樂信息，包括標題、藝術家、專輯詳情及封面圖像。
                       DESC
  s.homepage         = 'https://github.com/crmado/music_info_plugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'crmado' => 'crmado@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # 啟用隱私清單
  s.resource_bundles = {'music_info_plugin_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
