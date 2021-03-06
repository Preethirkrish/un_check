import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:un_check/models/item.dart';
import 'package:un_check/utils/constants.dart';
import 'package:un_check/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box itemsBox;
  Map<String, List<Item>> itemsMap;
  @override
  void initState() {
    itemsBox = Hive.box(itemsBoxName);
    itemsMap = Map<String, List<Item>>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SHOPPING LIST',
        ),
        actions: <Widget>[
          Center(
            child: IconButton(
              onPressed: () async {
                await itemsBox.clear();
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: itemsBox.listenable(),
            builder: (context, Box box, _) {
              if (box.isOpen) {
                return Column(
                  children: getAllCategories(),
                );
              } else
                return SizedBox();
            }),
      ),
    );
  }

  sortItemsToMap() {
    itemsMap[bakery] = [];
    itemsMap[study] = [];
    itemsMap[dairy] = [];
    itemsMap[fruits] = [];
    itemsMap[groceries] = [];
    itemsMap[household] = [];
    itemsMap[meat] = [];
    itemsMap[pantry] = [];
    itemsMap[other] = [];
    for (int i = 0; i < itemsBox.length; i++) {
      Item item = itemsBox.getAt(i);
      switch (item.category) {
        case bakery:
          itemsMap[bakery].add(item);
          break;
        case study:
          itemsMap[study].add(item);
          break;
        case dairy:
          itemsMap[dairy].add(item);
          break;
        case fruits:
          itemsMap[fruits].add(item);
          break;
        case groceries:
          itemsMap[groceries].add(item);
          break;
        case household:
          itemsMap[household].add(item);
          break;
        case meat:
          itemsMap[meat].add(item);
          break;
        case pantry:
          itemsMap[pantry].add(item);
          break;
        case other:
          itemsMap[other].add(item);
          break;
      }
    }
  }

  List<Widget> getAllCategories() {
    sortItemsToMap();
    int index = 0;
    List<Widget> categoryWidgets = [];
    itemsMap.forEach((category, itemList) {
      if (itemList.length == 0) {
        categoryWidgets.add(
          CategoryCard(
            done: false,
            title: category.toUpperCase(),
            total: itemList.length,
            completed: 0,
            icon: categoryToIcon[category],
            category: category,
          ),
        );
      } else {
        bool done = false;
        int doneItems = 0;
        itemList.forEach((item) {
          if (item.done) doneItems++;
        });
        if (doneItems == itemList.length) done = true;
        if (done) {
          categoryWidgets.insert(
            index,
            CategoryCard(
              done: done,
              completed: doneItems,
              title: category.toUpperCase(),
              total: itemList.length,
              icon: categoryToIcon[category],
              category: category,
            ),
          );
        } else {
          categoryWidgets.insert(
            0,
            CategoryCard(
              done: done,
              completed: doneItems,
              title: category.toUpperCase(),
              total: itemList.length,
              icon: categoryToIcon[category],
              category: category,
            ),
          );
        }
        index++;
      }
    });

    return categoryWidgets;
  }
}
