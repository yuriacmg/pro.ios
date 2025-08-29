// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation, cascade_invocations, must_be_immutable, iterable_contains_unrelated_type, avoid_bool_literals_in_conditional_expressions, use_build_context_synchronously, avoid_print, unnecessary_lambdas, unrelated_type_equality_checks, sort_constructors_first

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/model/status_services_response_model.dart';
import 'package:perubeca/app/common/navigation_app/navigation_page.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/repository/util/i_util_repository.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/common/widgets/card_title_subtitle_email_history_widget.dart';
import 'package:perubeca/app/common/widgets/card_title_subtitle_email_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/error_request_server_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_beneficio_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_impedimento_entity.dart';
import 'package:perubeca/app/database/entities/modalidad_requisito_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_no_data_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/email_bloc/email_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/respuesta_procesada_response_model.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/find_page.dart';
import 'package:perubeca/app/modules/scholarship/page/foreign/foreign_page.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';

import 'package:perubeca/app/utils/methods.dart';

class SendModelDetail {
  ModalidadEntity data;
  bool isLocal;
  bool isSync;
  int consultaId;

  SendModelDetail({
    required this.data,
    required this.isLocal,
    required this.isSync,
    required this.consultaId,
  });
}

class PageThree extends StatefulWidget {
  PageThree({this.history, this.isForeign, this.isLocal, this.pageController, super.key});
  HistoryEntity? history;
  bool? isForeign;
  bool? isLocal;
  PageController? pageController;

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final internetConnection = CheckInternetConnection();
  final localRepository = getItApp.get<ILocalDataSecureDbRepository>();
  //para el resto de la pagina
  bool isVisible = true;
  bool isLoading = false;
  List<ModalidadEntity> list = [];
  List<RespuestaProcesadaEntity> listViewMod = [];
  DataReniecEntity user = DataReniecEntity(
    apellidoMaterno: '',
    apellidoPaterno: '',
    fechaNacimiento: '',
    nombres: '',
    nombreCompleto: '',
    sexo: '',
    numDocumento: '',
  );

  OverlayEntry? _overlayEntry;
  bool thereIsData = false;
  String messageNoData = '';
  String userName = '';

  bool isOffline = false;

  int nroConsultaCiudadana = 0;

