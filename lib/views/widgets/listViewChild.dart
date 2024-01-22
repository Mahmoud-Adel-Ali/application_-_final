import 'package:flutter/material.dart';
import 'package:quran_app/model/reader.dart';
import 'package:quran_app/views/readerContent.dart';

class ListViewChild extends StatefulWidget {
  const ListViewChild({super.key, required this.reader, required this.color});
  final Reader reader;
  final int color;

  @override
  State<ListViewChild> createState() => _ListViewChildState();
}

class _ListViewChildState extends State<ListViewChild> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReaderContent(
                reader: widget.reader,
              ),
            ));
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.purple[widget.color+100],
          borderRadius: BorderRadius.circular(24),
        ),
        child: ListTile(
          // trailing: Icon(Icons.check,color: Colors.black,),
          trailing: CircleAvatar(
            // backgroundColor: textColor,
            backgroundImage: AssetImage(
              widget.reader.img,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(
            widget.reader.name,
            style: const TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
