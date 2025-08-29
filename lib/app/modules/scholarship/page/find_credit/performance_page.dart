// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, inference_failure_on_function_invocation, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/model/status_services_response_model.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/botton_right_outline_widget.dart';
import 'package:perubeca/app/common/widgets/botton_right_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/error_request_server_widget.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/consulta_siage_entity.dart';
import 'package:perubeca/app/database/entities/reniec_performance_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/scholarship_bloc/scholarship_bloc.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class PerformanceFindPage extends StatefulWidget {
  PerformanceFindPage({required this.pageController, super.key});
  PageController pageController;
  // PageController fatherPageController;

  @override
  State<PerformanceFindPage> createState() => _PerformanceFindPageState();
}

class _PerformanceFindPageState extends State<PerformanceFindPage> {
  ReniecPerformanceEntity user = ReniecPerformanceEntity(
    apeMaterno: '',
    apePaterno: '',
    resultadoSiagie: '',
    fecNacimiento: '',
    nombre: '',
    nombreCompleto: '',
    numdoc: '',
    sexo: '',
    rptaSiagieBool: false,
    notara: '',
  );

  List<ConsultaSiageEntity> listdetail = [];

  OverlayEntry? _overlayEntry;

  String userName = '';

  @override
  void initState() {
    getDataInitial();
    super.initState();
  }

  Future<void> getDataInitial() async {
    final reniecDatabox = await Hive.openBox<ReniecPerformanceEntity>('dataReniecPerformanceBox');
    user = reniecDatabox.values.first;
    userName = '${user.nombre!.split(' ').first} ${user.apePaterno!}';
    final siagebox = await Hive.openBox<ConsultaSiageEntity>('siageBox');
    listdetail = siagebox.values.toList();
    setState(() {});
  }

  void showLoadingOverlay() {
    // Crear el OverlayEntry para mostrar el CircularProgressIndicator
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Fondo oscuro semi-transparente
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // CircularProgressIndicator centrado
            CustomLoader(),
          ],
        );
      },
    );
    // Agregar el OverlayEntry al Overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoadingOverlay() {
    // Remover el OverlayEntry del Overlay
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void errorMessage(ErrorResponseModel error, bool isSpecial) {
    context.read<ScholarshipBloc>().initialState();
    if (error.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
      // no hay internet
      UtilCommon().noInternetNoDataModal(
        context: context,
        ontap: () {
          Navigator.pop(context);
        },
      );
      return;
    }

    if (error.statusCode! >= getAppStatusCodeError(AppStatusCode.SERVER) && error.statusCode! < 900) {
      //error de servidor
      UtilCommon().erroServerModal(context: context);
      return;
    }

    final messages = error.value.first.message;
    final alert = AlertImageMessageGenericWidget(
      title: isSpecial ? error.value.first.title :  'NO PUDIMOS VALIDAR TU IDENTIDAD',
      message: messages,
      consultaId: 0,
      onTap: () {
        Navigator.pop(context);
        setState(() {});
      },
      bottonTitle: 'Entendido',
      image: 'assets/alert_app.svg',
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackAppBarCommon(
          title: 'Consulta tu rendimiento académico',
          subtitle: '',
          backString: 'Regresar al menú',
          ontap: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10, top: 10),
                            child: GenericStylesApp().title(text: userName),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 20,
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: ConstantsApp.OPRegular,
                                  fontSize: 16,
                                  color: ConstantsApp.colorBlackPrimary,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Según la información contenida en los Certificados de Estudios remitidos por el Ministerio de Educación (SIAGIE), este es tu ',
                                  ),
                                  TextSpan(
                                    text: ' rendimiento académico:',
                                    style: TextStyle(
                                      fontFamily: ConstantsApp.OPSemiBold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //card
                          //
                          if (listdetail.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.transparent,
                              child: Material(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                //elevation: 0,
                                borderRadius: BorderRadius.circular(10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: ConstantsApp.cardBGColor,
                                    border: Border.all(
                                      width: 5,
                                      color: ConstantsApp.cardBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: -10,
                                        top: 0,
                                        child: Image.asset('assets/card-header.png'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //detail
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: listdetail.length,
                                              itemBuilder: (context, index) {
                                                final model = listdetail[index];
                                                //return Text(model.condicion!);
                                                return DetailPerformance(text1: model.grado!, text2: model.condicion!);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            Image.asset(
                              ConstantsApp.noData,
                              scale: 1.9,
                            ),

                          //message
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                                  child: Icon(
                                    (user.rptaSiagieBool!) ? Icons.check_circle : Icons.warning_rounded,
                                    color: (user.rptaSiagieBool!) ? const Color(0xff005C1D) : const Color(0xffAD0011),
                                  ),
                                ),
                                Expanded(child: Html(data: user.resultadoSiagie)),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                            child: Html(data: user.notara),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BottonRightWidget(
                                  isEnabled: true,
                                  ontap: verifyStatusServices,
                                  text: 'Quiero encontrar mi beca \no crédito educativo',
                                  //icon: Icons.navigate_next,
                                  size: 250,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BottonRightOutlineWidget(
                                  isEnabled: true,
                                  ontap: () {
                                    widget.pageController.jumpToPage(0);
                                  },
                                  text: 'Hacer nueva consulta',
                                  //icon: Icons.navigate_next,
                                  size: 250,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                BlocConsumer<ScholarshipBloc, ScholarshipState>(
                  listener: (context, state) {
                    // Puedes agregar lógica adicional cuando el estado cambie si es necesario
                  },
                  builder: (context, state) {
                    if (state is ErrorState) {
                      //error al obtener los resultados del api de reniec
                      // _overlayEntry = null;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        hideLoadingOverlay();
                        errorMessage(state.error, state.isSpecial);
                      });
                    }

                    if (state is ScholarshipLoadCompleteState) {
                      //data obtenida correctamente
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        //successMessage();
                        hideLoadingOverlay();
                        context.read<ScholarshipBloc>().initialState();
                        //movernos a la pagina de find scholarchip
                        registerPageAnalytics('/FindCredit');
                        widget.pageController.jumpToPage(1);
                      });
                    }

                    if (state is ScholarshipLoadingState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_overlayEntry == null) {
                          showLoadingOverlay();
                        }
                      });
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

Future<void> verifyStatusServices() async{
  showLoadingOverlay();
    final repository = getItApp.get<IUtilRepository>();
    final response = await repository.getStatusServices(1);
    hideLoadingOverlay();
    if(!response.status){
      // no esta el servicio activo
      // mostrar el mensaje que corresponda
    }
    final data = response.data as StatusServicesResponseModel;
    final isActive = data.value.servicios.any((servicio) => !servicio.rptaBool);

  if (isActive) {
    // se crea el mensaje a enviar
    final elements = data.value.servicios.where((element) => element.rptaBool == false).toList();
  
    final message = elements.first.mensaje;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorRequestServerWidget(message: message, ontap: (){
          Navigator.pop(context);
        },);
      },
    );
  } else{
    await context.read<ScholarshipBloc>().getUserReniec();
  }

  }
  
}

class DetailPerformance extends StatelessWidget {
  DetailPerformance({
    required this.text1,
    required this.text2,
    super.key,
  });
  String text1;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Html(data: text1)),
        Expanded(
          child: Html(data: text2),
        ),
      ],
    );
  }
}
