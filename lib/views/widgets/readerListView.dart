import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/constant/constant.dart';
import 'package:quran_app/model/reader.dart';
import 'package:quran_app/prvider/audioProvider.dart';

class ReaderListView extends StatefulWidget {
  const ReaderListView({super.key, required this.reader});

  final Reader reader;

  @override
  State<ReaderListView> createState() => _ReaderListViewState();
}

class _ReaderListViewState extends State<ReaderListView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height:
          screenWidth < screenHeight ? screenHeight * 0.75 : screenHeight * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: screenWidth < screenHeight
                ? screenHeight * 0.59
                : screenHeight * 0.25,
            child: ListView.builder(
                itemCount: widget.reader.content.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        audioProvider.currentReader = widget.reader.name;
                        audioProvider.idx = index;
                        audioProvider.currentAudio =
                            widget.reader.content[index].path;
                      });
                      audioProvider.stopAudio();
                      audioProvider.playAudio();
                      audioProvider.setUpAudio(
                          item: widget.reader.content[index], idx: index);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.all(5),
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 5,
                            color: textColor,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          audioProvider.isPlay
                              ? widget.reader.name ==
                                          audioProvider.currentReader &&
                                      audioProvider.suraNme ==
                                          widget.reader.content[index].name
                                  ? spinKitAudioPlay()
                                  : const Text("")
                              : const Text(""),
                          Text(
                            widget.reader.content[index].name,
                            style: const TextStyle(
                              fontSize: 27,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              // fontFamily: 'arabic',
                              fontFamily: 'english',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          audioProvider.showBottomContainer
              ? Container(
                  decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${audioProvider.currentReader} <<< ",
                            style:
                                const TextStyle(color: textColor, fontSize: 20),
                          ),
                          Text(
                            audioProvider.suraNme,
                            style:
                                const TextStyle(color: textColor, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${audioProvider.currentPosition.inMinutes.toString().padLeft(2, '0')}:${((audioProvider.currentPosition.inSeconds) % 60).toString().padLeft(2, '0')}",
                            style: const TextStyle(color: textColor),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Slider(
                                activeColor: textColor,
                                value: audioProvider.currentPosition.inSeconds
                                    .toDouble(),
                                max: audioProvider.lengthDuration.inSeconds
                                    .toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    audioProvider.seekTo(value.toInt());
                                  });
                                }),
                          ),
                          Text(
                            "${audioProvider.lengthDuration.inMinutes.toString()}:${((audioProvider.lengthDuration.inSeconds) % 60).toString().padLeft(2, '0')}",
                            style: const TextStyle(color: textColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (audioProvider.currentReader ==
                                        widget.reader.name &&
                                    audioProvider.idx > 0 &&
                                    audioProvider.idx <
                                        widget.reader.content.length) {
                                  setState(() {
                                    audioProvider.idx--;
                                    audioProvider.suraNme = widget
                                        .reader.content[audioProvider.idx].name;
                                    audioProvider.currentAudio = widget
                                        .reader.content[audioProvider.idx].path;
                                  });
                                  audioProvider.player.stop;
                                  audioProvider.playAudio();
                                  audioProvider.setUpAudio(
                                      item: widget
                                          .reader.content[audioProvider.idx],
                                      idx: audioProvider.idx);
                                }
                              },
                              icon: const Icon(Icons.first_page,
                                  size: 33, color: textColor)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  audioProvider.isPlay = !audioProvider.isPlay;
                                  if (audioProvider.isPlay) {
                                    audioProvider.playAudio();
                                  } else {
                                    audioProvider.pausePlayer();
                                  }
                                });
                              },
                              icon: Icon(
                                  audioProvider.isPlay
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 33,
                                  color: textColor)),
                          IconButton(
                              onPressed: () {
                                if (audioProvider.currentReader ==
                                        widget.reader.name &&
                                    audioProvider.idx <
                                        widget.reader.content.length - 1) {
                                  setState(() {
                                    audioProvider.idx++;
                                    audioProvider.suraNme = widget
                                        .reader.content[audioProvider.idx].name;
                                    audioProvider.currentAudio = widget
                                        .reader.content[audioProvider.idx].path;
                                  });
                                  audioProvider.player.stop;
                                  audioProvider.playAudio();
                                  audioProvider.setUpAudio(
                                      item: widget
                                          .reader.content[audioProvider.idx],
                                      idx: audioProvider.idx);
                                }
                              },
                              icon: const Icon(Icons.last_page,
                                  size: 33, color: textColor)),
                        ],
                      ),
                    ],
                  ),
                )
              : const Text(""),
        ],
      ),
    );
  }

  SpinKitWave spinKitAudioPlay() {
    return const SpinKitWave(
      color: textColor,
      size: 25.0,
    );
  }
}
