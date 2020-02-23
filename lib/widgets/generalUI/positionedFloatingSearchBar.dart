import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PositionedFloatingSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PositionedFloatingSearchBarState();
  }
}

class _PositionedFloatingSearchBarState
    extends State<PositionedFloatingSearchBar> {

      bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5.0,
      right: 15,
      left: 15,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          children: <Widget>[
            Container(
              child: isTyping
                  ? IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )
                    :
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
                onTap: (){
                  setState(() {
                    isTyping = true;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromRGBO(147, 35, 57, 1),
                child: Text('SGW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
