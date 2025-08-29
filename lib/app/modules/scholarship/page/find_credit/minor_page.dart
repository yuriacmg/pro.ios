// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, omit_local_variable_types, avoid_bool_literals_in_conditional_expressions, inference_failure_on_function_invocation, cascade_invocations, use_colored_box

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_centerMinor_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/database/entities/apoderado_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/scholarship_bloc/scholarship_bloc.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class MinorPage extends StatefulWidget {
  MinorPage({
    required this.pageController,
    super.key,
  });
  PageController pageController;

  @override
  State<MinorPage> createState() => _MinorPageState();
}

class _MinorPageState extends State<MinorPage> with SingleTickerProviderStateMixin {
  final CheckInternetConnection internetConnection = CheckInternetConnection();
  ScrollController scrollController = ScrollController();

  OverlayEntry? _overlayEntry;

  List<ApoderadoEntity> representants = [];

  String selected = '';
  String responseTutor = '';

  @override
  void initState() {
    getInitData();
    super.initState();
  }

  Future<void> getInitData() async {
    final boxApoderado = await Hive.openBox<ApoderadoEntity>('boxApoderado');
    representants = boxApoderado.values.toList();
    responseTutor = representants.first.respuesta!;
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void showLoadingOverlay() {
    // Crear el OverlayEntry para mostrar el CircularProgressIndicator
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
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

  void errorMessage(ErrorResponseModel error) {
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
    const String messages = 'La opción seleccionada no coincide con la información consultada en RENIEC.';

    final alert = AlertImageMessageGenericWidget(
      title: 'Lo sentimos',
      message: messages,
      consultaId: 0,
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {});
      },
      onTapClose: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      bottonTitle: 'Volver al inicio',
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
    return BackgroundCommon(
      child: Column(
        children: [
          BackAppBarCommon(
            title: 'Becas y créditos educativos',
            subtitle: '',
            backString: 'Regresar al menú',
            ontap: () {
              // widget.pageController.jumpToPage(0);
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
                        width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 10,
                                top: 20,
                              ),
                              child: GenericStylesApp().title(
                                text: 'Validación de datos \npersonales',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 20,
                              ),
                              child: GenericStylesApp().messagePage(
                                text: 'Responde la siguiente pregunta para la verificación de tus datos.',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10, left: 10),
                              child: Text(
                                'Selecciona el nombre de tu PADRE, MADRE o APODERADO:',
                                style: TextStyle(
                                  fontFamily: ConstantsApp.OPSemiBold,
                                  fontSize: 16,
                                  color: ConstantsApp.textBlackQuaternary,
                                ),
                              ),
                            ),
                            // RadioButtonListRepresentantMinor(alternatives: representants)
                            ListView.builder(
                              itemCount: representants.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final alternative = representants[index];
                                return ListTile(
                                  contentPadding: const EdgeInsets.only(bottom: 7),
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 40,
                                        padding: const EdgeInsets.only(right: 10, left: 20),
                                        child: Transform.scale(
                                          scale: 1,
                                          child: Radio(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            activeColor: ConstantsApp.purpleTerctiaryColor,
                                            value: alternative.name,
                                            groupValue: selected,
                                            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                                            onChanged: (value) {
                                              setState(() {
                                                selected = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selected = alternative.name!;
                                            });
                                          },
                                          child: Text(
                                            alternative.name!,
                                            style: const TextStyle(
                                              fontFamily: ConstantsApp.OPSemiBold,
                                              fontSize: 16,
                                              color: ConstantsApp.textBlackQuaternary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: BottonCenterMinorWidget(
                                ontap: selected.isNotEmpty
                                    ? () {
                                        //llamamos a la funcion validar
                                        if (selected.toUpperCase() == responseTutor.toUpperCase()) {
                                          context.read<ScholarshipBloc>().getUserReniecIsMinorTutorValid();
                                        } else {
                                          final error = ErrorResponseModel(
                                            hasSucceeded: false,
                                            statusCode: 400,
                                            value: [
                                              ValueError(
                                                errorCode: 400,
                                                message: 'La opción seleccionada no coincide con la información consultada en RENIEC.',
                                              ),
                                            ],
                                          );
                                          errorMessage(error);
                                        }
                                        //widget.pageController.jumpToPage(4);
                                      }
                                    : () {},
                                text: 'Validar',
                                color: selected.isNotEmpty ? null : ConstantsApp.colorBlackSecondary,
                              ),
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
                          errorMessage(state.error);
                        });
                      }

                      // if (state is ScholarshipMinorValidLoadCompleteState) {
                      //   //data obtenida correctamente
                      //   WidgetsBinding.instance.addPostFrameCallback((_) {
                      //     //successMessage();
                      //     hideLoadingOverlay();
                      //     context.read<ScholarshipBloc>().initialState();
                      //     widget.pageController.jumpToPage(4);
                      //   });
                      // }

                      if (state is ReniecPerformanceLoadCompleteState) {
                        //data obtenida correctamente
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          //successMessage();
                          hideLoadingOverlay();
                          context.read<ScholarshipBloc>().initialState();
                          //movernos a la pagina de performance
                          registerPageAnalytics('/Performance');
                          widget.pageController.jumpToPage(4);
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
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 20),
          //   child: BottonCenterWidget(
          //     ontap: selected.isNotEmpty
          //         ? () {}
          //         : () {
          //             //llamamos a la funcion validar
          //           },
          //     text: 'Validar',
          //     color: selected.isNotEmpty ? null : ConstantsApp.colorBlackSecondary,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class RadioButtonListRepresentantMinor extends StatefulWidget {
  RadioButtonListRepresentantMinor({required this.alternatives, this.selected, super.key});
  List<String> alternatives;
  String? selected;

  @override
  State<RadioButtonListRepresentantMinor> createState() => _RadioButtonListRepresentantMinorState();
}

class _RadioButtonListRepresentantMinorState extends State<RadioButtonListRepresentantMinor> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.alternatives.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final alternative = widget.alternatives[index];
        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 7),
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25,
                width: 40,
                padding: const EdgeInsets.only(right: 10, left: 20),
                child: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: ConstantsApp.purpleTerctiaryColor,
                    value: alternative,
                    groupValue: widget.selected,
                    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                    onChanged: (value) {
                      setState(() {
                        widget.selected = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  alternative,
                  style: const TextStyle(
                    fontFamily: ConstantsApp.OPSemiBold,
                    fontSize: 16,
                    color: ConstantsApp.textBlackQuaternary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
