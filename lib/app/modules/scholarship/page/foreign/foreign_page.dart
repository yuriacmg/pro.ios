// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
// import 'package:perubeca/app/modules/scholarship/page/find_credit/minor_page.dart';
// import 'package:perubeca/app/modules/scholarship/page/find_credit/page_one.dart';
// import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
// import 'package:perubeca/app/modules/scholarship/page/find_credit/page_two.dart';
// import 'package:perubeca/app/modules/scholarship/page/find_credit/performance_page.dart';
import 'package:perubeca/app/modules/scholarship/page/foreign/foreign_search_page.dart';

class ForeignPage extends StatefulWidget {
  ForeignPage({this.history, super.key});
  HistoryEntity? history;

  @override
  State<ForeignPage> createState() => _ForeignPageState();
}

class _ForeignPageState extends State<ForeignPage> {
  final pageControllerchild = PageController();
  final screens = <dynamic>[];

  @override
  void initState() {
    screens.add(ForeignSearchPage(pageController: pageControllerchild));
     screens.add(
      PageThree(
        history: widget.history,
        isForeign: true,
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
