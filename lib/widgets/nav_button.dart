import 'package:flutter/material.dart';


class BottomNavyBar extends StatefulWidget {
  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();
}

class _BottomNavyBarState extends State<BottomNavyBar> {
  int selectedIndex = 0;
  Color backgroundColor = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text('Home')),
    NavigationItem(Icon(Icons.shopping_basket), Text('Cart')),
    NavigationItem(Icon(Icons.list), Text('Orders')),
    NavigationItem(Icon(Icons.person), Text('Profile'))
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      height: double.maxFinite,
      width: isSelected ? 125 : 50,
      padding: isSelected ? EdgeInsets.only(right: 16, left: 16) : null,
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.red.shade800,
              borderRadius: BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
            data: IconThemeData(size: 24, color: isSelected ? backgroundColor : Colors.black),
            child: item.icon,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: isSelected ? 
              DefaultTextStyle.merge(
                style: TextStyle(
                  color: backgroundColor
                ),
                child: item.title
              )
             : Container(),
          )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 10),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = itemIndex;
              });
            },
            child: _buildItem(item, selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;

  NavigationItem(this.icon, this.title);
}