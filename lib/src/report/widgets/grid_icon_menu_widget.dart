import 'package:flutter/material.dart';

class GridIconMenuWidget extends StatelessWidget {
  const GridIconMenuWidget({
    Key key,
    this.title,
    @required this.image,
    this.size = 60,
  }) : super(key: key);

  final String title;
  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.1),
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              height: size,
              color: Colors.white,
              image: AssetImage(image),
            ),
          ),
        ),
        SizedBox(height: 5),
        //Text(title, style: kGrabBlackRegularSmall.copyWith(fontSize: 15)),
      ],
    );
  }
}
