// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, library_private_types_in_public_api, cascade_invocations, inference_failure_on_function_invocation, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/repository/local_secure_db/i_local_data_secure_db_repository.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/expansion_tile_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/scholarship/bloc/download_file_bloc/download_file_bloc.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
import 'package:perubeca/app/modules/scholarship/widget/enlace_relacionado.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PageThreeDetail extends StatefulWidget {
  PageThreeDetail({required this.send, super.key});
  SendModelDetail send;

  @override
  State<PageThreeDetail> createState() => _PageThreeDetailState();
}

class _PageThreeDetailState extends State<PageThreeDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final internetConnection = CheckInternetConnection();
  bool isOffline = false;
  bool isOpen = false;
  bool fisrtTime = true;
  final fondoApp = kIsWeb ? ConstantsApp.fondoAppWeb : ConstantsApp.fondoApp;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    internetConnection.internetStatus().listen((status) {
      setState(() {
        isOffline = (status == ConnectionStatus.offline);
      });
    });

    super.initState();
  }

  void showAndHide() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(fondoApp),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        ConstantsApp.boxRadialDecoratioBottonBorderPrimary,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: -43,
                          bottom: -5,
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -50,
                          top: -7,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Volver',
                                  style: TextStyle(
                                    fontFamily: ConstantsApp.OPMedium,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: (constraints.maxWidth > 1000)
                            ? MediaQuery.of(context).size.width * 0.5
                            : MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            //childrens
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: isOffline
                                  ? Image.asset(
                                      'assets/scholarship/find${widget.send.data.enlaceLogOffline}',
                                      width: (constraints.maxWidth > 1000)
                                          ? MediaQuery.of(context).size.width *
                                              0.1
                                          : MediaQuery.of(context).size.width *
                                              0.4,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: widget.send.data.enlaceLog!,
                                      width: (constraints.maxWidth > 1000)
                                          ? MediaQuery.of(context).size.width *
                                              0.1
                                          : MediaQuery.of(context).size.width *
                                              0.4,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                            ),
                            Visibility(
                              visible: !widget.send.isLocal &&
                                  widget.send.data.publicada!,
                              child: Container(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  color: Colors.transparent,
                                  child: Material(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 4,
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
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Image.asset(
                                              'assets/card-header.png',
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Divider(
                                                  color: Colors.transparent,
                                                ),
                                                const Text(
                                                  'Próximo concurso',
                                                  style: TextStyle(
                                                    color: ConstantsApp
                                                        .textBlackQuaternary,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        ConstantsApp.OPBold,
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.transparent,
                                                ),
                                                const Divider(
                                                  color: Colors.transparent,
                                                ),
                                                Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (kIsWeb) {
                                                        _launchUrl(
                                                          widget.send.data
                                                              .enlaceInform!,
                                                        );
                                                      } else {
                                                        Navigator.pushNamed(
                                                          context,
                                                          RoutesApp.webview,
                                                          arguments: widget
                                                              .send
                                                              .data
                                                              .enlaceInform,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 185,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                            5,
                                                          ),
                                                          bottomLeft:
                                                              Radius.circular(
                                                            5,
                                                          ),
                                                          bottomRight:
                                                              Radius.circular(
                                                            5,
                                                          ),
                                                          topRight:
                                                              Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        border: Border.all(
                                                          color: ConstantsApp
                                                              .purpleTerctiaryColor,
                                                          width: 2,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                              0.6,
                                                            ),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                              0,
                                                              2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'Más información',
                                                            style: TextStyle(
                                                              color: ConstantsApp
                                                                  .purpleTerctiaryColor,
                                                              fontFamily:
                                                                  ConstantsApp
                                                                      .OPSemiBold,
                                                              // fontWeight: FontWeight.w500,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Image.asset(
                                                            'assets/scholarship/detail/launch.png',
                                                            scale: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.transparent,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //Beneficios
                            Visibility(
                              visible:
                                  widget.send.data.listBeneficios!.isNotEmpty,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: ConstantsApp.cardBorderColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTileWidget(
                                  title: 'Beneficios *',
                                  fisrtTime: fisrtTime,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .send.data.listBeneficios!.length,
                                        itemBuilder: (context, index) {
                                          final model = widget
                                              .send.data.listBeneficios![index];
                                          return TextDetail(
                                            text: model.descripc!,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //Requisitos
                            Visibility(
                              visible:
                                  widget.send.data.listRequisitos!.isNotEmpty,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: ConstantsApp.cardBorderColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTileWidget(
                                  title: 'Requisitos *',
                                  fisrtTime: fisrtTime,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .send.data.listRequisitos!.length,
                                        itemBuilder: (context, index) {
                                          final model = widget
                                              .send.data.listRequisitos![index];
                                          return TextDetail(
                                            text: model.descripc!,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //Documentos clave
                            Visibility(
                              visible: widget
                                  .send.data.listDocumentoClave!.isNotEmpty,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: ConstantsApp.cardBorderColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTileWidget(
                                  title: 'Documentos clave *',
                                  fisrtTime: fisrtTime,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget.send.data
                                            .listDocumentoClave!.length,
                                        itemBuilder: (context, index) {
                                          final model = widget.send.data
                                              .listDocumentoClave![index];
                                          return TextDetail(
                                            text: model.descripc!,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //impedimentos
                            Visibility(
                              visible:
                                  widget.send.data.listImpedimentos!.isNotEmpty,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: ConstantsApp.cardBorderColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTileWidget(
                                  title: 'Impedimentos *',
                                  fisrtTime: fisrtTime,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .send.data.listImpedimentos!.length,
                                        itemBuilder: (context, index) {
                                          final model = widget.send.data
                                              .listImpedimentos![index];
                                          return TextDetail(
                                            text: model.descripc!,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !widget.send.isLocal,
                              child: InkWell(
                                onTap: () {
                                  if (kIsWeb) {
                                    _launchUrl(widget.send.data.enlaceMod!);
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesApp.webview,
                                      arguments: widget.send.data.enlaceMod,
                                    );
                                  }
                                },
                                child: Container(
                                  // height: 75,
                                  width: constraints.maxWidth > 1000
                                      ? MediaQuery.of(context).size.width * 0.25
                                      : MediaQuery.of(context).size.width *
                                          0.77,
                                  padding: const EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    color: ConstantsApp.purpleSecondaryColor,
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Wrap(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                '* Encuentra más información \nsobre este beneficio',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      ConstantsApp.OPBold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/scholarship/detail/launch-white.png',
                                              scale: 1.8,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //enlaces relacionador
                            EnlaceRelacionado(isOffline: isOffline),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: InkWell(
            onTap: () {
              showAndHide();
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                //enableDrag: false,
                //showDragHandle: true,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => DownloadFileBloc(),
                    child: Builder(
                      builder: (context) {
                        return CustomFloatingActionButton(send: widget.send);
                      },
                    ),
                  );
                },
              ).then((value) {
                showAndHide();
              });
            },
            child: SizedBox(
              height: 80,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isOpen ? 0 : 50,
                    height: isOpen ? 0 : 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: ConstantsApp.purpleSecondaryColor,
                      child: Icon(
                        Icons.share_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isOpen ? 0 : 70,
                    height: isOpen ? 0 : 30,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Compartir',
                          style: TextStyle(
                            color: ConstantsApp.purpleSecondaryColor,
                            fontFamily: ConstantsApp.OPSemiBold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextDetail extends StatelessWidget {
  const TextDetail({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: 8,
            margin: const EdgeInsets.only(right: 10, left: 10, top: 5),
            decoration: ConstantsApp.boxLinearVerticalDecorationPrimary,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: ConstantsApp.OPRegular,
                fontSize: 16,
                color: ConstantsApp.colorBlackPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $uri');
  }
}

class CustomFloatingActionButton extends StatefulWidget {
  CustomFloatingActionButton({required this.send, super.key});
  SendModelDetail send;

  @override
  _CustomFloatingActionButtonState createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton>
    with SingleTickerProviderStateMixin {
  final internetConnection = CheckInternetConnection();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;
  final ILocalDataSecureDbRepository localSecureDbRepository =
      getItApp.get<ILocalDataSecureDbRepository>();
  OverlayEntry? _overlayEntry;
  late File fileAdd;
  bool isWhatsapp = false;
  bool isEmail = false;
  bool isFile = false;
  bool isOffline = false;

  bool isTablet = false;

  @override
  void initState() {
    super.initState();
    // _isExpanded = widget.isOpen;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    internetConnection.internetStatus().listen((status) {
      setState(() {
        isOffline = (status == ConnectionStatus.offline);
      });
    });

    widget.send.isSync = widget.send.isLocal == false
        ? !widget.send.isLocal
        : widget.send.isSync;
    _toggleExpanded();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isTabletMethod();
  }

  Future<void> isTabletMethod() async {
    isTablet = await isTabletOrIPad();
  }

  Future<bool> isTabletOrIPad() async {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    var isTabletAux = shortestSide >= 600;

    if (isTabletAux && Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      isTabletAux = iosInfo.model.toLowerCase().contains('ipad');
    }

    return isTabletAux;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  bottom: 40 + (100 * _animation.value),
                  right: 20,
                  child: Opacity(
                    opacity: _animation.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: !isOffline &&
                              !kIsWeb &&
                              !isTablet &&
                              widget.send.isSync,
                          child: buildExpandedItem(
                            'Enviar a correo electrónico',
                            Icons.email_outlined,
                            const Color(0xff1B81DD),
                            null,
                            () async {
                              isEmail = true;
                              await context
                                  .read<DownloadFileBloc>()
                                  //.downloadFile(widget.send.data, widget.send.consultaId);
                                  .downloadFileBase64(widget.send.data);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: !isOffline &&
                              !kIsWeb &&
                              !isTablet &&
                              widget.send.isSync,
                          child: buildExpandedItem(
                            'Enviar a Whatsapp',
                            Icons.whatshot,
                            const Color(0xff70B273),
                            'assets/contact/Whatsapp.svg',
                            () async {
                              isWhatsapp = true;
                              await context
                                  .read<DownloadFileBloc>()
                                  //.downloadFile(widget.send.data, widget.send.consultaId);
                                  .downloadFileBase64(widget.send.data);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Builder(
                          builder: (context) {
                            return buildExpandedItem(
                              'Descargar pdf',
                              Icons.file_download_outlined,
                              const Color(0xffF94199),
                              null,
                              () async {
                                //descargar
                                isFile = true;
                                if (isOffline || !widget.send.isSync) {
                                  await context
                                      .read<DownloadFileBloc>()
                                      .downloadFileBase64(widget.send.data);
                                } else {
                                  // if (kIsWeb) {
                                  //   await context
                                  //       .read<DownloadFileBloc>()
                                  //       .downloadFileWb(widget.send.data, widget.send.consultaId);
                                  // } else {
                                  //   await context
                                  //       .read<DownloadFileBloc>()
                                  //       .downloadFile(widget.send.data, widget.send.consultaId);
                                  // }
                                  // }
                                  if (kIsWeb) {
                                    if (widget.send.consultaId != 0) {
                                      await context
                                          .read<DownloadFileBloc>()
                                          .downloadFileWb(
                                            widget.send.data,
                                            widget.send.consultaId,
                                          );
                                    } else {
                                      await context
                                          .read<DownloadFileBloc>()
                                          .downloadFileWbBase64(
                                            widget.send.data,
                                          );
                                    }
                                  } else {
                                    if (widget.send.consultaId != 0) {
                                      await context
                                          .read<DownloadFileBloc>()
                                          .downloadFile(
                                            widget.send.data,
                                            widget.send.consultaId,
                                          );
                                    } else {
                                      await context
                                          .read<DownloadFileBloc>()
                                          .downloadNewFileBase64(
                                            widget.send.data,
                                          );
                                    }
                                  }
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 60,
              right: 15,
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: ConstantsApp.purpleSecondaryColor,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      'Cerrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: ConstantsApp.OPSemiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<DownloadFileBloc, DownloadFileState>(
              listener: (context, state) {
                // Puedes agregar lógica adicional cuando el estado cambie si es necesario
              },
              builder: (context, state) {
                if (state is ErrorState) {
                  //error al obtener los resultados del api de reniec
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    //errorMessage(state.error);
                    hideLoadingOverlay();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        showCloseIcon: true,
                        content: Center(
                          child: Text(state.error.value.first.message),
                        ),
                      ),
                    );
                  });
                }

                if (state is DownloadFileCompleteState) {
                  //data obtenida correctamente
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    hideLoadingOverlay();
                    fileAdd = File(state.response.value!.path!);
                    context.read<DownloadFileBloc>().initialState();
                    if (isFile) {
                      isFile = false;
                      if (!kIsWeb) {
                        await OpenFile.open(state.response.value!.path);
                      }
                    }

                    if (isEmail) {
                      try {
                        isEmail = false;
                        final email = Email(
                          body:
                              'Estimado(a), se envía la información de la beca "${widget.send.data.nomCompleto}"',
                          subject: widget.send.data.nomCompleto!,
                          recipients: [''],
                          attachmentPaths: [fileAdd.path],
                          //isHTML: false,
                        );
                        await FlutterEmailSender.send(email);
                      } catch (e) {
                        await Clipboard.setData(
                          ClipboardData(text: e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No se encontro el servicio de correo configurado',
                            ),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    }
                    if (isWhatsapp) {
                      isWhatsapp = false;
                      // await Open.localFile(filePath: fileAdd.path);
                      await Share.shareXFiles([XFile(fileAdd.path)], text: '');
                    }
                  });
                }

                if (state is DownloadFileLoadingState) {
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
    );
  }

  Widget buildExpandedItem(
    String text,
    IconData icon,
    Color iconColor,
    String? svg,
    VoidCallback onPressed,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: ConstantsApp.OPMedium,
              fontSize: 14,
              color: Color(0xff575757),
            ),
          ),
        ),
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: CircleAvatar(
            backgroundColor: iconColor,
            child: svg != null
                ? SvgPicture.asset(
                    svg,
                    // ignore: deprecated_member_use
                    color: Colors.white,
                  )
                : Icon(
                    icon,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }
}

class ImportantText extends StatelessWidget {
  ImportantText({
    required this.text,
    super.key,
  });
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: ConstantsApp.purplePrimaryColor,
          fontFamily: ConstantsApp.OPSemiBoldItalic,
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class DetailList extends StatelessWidget {
  DetailList({
    required this.text,
    super.key,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                color: ConstantsApp.colorBlackPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: ConstantsApp.OPRegular,
                fontSize: 14,
                color: ConstantsApp.colorBlackPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
