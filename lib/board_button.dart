import 'package:flutter/material.dart';

class BoardButton extends StatelessWidget {
  String image;
  Function onButtonClick;
  int index;

  BoardButton({
    Key? key,
    required this.image,
    required this.onButtonClick,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {
            onButtonClick(index);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          child: image == 'x'
              ? Image.asset(
            'assets/x.png',
            width: 100,
            height: 100,
          )
              : image == 'o'
              ? Image.asset(
            'assets/o.png',
            width: 100,
            height: 100,
          )
              : Container(),
        ),
      ),
    );
  }
}