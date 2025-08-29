// ignore_for_file: lines_longer_than_80_chars, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/common/widgets/appbarCommon.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/web/app_bar_back_common_web_widget.dart';
import 'package:perubeca/app/database/entities/pregunta_frecuente_entity.dart';
import 'package:perubeca/app/modules/question/bloc/pregunta_frecuente_bloc.dart';
import 'package:perubeca/app/utils/constans.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({this.scaffoldKey, super.key});

  GlobalKey<ScaffoldState>? scaffoldKey;

  static Widget create(
    BuildContext context,
    GlobalKey<ScaffoldState>? scaffoldKey,
  ) {
    return QuestionPage(
      scaffoldKey: scaffoldKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PreguntaFrecuenteBloc()..add(GetPreguntaFrecuenteDataLocalEvent()),
      child: BackgroundCommon(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                if (constraints.maxWidth > 1000)
                  AppBarBackCommonWebWidget(
                    title: 'Preguntas frecuentes',
                    subtitle: 'subtitle',
                    scaffoldKey: scaffoldKey!,
                  )
                else
                  AppBarCommon(
                    title: 'Preguntas frecuentes',
                    subtitle:
                        'Descubre la información de los canales de atención',
                  ),
                //body
                BodyPage(constraints: constraints),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BodyPage extends StatefulWidget {
  const BodyPage({
    required this.constraints,
    super.key,
  });

  final BoxConstraints constraints;

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  List<PreguntaFrecuenteEntity> lista = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreguntaFrecuenteBloc, PreguntaFrecuenteState>(
      listener: (context, state) {
        if (state is PreguntaFrecuenteLoadLocalCompleteState) {
          lista = state.listPreguntaFrecuente;
        }
      },
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: (widget.constraints.maxWidth > 1000)
              ? MediaQuery.of(context).size.width * 0.4
              : MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.transparent,
                height: (widget.constraints.maxWidth > 1000) ? 50 : null,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text:
                      'Explora nuestras preguntas frecuentes y resuelve tus consultas sobre postulación, requisitos y más.',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: ConstantsApp.OPRegular,
                    color: ConstantsApp.textBlackPrimary,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: (widget.constraints.maxWidth > 1000) ? 50 : null,
              ),
              Expanded(
                child:
                    BlocBuilder<PreguntaFrecuenteBloc, PreguntaFrecuenteState>(
                  builder: (context, state) {
                    if (state is PreguntaFrecuenteLoadLocalCompleteState) {
                      return ListView.builder(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.listPreguntaFrecuente.length,
                        itemBuilder: (context, index) {
                          final model = state.listPreguntaFrecuente[index];
                          // Clave para identificar el widget a desplazar
                          final key = GlobalKey();

                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Card(
                                elevation: 3,
                                shadowColor: ConstantsApp.barrierColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0x29E71D73),
                                        Color(0x290895EA),
                                        Color(0x29004A92),
                                      ],
                                      stops: [0.0, 0.5, 1.0],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ExpansionTile(
                                    key: key,
                                    collapsedIconColor:
                                        ConstantsApp.purplePrimaryColor,
                                    iconColor: ConstantsApp.purplePrimaryColor,
                                    collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: Text(
                                      '${index + 1}. ${model.vTitulo!}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: ConstantsApp.colorBlackPrimary,
                                      ),
                                    ),
                                    onExpansionChanged: (expanded) {
                                      if (expanded) {
                                        Future.delayed(
                                            const Duration(milliseconds: 200),
                                            () {
                                          _scrollToItem(key);
                                        });
                                      }
                                    },
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        color: Colors.white,
                                        child: Text(
                                          model.vContenido!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: ConstantsApp
                                                .colorBlackSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToItem(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.3,
      );
    }
  }
}

class ItemModel {
  ItemModel({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<ItemModel> generateItems(int numberOfItems) {
  return List<ItemModel>.generate(numberOfItems, (int index) {
    return ItemModel(
      headerValue:
          '¿Cuáles son las novedades de Beca 18 para la convocatoria 2024?',
      expandedValue:
          'La convocatoria tiene dos etapas: i) la etapa de preselección y ii) la etapa de postulación a la beca. En la primera etapa, los interesados se inscribirán para rendir el examen nacional de preselección del Pronabec y se verificarán los requisitos de cada modalidad. En la segunda etapa los preseleccionados recibirán apoyo e información del Pronabec, que les ayudará a decidir carrera y lugar de estudios.',
    );
  });
}
