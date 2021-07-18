import 'package:flutter/material.dart';

class CustomShadowCardWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry paddingAll;
  final EdgeInsetsGeometry margin;
  final VoidCallback onTap;
  const CustomShadowCardWidget({
    this.child,
    this.width,
    this.height,
    this.paddingAll,
    this.margin,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(

        child: Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 7,
                color: Colors.grey[700].withOpacity(0.2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              child
            ],
          ),
        ),
      ),
    );
  }
}