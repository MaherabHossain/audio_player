// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_new, avoid_unnecessary_containers

import 'dart:ffi';
import 'dart:io';

import 'package:audio_player/HomePage/DownloadingDialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';

class DownloadAudio extends StatefulWidget {
  const DownloadAudio({super.key});

  @override
  State<DownloadAudio> createState() => _DownloadAudioState();
}

class _DownloadAudioState extends State<DownloadAudio> {
  bool isLoaing = false;
  var isPlaying = [];
  // downloadAUdioFile(String fileUrl) {}

  @override
  initState() {
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  final List<String> url = [
    "https://file-examples.com/storage/feeb72b10363daaeba4c0c9/2017/11/file_example_MP3_1MG.mp3",
    "https://download.samplelib.com/mp3/sample-9s.mp3",
    "https://download.samplelib.com/mp3/sample-15s.mp3",
  ];

  @override
  Widget build(BuildContext context) {
    // File file = new File(url);
    // String fileName = file.path.split('/').last;
    List<String> fileName = [];
    for (int i = 0; i < url.length; ++i) {
      File file = new File(url[i]);
      // String fileName = file.path.split('/').last;
      fileName.add(file.path.split('/').last);
    }
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            for (int i = 0; i < url.length; ++i)
              Container(
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
                  onTap: () async {
                    // setState(() {
                    //   isLoaing = !isLoaing;
                    // });
                    await showDialog(
                      context: context,
                      builder: (context) => DownloadingDialog(url[i]),
                    );
                    // print(url[i]);
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(fileName[i]),
                      !isLoaing
                          ? Icon(Icons.download)
                          : CircularProgressIndicator(),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: EdgeInsets.all(20),
                height: 50,
              ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
