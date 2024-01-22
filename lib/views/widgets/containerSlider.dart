import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/constant/constant.dart';
import 'package:quran_app/model/reader.dart';
import 'package:quran_app/prvider/audioProvider.dart';

class ContainerSlider extends StatefulWidget {
  const ContainerSlider({super.key, required this.reader});
  final Reader reader;

  @override
  State<ContainerSlider> createState() => _ContainerSliderState();
}

class _ContainerSliderState extends State<ContainerSlider> {
  onAudioChanged(AudioProvider audioProvider) {
    audioProvider.player.onPositionChanged.listen((event) {
      setState(() {
        if (audioProvider.lengthDuration == audioProvider.currentPosition) {
          rightClick(audioProvider);
        }
        audioProvider.currentPosition = event;
      });
    });
    audioProvider.player.onDurationChanged.listen((event) {
      setState(() {
        audioProvider.lengthDuration = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    onAudioChanged(audioProvider);
    return Container(
      decoration: BoxDecoration(
          color: appBarColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${audioProvider.currentReader} <<< ",
                style: const TextStyle(color: textColor, fontSize: 20),
              ),
              Text(
                audioProvider.suraNme,
                style: const TextStyle(color: textColor, fontSize: 20),
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
                    value: audioProvider.currentPosition.inSeconds.toDouble(),
                    max: audioProvider.lengthDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        audioProvider.seekTo(value.toInt());
                      });
                    
                    },
                    
                    ),
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
                    leftClick(audioProvider);
                  },
                  icon:
                      const Icon(Icons.first_page, size: 33, color: textColor)),
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
                      audioProvider.isPlay ? Icons.pause : Icons.play_arrow,
                      size: 33,
                      color: textColor)),
              IconButton(
                  onPressed: () {
                    rightClick(audioProvider);
                  },
                  icon:
                      const Icon(Icons.last_page, size: 33, color: textColor)),
            ],
          ),
        ],
      ),
    );
  }

  void leftClick(AudioProvider audioProvider) {
    if (audioProvider.currentReader == widget.reader.name &&
        audioProvider.idx > 0 &&
        audioProvider.idx < widget.reader.content.length) {
      setState(() {
        audioProvider.idx--;
        audioProvider.suraNme = widget.reader.content[audioProvider.idx].name;
        audioProvider.currentAudio =
            widget.reader.content[audioProvider.idx].path;
      });
      audioProvider.player.stop;
      audioProvider.playAudio();
      audioProvider.setUpAudio(
          item: widget.reader.content[audioProvider.idx],
          idx: audioProvider.idx);
    }
  }

  void rightClick(AudioProvider audioProvider) {
    if (audioProvider.currentReader == widget.reader.name &&
        audioProvider.idx < widget.reader.content.length - 1) {
      setState(() {
        audioProvider.idx++;
        audioProvider.suraNme = widget.reader.content[audioProvider.idx].name;
        audioProvider.currentAudio =
            widget.reader.content[audioProvider.idx].path;
      });
      audioProvider.player.stop;
      audioProvider.playAudio();
      audioProvider.setUpAudio(
          item: widget.reader.content[audioProvider.idx],
          idx: audioProvider.idx);
    }
  }
}
