// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/constant/constant.dart';
import 'package:quran_app/model/reader.dart';
import 'package:quran_app/prvider/audioProvider.dart';
import 'package:quran_app/views/widgets/readerListView.dart';

class ReaderContent extends StatefulWidget {
  const ReaderContent({super.key, required this.reader});
  final Reader reader;
  @override
  State<ReaderContent> createState() => _ReaderContentState();
}

class _ReaderContentState extends State<ReaderContent> {
  
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bodyColor,
        appBar: AppBar(
          // title: Text(audioProvider.currentReader),
          backgroundColor: appBarColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // SizedBox(height: 44),
              Row(
                children: [
                  CircleAvatar(
                    radius: screenHeight*0.06,
                    // backgroundColor: textColor,
                    backgroundImage: AssetImage(
                      widget.reader.img,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.10),
                  Text(
                    widget.reader.name,
                    style: const TextStyle(color: textColor, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              ReaderListView(
                reader: widget.reader,
              )
            ],
          ),
        ),
      ),
    );
  }
}
