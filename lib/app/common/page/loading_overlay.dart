// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/loader_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class LoadingOverlay {
  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }

  LoadingOverlay._create(this._context);
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierColor: ConstantsApp.barrierColor,
      barrierDismissible: false,
      builder: (context) => _FullScreenLoader(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(
      () => hide,
    );
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.001),
        ),
        child: LoaderWidget(),
      ),
    );
  }
}
