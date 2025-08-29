// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/minor_page.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_one.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_two.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/performance_page.dart';

class FindCreditPage extends StatefulWidget {
  FindCreditPage({this.history, super.key});
  HistoryEntity? history;

  @override
  State<FindCreditPage> createState() => _FindCreditPageState();
}

class _FindCreditPageState extends State<FindCreditPage> {
  final pageControllerchild = PageController();
  final screens = <dynamic>[];

  @override
  void initState() {
    screens.add(PageOne(pageController: pageControllerchild));
    screens.add(
      PageTwo(
        pageController: pageControllerchild,
      ),
    );
    screens.add(
      PageThree(
        history: widget.history,
        pageController: pageControllerchild,
      ),
    );
    screens.add(MinorPage(pageController: pageControllerchild));
    screens.add(PerformanceFindPage(pageController: pageControllerchild));

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
