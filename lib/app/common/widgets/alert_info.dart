// ignore: lines_longer_than_80_chars
// ignore_for_file: must_be_immutable, avoid_dynamic_calls, always_put_required_named_parameters_first

import 'package:flutter/material.dart';

class AppInfoDialog extends StatelessWidget {
  AppInfoDialog({
    super.key,
    required this.title,
    required Function this.yesOnPressed,
    String yes = 'Yes',
  }) {
    _yes = yes;
  }
  final Color _color = Colors.white;
  String title;
  String _yes = '';
  Function? yesOnPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        backgroundColor: _color,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(5),
                    //decoration: Constants().boxDecorationApp,
                    child: Text(
                      _yes,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //textColor: Colors.white,
                  onPressed: () {
                    yesOnPressed!();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
