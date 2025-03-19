import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:music_info_plugin/music_info_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _hasPermission = false;
  Map<String, String>? _trackInfo;
  String _statusMessage = '';
  final _musicInfoPlugin = MusicInfoPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _musicInfoPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _requestPermission() async {
    try {
      final hasPermission = await _musicInfoPlugin.requestMediaPermission();
      setState(() {
        _hasPermission = hasPermission;
        _statusMessage = hasPermission ? '已獲得媒體庫訪問權限' : '未獲得媒體庫訪問權限';
      });
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = '權限請求失敗: ${e.message}';
      });
    }
  }

  Future<void> _getCurrentTrackInfo() async {
    if (!_hasPermission) {
      setState(() {
        _statusMessage = '請先獲取權限';
      });
      return;
    }

    try {
      final trackInfo = await _musicInfoPlugin.getCurrentTrackInfo();
      setState(() {
        _trackInfo = trackInfo;
        if (trackInfo == null) {
          _statusMessage = '沒有正在播放的音樂';
        } else {
          _statusMessage = '成功獲取音樂信息';
        }
      });
    } on PlatformException catch (e) {
      setState(() {
        _statusMessage = '獲取音樂信息失敗: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('音樂信息插件示例')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('運行環境: $_platformVersion'),
              const SizedBox(height: 20),
              Text('權限狀態: ${_hasPermission ? "已授權" : "未授權"}'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _requestPermission,
                child: const Text('請求媒體庫權限'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getCurrentTrackInfo,
                child: const Text('獲取當前音樂信息'),
              ),
              const SizedBox(height: 10),
              Text('狀態: $_statusMessage'),
              const SizedBox(height: 20),
              if (_trackInfo != null) ...[
                const Text(
                  '音樂信息:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children:
                        _trackInfo!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${entry.key}: ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(child: Text(entry.value)),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
