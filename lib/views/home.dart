// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/constant/constant.dart';
import 'package:quran_app/model/reader.dart';
import 'package:quran_app/prvider/audioProvider.dart';
import 'package:quran_app/views/widgets/listViewChild.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor:bodyColor,
        appBar: AppBar(
          
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 24, 0, 40),
          title:  Text(
            "Quran App",
            style: TextStyle(
              fontSize: 35,
              color: Colors.purple[100],
              fontWeight: FontWeight.w900,
              fontFamily: 'english',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  if (audioProvider.suraNme != '') {
                    setState(() {
                      audioProvider.isPlay = !audioProvider.isPlay;
                    });
                    if (audioProvider.isPlay) {
                      audioProvider.playAudio();
                    } else {
                      audioProvider.pausePlayer();
                    }
                  }
                },
                icon: !audioProvider.isPlay
                    ? Icon(
                        Icons.play_arrow,
                        size: 35,
                        color: Colors.purple[400],
                      )
                    : Icon(
                        Icons.pause,
                        size: 35,
                        color: Colors.purple[100],
                      ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Text(
                  "قُرّآءْ اَلْمُصْحَفْ ",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'arabic'),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 222,
                  child: ListView.builder(
                    itemCount: allReader.length,
                    itemBuilder: (context, index) {
                      return ListViewChild(
                        reader: allReader[index], color: index%3*100,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List allReader = [
  Reader(
      name: "Islam Sobhi اسلام صبحي ",
      img: 'assets/img/islam.jpeg',
      content: [
        Item(name: "سورةالنمل", path: 'audio/islam/سورة النمل  _ اسلام ص.mp3'),
        Item(name: "سوره يوسف", path: 'audio/islam/سورة يوسف_ اسلام صبحي.mp3'),
        Item(
            name: 'سوره الكهف',
            path: 'audio/islam/سورة الكهف (كاملة) _ القارئ اسلام صبحي.mp3'),
        Item(
            name: 'سوره النجم',
            path: 'audio/islam/سورة النجم _ القارئ اسلام صبحي.mp3'),
        Item(name: 'سوره فصلت', path: 'audio/islam/سورة فصلت.mp3')
      ]),
  Reader(name: "Sherif  شريف مصطفي", img: 'assets/img/sherif.jpg', content: [
    Item(name: 'سوره الواقعة', path: 'audio/sherif/سورة الواقعة كاملة.mp3'),
    Item(name: 'سوره طه', path: 'audio/sherif/سورة طه.mp3'),
    Item(name: 'سوره لقمان', path: 'audio/sherif/سورة لقمان (كاملة).mp3'),
    Item(name: 'سوره مريم', path: 'audio/sherif/سورة مريم (كاملة).mp3'),
    Item(name: ' سوره مريم', path: 'audio/sherif/سورة مريم (كاملة).mp3'),
  ]),
  Reader(name: "ياسر الدوسري", img: 'assets/img/yasser.jpeg', content: [
    Item(name: 'سوره الفاتحه', path: 'audio/yasser/001.mp3'),
    Item(name: 'سوره البقره', path: "audio/yasser/002.mp3"),
    Item(name: 'سوره ال عمران', path: "audio/yasser/003.mp3"),
    Item(name: 'سوره النساء', path: "audio/yasser/004.mp3"),
    Item(name: 'سوره المائده', path: "audio/yasser/005.mp3"),
    Item(name: 'سوره الانعام', path: "audio/yasser/006.mp3"),
    Item(name: 'سوره الاعراف', path: "audio/yasser/007.mp3"),
    Item(name: 'سوره الانفال', path: "audio/yasser/008.mp3"),
    Item(name: 'سوره التوبه', path: "audio/yasser/009.mp3"),
    Item(name: 'سوره يونس', path: "audio/yasser/010.mp3"),
    Item(name: 'سوره هود', path: "audio/yasser/011.mp3"),
    Item(name: 'سوره يوسف', path: "audio/yasser/012.mp3"),
  ]),
];
