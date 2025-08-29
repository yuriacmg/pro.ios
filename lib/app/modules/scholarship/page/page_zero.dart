// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/app_custom_scroll_behavior.dart';
import 'package:perubeca/app/common/widgets/appbarCommon.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/web/app_bar_back_common_web_widget.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/find_page.dart';
import 'package:perubeca/app/modules/scholarship/page/foreign/foreign_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_exam_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_general_page.dart';
import 'package:perubeca/app/modules/scholarship/page/search/scolarship_search_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_scholarship_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class PageZero extends StatefulWidget {
  PageZero({required this.pageController, this.scaffoldKey, super.key});
  PageController pageController;
  GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<PageZero> createState() => _PageZeroState();
}

class _PageZeroState extends State<PageZero> {
  final internetConnection = CheckInternetConnection();
  double loaderValue = 0.2;
  bool isOffline = true;

  @override
  void initState() {
    super.initState();
    internetConnection.internetStatus().listen((status) {
      if (mounted) {
        setState(() {
          isOffline = (status == ConnectionStatus.offline);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              if (constraints.maxWidth > 1000)
                AppBarBackCommonWebWidget(
                  title: 'Encuentra tu beca o crédito educativo',
                  subtitle: 'subtitle',
                  scaffoldKey: widget.scaffoldKey!,
                )
              else
                AppBarCommon(
                  title: 'Encuentra tu beca o crédito educativo',
                  subtitle: '',
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ScrollConfiguration(
                        behavior: AppCustomScrollBehavior(),
                        child: SizedBox(
                          width: (constraints.maxWidth > 1000)
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  '¿Qué quieres hacer \nhoy?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontFamily: ConstantsApp.OPSemiBold,
                                    color: ConstantsApp.textBluePrimary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              CardScholarshipWidget(
                                title: 'Becas y créditos educativos',
                                icon: ConstantsApp.zeroEncuentraIcon,
                                gradientColors: const [
                                  Color(0x29004A92),
                                  Color(0x290A8CB3),
                                  Color(0x29E71D73),
                                  Color(0x29F59D24),
                                ],
                                gradientStops: [0.0, 0.5, 0.75, 1.0],
                                onTap: () {
                                  // pageController.jumpToPage(1);
                                  registerPageAnalytics('/ReniecFindCredit');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          FindCreditPage(),
                                    ),
                                  );
                                },
                              ),
                              CardScholarshipWidget(
                                title: 'Buscador de becas y créditos',
                                icon: ConstantsApp.zerSearchIcon,
                                gradientColors: const [
                                  Color(0x29E71D73),
                                  Color(0x290895EA),
                                  Color(0x29004A92),
                                ],
                                gradientStops: [0.0, 0.5, 1.0],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const ScholarshipSearchPage(),
                                    ),
                                  );
                                },
                              ),
                              CardScholarshipWidget(
                                title: 'Becas de otros países',
                                icon: ConstantsApp.zeroWorldIcon,
                                gradientColors: const [
                                  Color(0x293C9EC5),
                                  Color(0x29E71D73),
                                  Color(0x29F59D24),
                                ],
                                gradientStops: [0.0, 0.5, 1.0],
                                onTap: () {
                                  const url =
                                      'https://www.gob.pe/institucion/pronabec/campa%C3%B1as/4189-becas-ofrecidas-por-otros-paises';
                                  launchUrlAPP(url);
                                },
                              ),
                              Visibility(
                                visible: false,
                                child: CardScholarshipWidget(
                                  title: 'Prepárate',
                                  icon: ConstantsApp.zeroExamenIcon,
                                  gradientColors: const [
                                    Color(0x293C9EC5),
                                    Color(0x29E71D73),
                                    Color(0x29F59D24),
                                  ],
                                  gradientStops: [0.0, 0.5, 1.0],
                                  onTap: () {
                                    registerPageAnalytics('/ReniecPrepareExam');
                                    if (ConstantsApp.loginView) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              PrepareGeneralPage(
                                            pageController:
                                                widget.pageController,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              PrepareExamPage(
                                            areaCode: '400000',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: CardScholarshipWidget(
                                  title: 'Becas para Extranjeros',
                                  icon: ConstantsApp.zeroWorldIcon,
                                  gradientColors: const [
                                    Color(0x293C9EC5),
                                    Color(0x29E71D73),
                                    Color(0x29F59D24),
                                  ],
                                  gradientStops: [0.0, 0.5, 1.0],
                                  onTap: () {
                                    registerPageAnalytics('/ForeignFindCredit');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ForeignPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
