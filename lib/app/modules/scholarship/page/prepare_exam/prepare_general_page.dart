// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, omit_local_variable_types, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation, cascade_invocations, use_colored_box, use_build_context_synchronously, sdk_version_since

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/widgets/alert_no_login.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common_login.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/prepare/prepare_area_entity.dart';
import 'package:perubeca/app/database/entities/profile_entity.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';
import 'package:perubeca/app/modules/login/page/login_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/prepare_exam_page.dart';
import 'package:perubeca/app/modules/scholarship/page/prepare_exam/result_reniec_exam_page.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_prepare_scholarship_offline_widget.dart';
import 'package:perubeca/app/modules/scholarship/widget/card_prepare_scholarship_widget.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';

class PrepareGeneralPage extends StatefulWidget {
  PrepareGeneralPage({required this.pageController, super.key});
  PageController pageController;

  @override
  State<PrepareGeneralPage> createState() => _PrepareGeneralPageState();
}

class _PrepareGeneralPageState extends State<PrepareGeneralPage>
    with SingleTickerProviderStateMixin {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  ScrollController scrollController = ScrollController();
  List<PrepareAreaEntity> areas = [];
  String fullName = '';

  @override
  void initState() {
    super.initState();
    getDataInitial();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getDataInitial() async {
    final prepareAreabox = await Hive.openBox<PrepareAreaEntity>('prepareAreaBox');
    areas = prepareAreabox.values.toList();
    final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
    if(profilebox.values.isNotEmpty){
      final  profile = profilebox.values.first;
      fullName = '${profile.vNombres!.split(' ').first} ${profile.vApellidos!}';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: Column(
        children: [
          BackAppBarCommonLogin(
            title: 'Prepárate',
            subtitle: '',
            backString: 'Regresar al menú',
            ontap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const ScrollPhysics(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: (constraints.maxWidth > 1000)
                            ? MediaQuery.of(context).size.width * 0.5
                            : MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            BlocListener<LoginBloc, LoginState>(
                              listener: (context, state) async {
                                 final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
                                if(profilebox.values.isNotEmpty){
                                  final  profile = profilebox.values.first;
                                  fullName = '${profile.vNombres!.split(' ').first} ${profile.vApellidos!}';
                                  setState(() { });
                                }else{
                                  fullName = '';
                                  setState(() { });
                                }
                                
                              },
                              child: Container(),
                            ),

                            Visibility(
                              visible: fullName.isNotEmpty,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: GenericStylesApp().title(
                                  text: fullName,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 20,
                                top: 10,
                              ),
                              child: GenericStylesApp().messagePage(
                                text:
                                    'Prepárate según tu grado para rendir tu examen de admisión',
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: areas.length,
                                      itemBuilder: (context, index) {
                                        final model = areas[index];
                                        return (snapshot.data ==
                                                ConnectionStatus.offline)
                                            ? CardPrepareScholarshipOfflineWidget(
                                                title: model.nombre!,
                                                icon: model.enlaceLogoOffline!,
                                                constraints: constraints,
                                                visiblePanel: index == 3,
                                                textButton: 'Empezar',
                                                onTap: () async {
                                                  if(index < 3){
                                                      //validar si tiene sesion activa
                                                      final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
                                                      if(profilebox.values.isEmpty){
                                                        final confirmDialog = AlertNoLoginDialog(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                            Navigator.push(context, MaterialPageRoute<void>( builder: (BuildContext context) => const LoginPage()));
                                                          },
                                                          );
                                                        await showDialog(
                                                          barrierColor: Colors.black45,
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => confirmDialog,
                                                        );
                                                      }else{
                                                        await context.read<LoginBloc>().activatePrepareUserLogin();
                                                        await Navigator.push(context, MaterialPageRoute<void>( builder: (BuildContext context) => ResultRecienExamPage(pageController: widget.pageController, areaCode: model.codigo!)));
                                                      }
                                                   
                                                  }else{
                                                    bool recursiveNavigation = true;
                                                    while (recursiveNavigation) {
                                                      final response = await Navigator.push(context, MaterialPageRoute<bool?>(builder: (BuildContext context) => PrepareExamPage(areaCode: model.codigo!)));

                                                      if (response != null && response) {
                                                        recursiveNavigation = true;
                                                      } else {
                                                        recursiveNavigation = false;
                                                      }
                                                    }
                                                  }
                                                  
                                                },
                                              )
                                            : CardPrepareScholarshipWidget(
                                                title: model.nombre!,
                                                icon: model.enlaceLogo!,
                                                constraints: constraints,
                                                visiblePanel: index == 3,
                                                textButton: 'Empezar',
                                                onTap: () async {
                                                   if(index < 3){
                                                      //validar si tiene sesion activa
                                                      final profilebox = await Hive.openBox<ProfileEntity>('profileBox');
                                                      if(profilebox.values.isEmpty){
                                                        final confirmDialog = AlertNoLoginDialog(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                            Navigator.push(context, MaterialPageRoute<void>( builder: (BuildContext context) => const LoginPage()));
                                                          },
                                                          );
                                                        await showDialog(
                                                          barrierColor: Colors.black45,
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) => confirmDialog,
                                                        );
                                                      }else{
                                                        await context.read<LoginBloc>().activatePrepareUserLogin();
                                                        await Navigator.push(context, MaterialPageRoute<void>( builder: (BuildContext context) => ResultRecienExamPage(pageController: widget.pageController, areaCode: model.codigo!)));
                                                      }
                                                   
                                                  }else{
                                                    bool recursiveNavigation = true;
                                                    while (recursiveNavigation) {
                                                      final response = await Navigator.push(context, MaterialPageRoute<bool?>(builder: (BuildContext context) => PrepareExamPage(areaCode: model.codigo!)));

                                                      if (response != null && response) {
                                                        recursiveNavigation = true;
                                                      } else {
                                                        recursiveNavigation = false;
                                                      }
                                                    }
                                                  }
                                                },
                                              );
                                      },
                                    ),
                                    const SizedBox(height: 20),
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
          ),
        ],
      ),
    );
  }
}
