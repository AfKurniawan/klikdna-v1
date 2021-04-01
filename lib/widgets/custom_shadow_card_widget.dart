import 'package:flutter/material.dart';

class CustomShadowCardWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double paddingAll;
  final EdgeInsetsGeometry margin;
  const CustomShadowCardWidget({
    this.child,
    this.width,
    this.height,
    this.paddingAll,
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 5,
            color: Colors.grey[500].withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            child
          ],
        ),
      ),
    );
  }
}