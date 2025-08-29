// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, use_build_context_synchronously, inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_hijo_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_user_entity.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/area_common_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_exam_simulacrum_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_prepare_scholarship_offline_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_prepare_scholarship_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/init_simulacrum_exam_alert.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';
// import 'package:perubeca/app/utils/constans.dart';

class ResultRecienExamPage extends StatefulWidget {
  ResultRecienExamPage({required this.pageController, required this.areaCode, super.key});
  PageController pageController;
  String areaCode;

  @override
  State<ResultRecienExamPage> createState() => _ResultRecienExamPageState();
}

class _ResultRecienExamPageState extends State<ResultRecienExamPage> {
  String fullName = '';
  //List<PrepareAreaEntity> areas = [];
  List<PrepareAreaHijoEntity> areas = [];
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    getDataInitial();
  }

  Future<void> getDataInitial() async {
    //final prepareAreabox = await Hive.openBox<PrepareAreaEntity>('prepareAreaBox');
    final prepareAreaHijosbox = await Hive.openBox<PrepareAreaHijoEntity>('prepareAreaHijoBox');
    final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
   
    //areas = prepareAreabox.values.toList();
    final hijos = prepareAreaHijosbox.values.toList();
    areas = hijos.where( (e) => e.codigoPadre == widget.areaCode).toList();
     final users = prepareUserBox.values.toList();
     if(users.isNotEmpty){
      final userFound = users.where((element) => element.status! == true).first;
      fullName = '${userFound.nombre!.split(' ').first} ${userFound.apePaterno!}';
     }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BackAppBarCommon(
              title: 'Prepárate',
              subtitle: '',
              backString: 'Regresar',
              ontap: () {
                // widget.pageController.jumpToPage(0);
                Navigator.pop(context);
              },
            ),
            // BackAppBarRectangleCommon(
            //   ontap: () {
            //     widget.pageController.jumpToPage(0);
            //   },
            // ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Visibility(
                        visible: fullName.isNotEmpty,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: GenericStylesApp().title(
                            text: fullName,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GenericStylesApp().messagePage(
                          text: 'Te ayudaremos a prepararte para rendir exámenes de admisión.',
                        ),
                      ),
                      StreamBuilder<Object>(
                        stream: internetConnection.internetStatus(),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: areas.length,
                                itemBuilder: (context, index) {
                                  final model = areas[index];
                                  if (model.orden != 3) {
                                    return (snapshot.data == ConnectionStatus.offline)
                                        ? CardPrepareScholarshipOfflineWidget(
                                            title: model.nombre!,
                                            icon: model.enlaceLogoOffline!,
                                            constraints: constraints,
                                            textButton: model.orden == 4 ? 'Empezar' : null,
                                            onTap: () async {
                                              if (model.orden != 4) {
                                                final page = await getPage(model.orden!, int.parse(model.codigo!), model.nombre!,int.parse(model.codigoPadre!));
      
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext context) => page,
                                                  ),
                                                );
                                              }
                                              if (model.orden == 4) {
                                                await getPage(model.orden!, int.parse(model.codigo!), model.nombre!,int.parse(model.codigoPadre!));
                                              }
                                            },
                                          )
                                        : CardPrepareScholarshipWidget(
                                            title: model.nombre!,
                                            icon: model.enlaceLogo!,
                                            constraints: constraints,
                                            textButton: model.orden == 4 ? 'Empezar' : null,
                                            onTap: () async {
                                              if (model.orden != 4) {
                                                if (model.orden == 1) {
                                                  await registerPageAnalytics('/AreaComonInit');
                                                }
                                                if (model.orden == 1) {
                                                  await registerPageAnalytics('/AreaInterestInit');
                                                }
      
                                                final page = await getPage(model.orden!, int.parse(model.codigo!), model.nombre!,int.parse(model.codigoPadre!));
      
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext context) => page,
                                                  ),
                                                );
                                              }
                                              if (model.orden == 4) {
                                                await getPage(model.orden!, int.parse(model.codigo!), model.nombre!,int.parse(model.codigoPadre!));
                                              }
                                            },
                                          );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BottonCenterWidget(
                                      sized: 220,
                                      ontap: () async {
                                        //nueva consulta
                                        if(!ConstantsApp.loginView){
                                          Navigator.pop(context);
                                          widget.pageController.jumpToPage(0);
                                        }else{
                                          Navigator.pop(context, true);
                                        }
                                      },
                                      text: 'Hacer nueva consulta',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          );
                        },
                      ),
                    
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> getPage(int orden, int code, String title, int generalCode) async {
    if (orden == 4) {
      final prepareAreaCommonbox = await Hive.openBox<PrepareAreaCommonEntity>('prepareAreaCommonBox');
      final list = prepareAreaCommonbox.values.toList();
      final area = list.where((element) => element.codigoPreparate == code).first;
      final alert = InitSimulacrumExamAlert(
        onTap: () async {
          await registerPageAnalytics('/PrepareExamInit');
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => PrepareExamSimulacrumPage(
                area: area,
                redesign: false,
              ),
            ),
          );
        },
      );
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (orden != 3) {
      //temario es igual a tres
      return AreaCommonPage(prepareCode: code, title: title, generalCode: generalCode);
    }

    return Container();
  }
}
