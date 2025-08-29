// ignore_for_file: cascade_invocations, must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/modules/scholarship/page/consulta_reniec_page.dart';
import 'package:perubeca/app/modules/scholarship/page/review/review_detail_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});
  // PageController fatherPageController;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final pageControllerchild = PageController();

  final screens = <dynamic>[];

  @override
  void initState() {
    screens.add(
      ConsultaReniecPage(
        // fatherPageController: widget.fatherPageController,
        pageControllerChild: pageControllerchild,
        value: '0',
      ),
    );
    screens.add(
      ReviewDetailPage(
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
