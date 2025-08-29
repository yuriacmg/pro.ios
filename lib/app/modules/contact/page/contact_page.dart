// ignore_for_file: lines_longer_than_80_chars, avoid_positional_boolean_parameters, prefer_final_fields, must_be_immutable, avoid_redundant_argument_values

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/widgets/appbarCommon.dart';
import 'package:perubeca/app/common/widgets/card_icon_title_subtitle_widget.dart';
import 'package:perubeca/app/common/widgets/card_icon_title_widget.dart';
import 'package:perubeca/app/common/widgets/expansion_tile_widget2.dart';
import 'package:perubeca/app/common/widgets/web/app_bar_back_common_web_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/contact/bloc/contact_bloc.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class ContactPage extends StatelessWidget {
  ContactPage({this.scaffoldKey, super.key});
  GlobalKey<ScaffoldState>? scaffoldKey;

  static Widget create(
    BuildContext context,
    GlobalKey<ScaffoldState>? scaffoldKey,
  ) {
    //return const ContactPage();
    return BlocProvider<ContactBloc>(
      create: (_) => ContactBloc()..add(GetContactDataEvent()),
      child: ContactPage(
        scaffoldKey: scaffoldKey,
      ),
    );
  }

  int selectItem = -1;
  bool fisrtTime = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc()..add(GetContactDataLocalEvent()),
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  if (constraints.maxWidth > 1000)
                    AppBarBackCommonWebWidget(
                      title: 'Contacto',
                      subtitle: 'subtitle',
                      scaffoldKey: scaffoldKey!,
                    )
                  else
                    AppBarCommon(
                      title: 'Contacto',
                      subtitle:
                          'Descubre la información de los canales de atención',
                    ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20,
                      bottom: 10,
                    ),
                    child: Text(
                      'Conoce los medios de contacto del \nPronabec',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 16,
                        color: ConstantsApp.colorBlackPrimary,
                      ),
                    ),
                  ),
                  if (state is ContactLoadLocalCompleteState)
                    BodyPage(
                      fisrtTime: fisrtTime,
                      constraints: constraints,
                      state: state,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class BodyPage extends StatelessWidget {
  const BodyPage({
    required this.fisrtTime,
    required this.constraints,
    required this.state,
    super.key,
  });

  final bool fisrtTime;
  final BoxConstraints constraints;
  final ContactLoadLocalCompleteState state;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: SizedBox(
          width: (constraints.maxWidth > 1000)
              ? MediaQuery.of(context).size.width * 0.4
              : MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //chanel
              ExpansionTileWidget2(
                title: 'Canales de atención',
                fisrtTime: fisrtTime,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    childAspectRatio: 3 / 2.5,
                    mainAxisSpacing: 1,
                  ),
                  itemCount:
                      state.listCanal.isEmpty ? 0 : state.listCanal.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    final model = state.listCanal[index];
                    return CardIconTitleSubtitleWidget(
                      title: model.nombreCanal!,
                      icon: 'assets/contact/${model.enlaceImg!}',
                      subtitle: model.detalleCanal!,
                      url: model.enlaceCanAte!,
                    );
                  },
                ),
              ),

              // ////horario
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.schedule.nombreCanal!,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPSemiBold,
                        fontSize: 16,
                        color: ConstantsApp.textBlackQuaternary,
                      ),
                    ),
                    Text(
                      state.schedule.detalleCanal!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 16,
                        color: ConstantsApp.textBlackQuaternary,
                      ),
                    ),
                  ],
                ),
              ),

              //button

              InkWell(
                onTap: () {
                  const url = 'https://www.gob.pe/institucion/pronabec/sedes';
                  if (kIsWeb) {
                    launchUrlAPP(url);
                  } else {
                    Navigator.pushNamed(context, RoutesApp.webview,
                        arguments: url);
                  }
                },
                child: Container(
                  // height: 75,
                  width: constraints.maxWidth > 1000
                      ? MediaQuery.of(context).size.width * 0.25
                      : MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 15, top: 15),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Expanded(
                              child: Text(
                                '* Encuentra más información \nsobre el directorio de sedes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: ConstantsApp.OPBold,
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

              //social
              ExpansionTileWidget2(
                title: 'Web y redes sociales',
                fisrtTime: fisrtTime,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    childAspectRatio: 3 / 2.5,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: state.listContacto.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = state.listContacto[index];
                    return CardIconTitleWidget(
                      title: model.nombre!,
                      icon: 'assets/contact/${model.enlaceImg!}',
                      subtitle: model.detalle!,
                      url: model.enlaceCont!,
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
