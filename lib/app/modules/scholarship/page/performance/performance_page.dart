// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/modules/scholarship/page/consulta_reniec_page.dart';
import 'package:perubeca/app/modules/scholarship/page/performance/performance_detail_page.dart';
import 'package:perubeca/app/utils/constans.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});
  // PageController fatherPageController;

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  final pageControllerchild = PageController();

  final screens = <dynamic>[];
  final fondoApp = kIsWeb ? ConstantsApp.fondoAppWeb : ConstantsApp.fondoApp;

  @override
  void initState() {
    screens.add(
      ConsultaReniecPage(
        // fatherPageController: widget.fatherPageController,
        pageControllerChild: pageControllerchild,
        value: '1',
      ),
    );
    screens.add(
      PerformanceDetailPage(
        // fatherPageController: widget.fatherPageController,
        pageController: pageControllerchild,
      ),
    );

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
