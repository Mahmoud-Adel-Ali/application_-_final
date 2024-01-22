import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String s = "سوره يوسف";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fullScreenModalSheet(context);
        },
        child: const Icon(Icons.show_chart),
      ),
      body: Container(),
    );
  }

  Future<dynamic> fullScreenModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.95,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "سوره يوسف",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    s,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Text(
                        "20:02",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Slider(value: 0.5, onChanged: (onChange) {}),
                      ),
                      const Text(
                        "20:02",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  // SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              s = "vjqakjn";
                            });
                            Navigator.pop(context);
                              fullScreenModalSheet(context);
                          },
                          icon: const Icon(
                            Icons.first_page,
                            size: 29,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.pause,
                            size: 29,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                              s = "سوره يوسف";
                              Navigator.pop(context);
                              fullScreenModalSheet(context);
                          },
                          icon: const Icon(
                            Icons.last_page,
                            size: 29,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  
  }
}
