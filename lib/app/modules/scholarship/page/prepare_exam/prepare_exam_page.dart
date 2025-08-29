// ignore_for_file: cascade_invocations, lines_longer_than_80_chars, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/modules/scholarship/page/consulta_reniec_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/result_reniec_exam_page.dart';
import 'package:perubeca/app/utils/constans.dart';

class PrepareExamPage extends StatefulWidget {
   PrepareExamPage({required this.areaCode, super.key});
  String areaCode;

  @override
  State<PrepareExamPage> createState() => _PrepareExamPageState();
}

class _PrepareExamPageState extends State<PrepareExamPage> {
  final pageControllerchild = PageController();
  final screens = <dynamic>[];
  final fondoApp = kIsWeb ? ConstantsApp.fondoAppWeb : ConstantsApp.fondoApp;

  @override
  void initState() {
    screens.add(
      ConsultaReniecPage(
        pageControllerChild: pageControllerchild,
        value: '2',
      ),
    );
    //screens.add(PrepareGeneralPage(pageController: pageControllerchild));
    screens.add(ResultRecienExamPage(pageController: pageControllerchild, areaCode: widget.areaCode ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: screens.length,
        controller: pageControllerchild,
        itemBuilder: (context, index) {
          return screens[index] as Widget;
        },
      ),
    );
  }
}
