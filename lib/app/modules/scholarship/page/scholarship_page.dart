// ignore_for_file: lines_longer_than_80_chars, cascade_invocations, must_be_immutable, always_declare_return_types, inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/modules/scholarship/page/page_zero.dart';
import 'package:perubeca/app/modules/scholarship/page/review/review_page.dart';
import 'package:perubeca/app/modules/scholarship/page/view_sign_page.dart';

class ScholarshipPage extends StatefulWidget {
  ScholarshipPage({this.scaffoldKey, this.indexPageExternal, this.history, super.key});

  int? indexPageExternal;
  GlobalKey<ScaffoldState>? scaffoldKey;
  HistoryEntity? history;

  @override
  State<ScholarshipPage> createState() => _ScholarshipPageState();
}

class _ScholarshipPageState extends State<ScholarshipPage> {
  final pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final screens = <dynamic>[];

  @override
  void initState() {
    super.initState();
       screens.add(
      PageZero(
        pageController: pageController,
        scaffoldKey: widget.scaffoldKey,
      ),
    );
   
    screens.add(const ReviewPage());
    screens.add(ViewSignPage(pageController: pageController));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.indexPageExternal != null) {
        pageController.jumpToPage(widget.indexPageExternal!);
      }
    });
  }

  @override
  void dispose() {
    widget.indexPageExternal = null;
    pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // controller: _scrollController,
      children: [
        Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: screens.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return screens[index] as Widget;
            },
          ),
        ),
      ],
    );
  }
}
