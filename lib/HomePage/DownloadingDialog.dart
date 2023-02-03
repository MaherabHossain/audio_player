// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadingDialog extends StatefulWidget {
  var url;
  DownloadingDialog(String this.url);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  Future<List<FileSystemEntity>> getFileList(String path) async {
    final directory = Directory(path);
    List<FileSystemEntity> files = directory.listSync();
    return files;
  }

  void startDownloading() async {
    final prefs = await SharedPreferences.getInstance();
    // const String url =
    //     'https://file-examples.com/storage/feeb72b10363daaeba4c0c9/2017/11/file_example_MP3_700KB.mp3';
    File file = new File(widget.url);
    String fileName = file.path.split('/').last;
    // const String fileName = "TV.jpg";
    // final List<String>? items = prefs.getStringList('items');
    // if (items != null) {
    //   for (int i = 0; i < items.length; ++i) {
    //     if (items[i] == fileName) {}
    //   }
    // }
    List<FileSystemEntity> files =
        await getFileList('/data/user/0/com.example.audio_player/app_flutter');
    for (var file in files) {
      print(file.path.toString());
      // String temp = file.path;
      String tempName = file.path.split('/').last;
      if (tempName == fileName) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("This file already exist!"),
        ));
        return;
      } else {
        print("Not");
      }
    }
    String path = await _getFilePath(fileName);
    // ignore: prefer_interpolation_to_compose_strings
    // print("path is" + await _getFilePath(fileName));
    await dio.download(
      widget.url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        // print(progress);
      },
      deleteOnError: true,
    ).then((_) async {
      Navigator.pop(context);
    });
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();
    // print("Dialog opening!");
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
