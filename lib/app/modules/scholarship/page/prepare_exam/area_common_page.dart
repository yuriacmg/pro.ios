// ignore_for_file: lines_longer_than_80_chars, avoid_field_initializers_in_const_classes, prefer_const_constructors_in_immutables, inference_failure_on_function_invocation, use_build_context_synchronously, must_be_immutable, cascade_invocations, cast_from_null_always_fails, cast_nullable_to_non_nullable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perubeca/app/common/widgets/back_appbar_rectangle_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/prepare/area_user_history_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_common_entity.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_user_entity.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/exam_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/init_prepare_exam_alert.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class AreaCommonPage extends StatefulWidget {
  AreaCommonPage({
    required this.prepareCode, 
    required this.generalCode, 
    required this.title, 
    super.key,
    });
  int prepareCode;
  int generalCode;
  String title;

  @override
  State<AreaCommonPage> createState() => _AreaCommonPageState();
}

class _AreaCommonPageState extends State<AreaCommonPage> {
  List<PrepareAreaCommonEntity> areas = [];
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  bool isOffline = true;

  late PrepareUserEntity userFound;

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  Future<void> getInitData() async {
    final prepareAreaCommonbox = await Hive.openBox<PrepareAreaCommonEntity>('prepareAreaCommonBox');
    areas = prepareAreaCommonbox.values.where((element) => element.codigoPreparate == widget.prepareCode).toSet().toList();
    areas.sort((a, b) => a.orden!.compareTo(b.orden!));
    areas.map((e) => e.status = ConstantsApp.areaInitial).toList();

    final prepareUserBox = await Hive.openBox<PrepareUserEntity>('prepareUserBox');
    final users = prepareUserBox.values.toList();
    userFound = users.where((element) => element.status! == true).first;

    if (userFound.status!) {
      final areUserHistoryBox = await Hive.openBox<AreaUserHistoryEntity>('areaUserHistoryBox');
      final arealist = areUserHistoryBox.values.toList();
      final listAreaUserHistory = arealist.where((element) => element.userDocument == userFound.numdoc && element.generalCode == widget.generalCode).toList();

      for (final areaUserHistory in listAreaUserHistory) {
        for (final area in areas) {
              if (area.codigo == areaUserHistory.areaId && area.codigoPreparate == areaUserHistory.areaCode) {
                area.status = areaUserHistory.areaStatus;
                break;
              }
            }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BackAppBarRectangleCommon(
              ontap: () {
                Navigator.pop(context);
              },
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Divider(color: Colors.transparent),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GenericStylesApp().title(
                          text: widget.title,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GenericStylesApp().messagePage(
                          text: 'Recuerda tener a la mano lápiz, papel y calculadora para resolver estas preguntas. ¡Échale un vistazo!',
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          childAspectRatio: 3 / 2.5,
                          mainAxisSpacing: 1,
                        ),
                        itemCount: areas.length,
                        itemBuilder: (BuildContext context, int index) {
                          final area = areas[index];
                          return StreamBuilder<Object>(
                            stream: internetConnection.internetStatus(),
                            builder: (context, snapshot) {
                              isOffline = (snapshot.data == ConnectionStatus.offline);
                              return isOffline ? cardOffline(area, index) : cardOnline(area, index);
                            },
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

  Widget getImageNetwork(String enlaceLogo) {
    if (enlaceLogo.split('.').last == 'svg') {
      return SvgPicture.network(enlaceLogo);
    } else {
      return CachedNetworkImage(imageUrl: enlaceLogo);
    }
  }

  Widget getImagAssets(String enlaceLogo) {
    if (enlaceLogo.split('.').last == 'svg') {
      return SvgPicture.asset('assets$enlaceLogo');
    } else {
      return Image.asset('assets$enlaceLogo');
    }
  }

  Widget cardOnline(PrepareAreaCommonEntity area, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: ConstantsApp.cardBGColor,
            border: Border.all(
              width: 5,
              color: ConstantsApp.cardBorderColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  'assets/card-header.png',
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text( '',
                          //(index + 1).toString().padLeft(2, '0'),
                          //style: const TextStyle(
                          //  fontSize: 16,
                          //  color: Color(0xffB1C7D9),
                          //),
                        ),
                        getStatus(area.status!),
                      ],
                    ),
                  ),

                  getImageNetwork(area.enlaceLogo!),

                  //text button
                  InkWell(
                    onTap: () {
                      final alert = InitPrepareExamAlert(
                        course: area.nombre!,
                        nroQuestions: area.nroPregunta.toString(),
                        onTap: () async {
                          await registerPageAnalytics('/${area.nombre!.replaceAll(RegExp(' '), '')}');
                          await areUserHistoryInsertUpdate(area);
                        },
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ver más',
                          style: TextStyle(
                            color: ConstantsApp.purpleSecondaryColor,
                            fontFamily: ConstantsApp.QSBold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: ConstantsApp.purpleSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardOffline(PrepareAreaCommonEntity area, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: ConstantsApp.cardBGColor,
            border: Border.all(
              width: 5,
              color: ConstantsApp.cardBorderColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  'assets/card-header.png',
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('',
                          //(index + 1).toString().padLeft(2, '0'),
                          //style: const TextStyle(
                          //  fontSize: 16,
                          //  color: Color(0xffB1C7D9),
                          //),
                        ),
                        getStatus(area.status!),
                      ],
                    ),
                  ),

                  getImagAssets(area.enlaceLogoOffline!),

                  //text button
                  InkWell(
                    onTap: () {
                      final alert = InitPrepareExamAlert(
                        course: area.nombre!,
                        nroQuestions: area.nroPregunta.toString(),
                        onTap: () async {
                          await areUserHistoryInsertUpdate(area);
                        },
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ver más',
                          style: TextStyle(
                            color: ConstantsApp.purpleSecondaryColor,
                            fontFamily: ConstantsApp.QSBold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: ConstantsApp.purpleSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> areUserHistoryInsertUpdate(PrepareAreaCommonEntity area) async {
    final prepareAreaCommonbox = await Hive.openBox<PrepareAreaCommonEntity>('prepareAreaCommonBox');
    final arealist = prepareAreaCommonbox.values.toList();
    //final listArea = arealist.where((element) => element.codigoPreparate == widget.prepareCode).toList();
    final indextArea = arealist.indexWhere((element) => element.codigoPreparate == widget.prepareCode && element.codigo == area.codigo);
    //var indextArea = 0;
    //for (var i = 0; i < listArea.length; i++) {
    //  if (listArea[i].codigo == area.codigo!) {
    //    indextArea = i;
    //  }
    //}

    area.status = ConstantsApp.areaProcess;
    await prepareAreaCommonbox.putAt(indextArea, area);

    //flujo para mantener historico por usuarios
    final areUserHistoryBox = await Hive.openBox<AreaUserHistoryEntity>('areaUserHistoryBox');
    final listAreaUserHistory = areUserHistoryBox.values.toList();

    final areUserHistory = listAreaUserHistory.firstWhere(
      (element) => element.areaId == area.codigo && element.userDocument == userFound.numdoc && element.generalCode == widget.generalCode && element.areaCode == widget.prepareCode,
      orElse: () {
        return AreaUserHistoryEntity(
          areaId: area.codigo,
          areaIntentos: 0,
          areaName: area.nombre,
          areaStatus: ConstantsApp.areaInitial,
          userDocument: userFound.numdoc,
          generalCode:  widget.generalCode,
          areaCode: widget.prepareCode,
          areaGeneralCode: '${area.codigo}${widget.prepareCode}${widget.generalCode}',
        );
      },
    );

    areUserHistory.areaStatus = area.status;

    listAreaUserHistory.removeWhere((element) => element.areaId == area.codigo && element.userDocument == userFound.numdoc && element.generalCode == widget.generalCode && element.areaCode == widget.prepareCode);
    listAreaUserHistory.add(areUserHistory);

    await areUserHistoryBox.clear();
    await areUserHistoryBox.addAll(listAreaUserHistory);

    Navigator.pop(context);
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ExamPage(area: area, redesign: true, generalCode: widget.generalCode,areaUserHistory: areUserHistory),
      ),
    ).then((value) async {
      await getInitData();
    });
  }
}
