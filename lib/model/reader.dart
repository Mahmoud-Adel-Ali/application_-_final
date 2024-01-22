class Item {
  String path;
  String name;

  Item({required this.name, required this.path});
}

class Reader {
  final String name;
  final String img;
  final List<Item> content;

  Reader({required this.name, required this.img, required this.content});
}
