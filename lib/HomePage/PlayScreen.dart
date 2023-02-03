// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isLoaing = false;
  var isPlaying = [];
  // downloadAUdioFile(String fileUrl) {}
  List<FileSystemEntity> files = [];
  getFileList(String path) async {
    final directory = Directory(path);
    files = directory.listSync();
    for (int i = 0; i < files.length; ++i) {
      isPlaying.add(false);
    }
    setState(() {});
  }

  @override
  initState() {
    getFileList('/data/user/0/com.example.audio_player/app_flutter');
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(String url, index) async {
    await _audioPlayer.play(DeviceFileSource(url));
    setState(() {
      isPlaying[index] = true;
    });
  }

  // Future<String> _loadFile(String url) async {
  //   // download file and save it locally, then return the local file path
  // }

  Future<void> pause(index) async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying[index] = false;
    });
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Downloaded Audio File",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        for (int i = 0; i < files.length; ++i)
          i != 0
              ? i != 1
                  ? Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 210, 210, 210),
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // setState(() {
                          //   isLoaing = !isLoaing;
                          // });
                          !isPlaying[i]
                              ? play(files[i].path.toString(), i)
                              : pause(i);
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => const DownloadingDialog(),
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(files[i].path.split('/').last),
                            !isPlaying[i]
                                ? Icon(Icons.play_arrow)
                                : Icon(Icons.pause),
                          ],
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      margin: EdgeInsets.all(20),
                      height: 50,
                    )
                  : Container()
              : Container()
      ],
    );
  }
}
