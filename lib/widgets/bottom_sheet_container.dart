import 'package:flutter/material.dart';
class BottomSheetContainer extends StatelessWidget {

  BottomSheetContainer({ Key key, @required this.child });

  final Widget child;

  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0)
        )
      ),
      child: child,
    );
  }
}

class BottomSheetHeader extends StatelessWidget {

  BottomSheetHeader({ Key key, @required this.child });

  final Widget child;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      decoration: new BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0)
          )
      ),
      child: child,
    );
  }
}