  @override
  void initState() {
    getDataInitial();
    internetConnection.internetStatus().listen((status) {
      if (mounted) {
        setState(() {
          isOffline = (status == ConnectionStatus.offline);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    disposeData();
    super.dispose();
  }

  Future<void> disposeData() async {
    await localRepository.setIsLocal('');
  }

  Future<void> verifyStatusServices() async{
    final repository = getItApp.get<IUtilRepository>();
    final response = await repository.getStatusServices(1);
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
            Navigator.pop(context);
          },);
        },
      );
    } else{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> initModalSendEmail() async {
    Widget alert;
    final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');
    final users = reniecDatabox.values.toList();
    user = users.first;

    if (widget.history != null) {
      final historyResponse = RespuestaProcesadaResponseModel.fromJson(jsonDecode(widget.history!.response!) as Map<String, dynamic>);
      nroConsultaCiudadana = historyResponse.value!.consultaId!;
      alert = CardTitleSubtitleEmailHistoryWidget(
        title: 'Déjanos tu correo electrónico',
        subtitle: 'Para enviarte toda la información sobre \nlos beneficios a los que puedes \npostular.',
        url: '',
        dni: widget.history!.numDocument!,
        parametro: nroConsultaCiudadana,
        ontap: () {},
        isModal: true,
        formKey: formKey,
      );
    } else {
      alert = CardTitleSubtitleEmailWidget(
        title: 'Déjanos tu correo electrónico',
        subtitle: 'Para enviarte toda la información sobre \nlos beneficios a los que puedes \npostular.',
        url: '',
        dni: user.numDocumento!,
        ontap: () {},
        isModal: true,
        formKey: formKey1,
      );
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) => print(value));
  }

  Future<void> getDataInitial() async {
    setState(() {
      isLoading = true;
    });
    final isLocal = await localRepository.getIsLocal();
    widget.isLocal = widget.isLocal ?? (isLocal == 'true');
    final modalidadbox = await Hive.openBox<ModalidadEntity>('modalidadBox');
    final beneficiobox = await Hive.openBox<ModalidadBeneficioEntity>('beneficioBox');
    final requisitobox = await Hive.openBox<ModalidadRequisitoEntity>('requisitoBox');
    final impedimentobox = await Hive.openBox<ModalidadImpedimentoEntity>('impedimentoBox');
    final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');
    final respuestaProcesadBox = await Hive.openBox<RespuestaProcesadaEntity>('respuestaProcesadaBox');
    final respuestaProcesadNoDataBox = await Hive.openBox<RespuestaProcesadaNoDataEntity>('respuestaProcesadaNoDataBox');

    final users = reniecDatabox.values.toList();
    user = users.first;
    if (widget.history != null) {
      user.numDocumento = widget.history!.numDocument;
      final historyResponse = RespuestaProcesadaResponseModel.fromJson(jsonDecode(widget.history!.response!) as Map<String, dynamic>);
      nroConsultaCiudadana = historyResponse.value!.consultaId!;
    }
    if (widget.isForeign != null && widget.isForeign!) {
      userName = user.nombreCompleto!;
    } else {
      try {
        userName = '${user.nombres!.split(' ').first} ${user.apellidoPaterno!}';
      } catch (e) {
        userName = user.nombreCompleto!;
      }
    }

    list = modalidadbox.values.toList();
    //para ver las modalidades que corresponden
    listViewMod = respuestaProcesadBox.values.toList();
    final litView = listViewMod.map((e) => e.modId!).toList();
    list = list.where((element) => litView.contains(element.modId) && element.modId != 0).toList();

    nroConsultaCiudadana = listViewMod.isNotEmpty ? listViewMod.first.consultaId! : 0;

    thereIsData = respuestaProcesadNoDataBox.values.isNotEmpty ? respuestaProcesadNoDataBox.values.first.rptaBool! : false;
    messageNoData = respuestaProcesadNoDataBox.values.isNotEmpty ? respuestaProcesadNoDataBox.values.first.resultado! : '';

    for (final e in list) {
      e.listBeneficios = beneficiobox.values.where((element) => element.modId == e.modId).toList();
      e.listRequisitos = requisitobox.values.where((element) => element.modId == e.modId).toList();
      e.listImpedimentos = impedimentobox.values.where((element) => element.modId == e.modId).toList();
    }

    setState(() {
      isLoading = false;
    });

    if (!isOffline && list.isNotEmpty && (!widget.isLocal! || (widget.history != null && widget.history!.isSync!))) {
      await initModalSendEmail();
    }
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

  void errorMessage(ErrorResponseModel error) {
    context.read<EmailBloc>().initialState();
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
    final alert = AlertImageMessageGenericWidget(
      title: 'NO PUDIMOS ENVIAR EL CORREO',
      message: error.value.first.message,
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
    return WillPopScope(
      onWillPop: () async {
        if (widget.isForeign! && widget.history == null) {
          final respuestaProcesadNoDataBox = await Hive.openBox<RespuestaProcesadaNoDataEntity>('respuestaProcesadaNoDataBox');
          await respuestaProcesadNoDataBox.clear();
          widget.history = null;
          await localRepository.setIsLocal('');
          Navigator.pop(context);
          // Navigator.pop(context);
          return false;
        } else {
          if (widget.pageController != null) {
            widget.pageController!.jumpToPage(0);
          }
          return true;
        }
      },
      child: BackgroundCommon(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      BackAppBarCommon(
                        title: (widget.isForeign != null && widget.isForeign!) ? 'Beca para extranjeros' : 'Becas y créditos para peruanos',
                        subtitle: '',
                        backString: 'Regresar al menú',
                        ontap: () async {
                          final respuestaProcesadNoDataBox =
                              await Hive.openBox<RespuestaProcesadaNoDataEntity>('respuestaProcesadaNoDataBox');
                          await respuestaProcesadNoDataBox.clear();
                          widget.history = null;
                          await localRepository.setIsLocal('');
                          if (widget.pageController != null) {
                            widget.pageController!.jumpToPage(0);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      if (isLoading)
                        SizedBox(
                          height: constraints.maxWidth,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        SizedBox(
                          width:
                              (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              if (widget.history != null)
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        color: ConstantsApp.purplePrimaryColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(
                                              0,
                                              3,
                                            ), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'Consulta del ${widget.history!.dateSend!}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: ConstantsApp.OPMedium,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                const SizedBox.shrink(),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  userName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: ConstantsApp.OPBold,
                                    fontWeight: FontWeight.bold,
                                    color: ConstantsApp.textBluePrimary,
                                  ),
                                ),
                              ),
                              if (list.isNotEmpty)
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        'Según la información que ingresaste, estas son las mejores opciones a las que puedes postular:',
                                        style: TextStyle(
                                          fontFamily: ConstantsApp.OPRegular,
                                          fontSize: 16,
                                          color: ConstantsApp.colorBlackPrimary,
                                        ),
                                        textAlign: TextAlign.center,
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
                                      itemCount: list.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final model = list[index];
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
                                                      if (isOffline)
                                                        Image.asset(
                                                          'assets/scholarship/find${model.enlaceLogOffline}',
                                                          height: 70,
                                                        )
                                                      else
                                                        CachedNetworkImage(
                                                          imageUrl: model.enlaceLog!,
                                                          height: 70,
                                                          errorWidget: (
                                                            context,
                                                            url,
                                                            error,
                                                          ) =>
                                                              const Icon(Icons.error),
                                                        ),
                                                      //text button
                                                      InkWell(
                                                        onTap: () {
                                                          registerPageAnalytics('/DetailScholarshipSelected');
                                                          model.beneficios = user.numDocumento;

                                                          final send = SendModelDetail(
                                                            data: model,
                                                            isLocal: widget.isLocal!,
                                                            isSync: widget.history != null ? widget.history!.isSync! : true,
                                                            consultaId: nroConsultaCiudadana,
                                                          );
                                                          Navigator.pushNamed(
                                                            context,
                                                            RoutesApp.scholarshipPageThreeDetail,
                                                            arguments: send,
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
                                      },
                                    ),
                                    if (widget.history != null)
                                      Visibility(
                                        visible: !widget.isLocal! || (widget.history != null && widget.history!.isSync!),
                                        child: CardTitleSubtitleEmailHistoryWidget(
                                          title: 'Déjanos tu correo electrónico',
                                          subtitle: 'Para enviarte toda la información sobre \nlos beneficios a los que puedes \npostular.',
                                          url: '',
                                          dni: user.numDocumento!,
                                          parametro: nroConsultaCiudadana,
                                          ontap: () {},
                                          formKey: formKey2,
                                        ),
                                      )
                                    else
                                      Visibility(
                                        visible: !widget.isLocal!,
                                        child: CardTitleSubtitleEmailWidget(
                                          title: 'Déjanos tu correo electrónico',
                                          subtitle: 'Para enviarte toda la información sobre \nlos beneficios a los que puedes \npostular.',
                                          url: '',
                                          dni: user.numDocumento!,
                                          ontap: () {},
                                          formKey: formKey3,
                                        ),
                                      ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        'Estos son los resultados, según los datos ingresados:',
                                        style: TextStyle(
                                          fontFamily: ConstantsApp.OPRegular,
                                          fontSize: 16,
                                          color: ConstantsApp.colorBlackPrimary,
                                        ),
                                        // textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                    Image.asset(
                                      ConstantsApp.noData,
                                      scale: 1.9,
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            right: 10,
                                            bottom: 10,
                                          ),
                                          child: Icon(
                                            Icons.warning_rounded,
                                            color: Color(0xffAD0011),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Html(
                                              data: messageNoData,
                                              onLinkTap: (url, attributes, element) {
                                                if (kIsWeb) {
                                                  launchUrlAPP(url!);
                                                } else {
                                                  Navigator.pushNamed(
                                                    context,
                                                    RoutesApp.webview,
                                                    arguments: removeLastCharacterIfCharacter(url!, '/'),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      child: Text(
                                        'Recuerda que debes cumplir con  los requisitos según las bases del concurso.',
                                        style: TextStyle(
                                          fontFamily: ConstantsApp.OPRegular,
                                          fontSize: 16,
                                          color: ConstantsApp.colorBlackPrimary,
                                        ),
                                        // textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),

                              //botton
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BottonCenterWidget(
                                    sized: 220,
                                    ontap: () {
                                      if (widget.history != null) {
                                        widget.history = null;
                                        Navigator.pop(context);
                                      } else {
                                        //nueva consulta
                                        widget.history = null;
                                        Navigator.pop(context);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => NavigationPage(
                                              selectedIndex: 1,
                                              // scholarshipSelectedIndex: 1,
                                            ),
                                          ),
                                          (route) => true,
                                        );

                                        if (widget.isForeign == null || !widget.isForeign!) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => FindCreditPage(),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => ForeignPage(),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    text: 'Hacer nueva consulta',
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
              BlocConsumer<EmailBloc, EmailState>(
                listener: (context, state) {
                  // Puedes agregar lógica adicional cuando el estado cambie si es necesario
                  if (state is EmailSendCompleteState) {
                    //hideLoadingOverlay();
                    ////FocusScope.of(context).unfocus();
                    //context.read<EmailBloc>().initialState();
                  }
                },
                builder: (context, state) {
                  if (state is ErrorEmailState) {
                    //error al obtener los resultados del api de reniec
                    // _overlayEntry = null;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      hideLoadingOverlay();
                      errorMessage(state.error);
                    });
                  }

                  if (state is EmailSendCompleteState) {
                    //data obtenida correctamente
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      //successMessage();
                      hideLoadingOverlay();
                      context.read<EmailBloc>().initialState();
                      final alert = AlertImageMessageGenericWidget(
                        title: 'CORREO ENVIADO',
                        message: 'Se envió la información al correo \ningresado.',
                        consultaId: listViewMod.first.consultaId!,
                        onTap: () {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                        bottonTitle: 'Entendido',
                        image: 'assets/scholarship/Listo.png',
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      ).then((value) {
                        formKey.currentState != null ? formKey.currentState!.reset() : print('');
                        formKey1.currentState != null ? formKey1.currentState!.reset() : print('');
                        formKey2.currentState != null ? formKey2.currentState!.reset() : print('');
                        formKey3.currentState != null ? formKey3.currentState!.reset() : print('');
                        setState(() {});
                      });
                    });
                  }

                  if (state is EmailLoadingState) {
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
    );
  }
}
