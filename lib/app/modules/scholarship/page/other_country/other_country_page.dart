// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation, inference_failure_on_function_return_type, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/scholarship/bloc/other_country_bloc/other_country_bloc.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherCountryPage extends StatefulWidget {
  const OtherCountryPage({super.key});

  @override
  State<OtherCountryPage> createState() => OtherCountryPageState();
}

class OtherCountryPageState extends State<OtherCountryPage> {
  final internetConnection = CheckInternetConnection();
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    getDataInitial();
    internetConnection.internetStatus().listen((status) {
      if (mounted) {
        setState(() {
          isOffline = (status == ConnectionStatus.offline);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDataInitial() {
    context.read<OtherCountryBloc>().add(OtherCountryLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BackgroundCommon(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  BackAppBarCommon(
                    title: 'Becas otros países',
                    subtitle: '',
                    backString: 'Regresar al menú',
                    ontap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  BlocConsumer<OtherCountryBloc, OtherCountryState>(
                    listener: (context, state) {
                      if (state is OtherCountryLoadingState) {
                        print('cargando datos');
                      }
                    },
                    builder: (context, state) {
                      if (state is OtherCountryInitialState ||
                          state is OtherCountryLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is OtherCountryCompleteState) {
                        return BodyPage(state: state, isOffline: isOffline);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyPage extends StatefulWidget {
  const BodyPage({required this.state, required this.isOffline, super.key});
  final OtherCountryCompleteState state;
  final bool isOffline;

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: (constraints.maxWidth > 1000)
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children:
                  List<Widget>.generate(widget.state.response.length, (index) {
                final beca = widget.state.response[index];
                return Column(
                  children: [
                    Text(
                      beca.vTituloBop!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontFamily: ConstantsApp.OPSemiBold,
                        color: ConstantsApp.textBluePrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    Text(
                      beca.vDescripcionTituloBop!,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 16,
                        color: ConstantsApp.colorBlackPrimary,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Divider(color: Colors.transparent),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 220,
                        childAspectRatio: 2.4 / 2.5,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: beca.becasOtrosPaisesHijos!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final model = beca.becasOtrosPaisesHijos![index];
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              if (kIsWeb) {
                                _launchUrl(model.vEnlaceInformacionBop!);
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  RoutesApp.webview,
                                  arguments: model.vEnlaceInformacionBop,
                                );
                              }
                            },
                            child: Padding(
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
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Image.asset(
                                          'assets/card-header.png',
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(height: 10),
                                          if (widget.isOffline)
                                            Image.asset(
                                              'assets/scholarship/logos_bop${model.vEnlaceLogoBopOffline}',
                                              height: 70,
                                            )
                                          else
                                            CachedNetworkImage(
                                              imageUrl: model.vEnlaceLogoBop!,
                                              height: 70,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),

                                          //
                                          //                                         const SizedBox(height: 10),
                                          Text(
                                            model.vNombreBop!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  ConstantsApp.OPSemiBold,
                                              color:
                                                  ConstantsApp.textBluePrimary,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5,),
                                                child: Text(
                                                  model.vDescripcionNombreBop!,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        ConstantsApp.OPRegular,
                                                    color: ConstantsApp
                                                        .colorBlackTerciary,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $uri');
  }
}
