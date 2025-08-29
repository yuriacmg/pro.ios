// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, unnecessary_lambdas, cascade_invocations, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/model/menu_model.dart';
import 'package:perubeca/app/common/navigation_app/app_tab_bar.dart';
import 'package:perubeca/app/common/navigation_app/cubit/notice_cubit.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/notice_entity.dart';
import 'package:perubeca/app/modules/contact/page/contact_page.dart';
import 'package:perubeca/app/modules/history/bloc/history_bloc.dart';
import 'package:perubeca/app/modules/history/page/history_page.dart';
import 'package:perubeca/app/modules/question/page/question_page.dart';
import 'package:perubeca/app/modules/scholarship/page/scholarship_page.dart';
import 'package:perubeca/app/modules/start/page/start_page.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({
    super.key,
    this.selectedIndex,
    this.scholarshipSelectedIndex,
    this.history,
  });
  int? selectedIndex;
  int? scholarshipSelectedIndex;
  HistoryEntity? history;

  @override
  State<NavigationPage> createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  GlobalKey<AppTapBarState> tapbarKey = GlobalKey<AppTapBarState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController();
  int currentIndex = 0;
  final screens = <dynamic>[];
  NoticeEntity? notice;

  final internetConnection = CheckInternetConnection();
  int first = 0;

  static final List<MenuModel> list = [
    ListMenu().menuStart,
    ListMenu().menuScholarship,
    ListMenu().menuHistory,
    ListMenu().menuContact,
    ListMenu().menuQuestion,
  ];

  @override
  void initState() {
    super.initState();
    screens.add(StartPage(scaffoldKey: _scaffoldKey));
    screens.add(
      ScholarshipPage(
        indexPageExternal: widget.scholarshipSelectedIndex,
        scaffoldKey: _scaffoldKey,
        history: widget.history,
      ),
    );
    screens.add(HistoryPage(scaffoldKey: _scaffoldKey));
    screens.add(ContactPage.create(context, _scaffoldKey));
    screens.add(QuestionPage.create(context, _scaffoldKey));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedIndex != null) {
        onChangePageFromSelectedIndex();
      }
    });

    getDataNotice();

    super.initState();
    internetConnection.internetStatus().listen((status) {
      if (status == ConnectionStatus.online) {
        if (!kIsWeb) {
          if (first == 0) {
            context.read<HistoryBloc>().add(HistorySyncEvent());
            first++;
          }
        }
      } else {
        first = 0;
      }
    });
  }

  void onChangePageFromSelectedIndex() {
    currentIndex = widget.selectedIndex!;
    onChangePageApp(currentIndex);
    tapbarKey.currentState!.onChangeSelectedTab(currentIndex);
  }

  void onChangePageApp(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.jumpToPage(currentIndex);
    registerAnalyticsNavigation(index);
    _scaffoldKey.currentState!.closeDrawer();
  }

  Future<void> getDataNotice() async {
    final noticebox = await Hive.openBox<NoticeEntity>('noticeBox');
    final dataList = noticebox.values.toList().where((element) => element.estado! == true).toList();

    notice = dataList.isEmpty ? null : dataList.first;
    final state = context.read<NoticeCubit>().state;
    if ((notice == null || !notice!.estado!) && state) {
      context.read<NoticeCubit>().invisible();
    } else {
      if (state) {
        context.read<NoticeCubit>().visible();
      }
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fondoApp = kIsWeb ? ConstantsApp.fondoAppWeb : ConstantsApp.fondoApp;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(fondoApp),
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              drawerScrimColor: Colors.black26,
              extendBody: true,
              drawer: constraints.maxWidth > 1000
                  ? Drawer(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 94,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.closeDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: ConstantsApp.textBluePrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: Color(0xffF9F9FF),
                              ),
                              child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: InkWell(
                                      onTap: () {
                                        onChangePageApp(index);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: SvgPicture.asset(
                                              list[index].icon,
                                              // ignore: deprecated_member_use
                                              color: currentIndex == index ? ConstantsApp.textBluePrimary : const Color(0xffA7BFD7),
                                              height: 20,
                                            ),
                                          ),
                                          Text(
                                            list[index].name,
                                            style: TextStyle(
                                              color: currentIndex == index ? ConstantsApp.textBluePrimary : const Color(0xffA7BFD7),
                                              fontFamily: ConstantsApp.QSBold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const AppCreditWeb(),
                        ],
                      ),
                    )
                  : null,
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: screens.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return screens[index] as Widget;
                },
              ),
              floatingActionButton: BlocConsumer<NoticeCubit, bool>(
                listener: (context, state) {},
                builder: (context, isVisible) {
                  return notice != null
                      ? Visibility(
                          visible: isVisible,
                          child: Card(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SizedBox(
                              height: 155,
                              width: constraints.maxWidth < 1000 ? double.infinity : 400,
                              child: Stack(
                                children: [
                                  const BackgroundNoticeCard(),
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 20, top: 15, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                notice!.titulo!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ConstantsApp.OPBold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context.read<NoticeCubit>().invisible();
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Html(
                                                    data: notice!.contenido,
                                                    shrinkWrap: true,
                                                    style: {
                                                      'body': Style(
                                                        textAlign: TextAlign.justify,
                                                        color: Colors.white,
                                                        padding: HtmlPaddings.zero,
                                                        margin: Margins.zero,
                                                      ),
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 105),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
              floatingActionButtonLocation:
                  constraints.maxWidth < 1000 ? FloatingActionButtonLocation.miniCenterFloat : FloatingActionButtonLocation.miniEndFloat,
              floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
              bottomNavigationBar: constraints.maxWidth < 1000
                  ? AppTapBar(
                      key: tapbarKey,
                      selectedColor: ConstantsApp.blueTertiaryColor,
                      initialIndex: currentIndex,
                      onTapChanged: (index) async {
                        onChangePageApp(index);
                      },
                      items: [
                        ItemTapBar(
                          iconData: ConstantsApp.startIcon,
                          label: 'Inicio',
                        ),
                        ItemTapBar(
                          iconData: ConstantsApp.scholarshipIcon,
                          label: 'Beca',
                        ),
                        ItemTapBar(
                          iconData: ConstantsApp.historyIcon,
                          label: 'Historial',
                        ),
                        ItemTapBar(
                          iconData: ConstantsApp.contatIcon,
                          label: 'Contacto',
                        ),
                        ItemTapBar(
                          iconData: ConstantsApp.questionIcon,
                          label: 'Preguntas',
                        ),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

void registerAnalyticsNavigation(int index) {
  registerPageAnalytics(getPageName(index));
}

String getPageName(int index) {
  var pageName = '';
  switch (index) {
    case 0:
      pageName = '/Start';
      break;
    case 1:
      pageName = '/Scholarship';
      break;
    case 2:
      pageName = '/History';
      break;
    case 3:
      pageName = '/Contanct';
      break;
    case 4:
      pageName = '/Question';
      break;

    default:
  }
  return pageName;
}

class BackgroundNoticeCard extends StatelessWidget {
  const BackgroundNoticeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // colors: [ConstantsApp.purplePrimaryColor, ConstantsApp.purpleSecondaryColor],
              // colors: [Color(0xffEC3979), Color(0xff802770)],
              colors: [Color.fromRGBO(236, 57, 121, 1), Color.fromRGBO(92, 39, 133, 1)],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          right: -35,
          top: -35,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color.fromRGBO(255, 255, 255, 0.08),
            ),
          ),
        ),
        Positioned(
          child: Image.asset(
            'assets/notice/up.png',
            scale: 1.9,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/notice/down.png',
            scale: 1.9,
          ),
        ),
        Positioned(
          left: -5,
          bottom: -35,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color.fromRGBO(255, 255, 255, 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Image.asset(
            'assets/notice/persons.png',
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class AppCreditWeb extends StatelessWidget {
  const AppCreditWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 3,
              color: ConstantsApp.textBlueSecondary,
            ),
          ),
          // const Text(
          //   'Para soporte técnico contáctanos a \ntravés de:',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontFamily: ConstantsApp.QSMedium,
          //     fontSize: 10,
          //     color: ConstantsApp.textBlueSecondary,
          //   ),
          // ),
          // const Text(
          //   'mesadeayuda@pronabec.gob.pe',
          //   style: TextStyle(
          //     fontFamily: ConstantsApp.QSSemiBold,
          //     fontSize: 10,
          //     color: ConstantsApp.textBlueSecondary,
          //     decoration: TextDecoration.underline,
          //   ),
          // ),
          Image.asset(
            ConstantsApp.logoPronabec,
            scale: 2,
          ),
          const Divider(
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class ListMenu {
  MenuModel menuStart = MenuModel(
    name: 'Inicio',
    icon: ConstantsApp.startIcon,
    route: RoutesApp.home,
  );
  MenuModel menuScholarship = MenuModel(
    name: 'Beca',
    icon: ConstantsApp.scholarshipIcon,
    route: RoutesApp.scholarship,
  );
  MenuModel menuHistory = MenuModel(
    name: 'Historial',
    icon: ConstantsApp.historyIcon,
    route: RoutesApp.history,
  );
  MenuModel menuContact = MenuModel(
    name: 'Contacto',
    icon: ConstantsApp.contatIcon,
    route: RoutesApp.contact,
  );
  MenuModel menuQuestion = MenuModel(
    name: 'Preguntas',
    icon: ConstantsApp.questionIcon,
    route: RoutesApp.question,
  );
}
