import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String category;
  @HiveField(2)
  String type;
  @HiveField(3)
  double quantity;

  Item({this.name, this.category, this.type, this.quantity});
}
