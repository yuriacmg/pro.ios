// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, strict_raw_type, use_build_context_synchronously, sort_constructors_first

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:perubeca/app/common/widgets/appbarCommon.dart';
import 'package:perubeca/app/common/widgets/generic_styles_app.dart';
import 'package:perubeca/app/common/widgets/web/app_bar_back_common_web_widget.dart';
import 'package:perubeca/app/database/entities/data_reniec_entity.dart';
import 'package:perubeca/app/database/entities/history_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_entity.dart';
import 'package:perubeca/app/database/entities/respuesta_procesada_no_data_entity.dart';
import 'package:perubeca/app/modules/history/bloc/history_bloc.dart';
import 'package:perubeca/app/modules/scholarship/model/respuesta_procesada_response_model.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
import 'package:perubeca/app/utils/constans.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({this.scaffoldKey, super.key});
  GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  TextEditingController searchController = TextEditingController();
  Timer? _searchTimer;
  //paginate
  int currentPage = 1;
  int itemsPerPage = 3;
  bool canGoPrevious = false;
  bool canGoNext = true;

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getDataInitial();
  }

  @override
  void dispose() {
    searchController.text = '';
    super.dispose();
  }

  Future<void> getDataInitial() async {
    context.read<HistoryBloc>().add(HistorySearchEvent(searchText: searchController.text));
  }

  void startSearchTimer() {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 300), performSearch);
  }

  void performSearch() {
    context.read<HistoryBloc>().add(HistorySearchEvent(searchText: searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (moveEvent) {
        if (moveEvent.delta.dy > 0) {
          _focusNode.unfocus();
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              if (constraints.maxWidth > 1000)
                AppBarBackCommonWebWidget(
                  title: 'Historial de consultas',
                  subtitle: 'subtitle',
                  scaffoldKey: widget.scaffoldKey!,
                )
              else
                AppBarCommon(
                  title: 'Historial de consultas',
                  subtitle: '',
                ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: Text(
                  'Busca anteriores consultas con el DNI o nombre de la persona titular:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ConstantsApp.OPRegular,
                    fontSize: 16,
                    color: ConstantsApp.colorBlackPrimary,
                  ),
                ),
              ),
              SizedBox(
                width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
                child: search(),
              ),
              BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Expanded(child: Center(child: CircularProgressIndicator()));
                  }
                  if (state is HistoryLoaded) {
                    return ListHistory(
                      constraints: constraints,
                      histories: state.histories,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        controller: searchController,
        focusNode: _focusNode,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
        ],
        textInputAction: TextInputAction.done,
        decoration: GenericStylesApp().newInputDecorationOutline(
          label: 'DNI o nombre',
          enabled: true,
          placeholder: 'Ej.: 12345678 ó Juan Pérez',
          icon: const Icon(
            Icons.search,
            color: ConstantsApp.purplePrimaryColor,
          ),
        ),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        onEditingComplete: () {
          _searchTimer?.cancel();
          performSearch();
          _focusNode.unfocus();
        },
        onChanged: (value) async {
          startSearchTimer();
        },
      ),
    );
  }
}

class ListHistory extends StatelessWidget {
  ListHistory({
    required this.constraints,
    required this.histories,
    super.key,
  });

  List<HistoryEntity> histories;
  BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: (constraints.maxWidth > 1000) ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchOutCurve: Curves.bounceIn,
          child: histories.isEmpty
              ? const HistoryNoData()
              : CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final history = histories[index];
                          return HistoryCard(history: history);
                        },
                        childCount: histories.length,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class HistoryNoData extends StatelessWidget {
  const HistoryNoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          Image.asset(
            'assets/history/file_search.png',
          ),
          const Divider(
            color: Colors.transparent,
          ),
          const Text(
            'No tienes registros de consultas',
            style: TextStyle(
              color: ConstantsApp.colorBlackPrimary,
              fontSize: 18,
              fontFamily: ConstantsApp.OPBold,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    required this.history,
    super.key,
  });

  final HistoryEntity history;

  @override
  Widget build(BuildContext context) {
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
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset('assets/card-header.png'),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset('assets/card-bottom.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TitleSubtitleWidget(
                            title: 'Nombres y apellidos',
                            subtitle: history.fullname!,
                          ),
                        ),
                        InkWell(
                          onTap: ConstantsApp.viewSyncHistoryError
                              ? () {
                                  Clipboard.setData(ClipboardData(text: history.dataSendLocal!));
                                  const snackBar = SnackBar(
                                    content: Text('Texto copiado al portapapeles'),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              : null,
                          child: Image.asset(
                            'assets/history/file_search.png',
                            scale: 1.9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TitleSubtitleWidget(
                      title: 'Fecha y hora de consulta',
                      subtitle: history.dateSend!,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          //ver detalle
                          final respuestaProcesadNoDataBox =
                              await Hive.openBox<RespuestaProcesadaNoDataEntity>('respuestaProcesadaNoDataBox');
                          await respuestaProcesadNoDataBox.clear();
                          //data Procesada
                          final respuestaProcesadBox = await Hive.openBox<RespuestaProcesadaEntity>('respuestaProcesadaBox');

                          await respuestaProcesadBox.clear();
                          final procesada = RespuestaProcesadaResponseModel.fromJson(
                            jsonDecode(history.response!) as Map<String, dynamic>,
                          );

                          for (final element in procesada.value!.modalidadesId!) {
                            await respuestaProcesadBox.add(
                              RespuestaProcesadaEntity(
                                modId: element,
                                consultaId: procesada.value!.consultaId,
                              ),
                            );
                          }

                          final reniecDatabox = await Hive.openBox<DataReniecEntity>('dataReniecBox');
                          await reniecDatabox.clear();
                          //final complet = parseStringFullName(history.name!);
                          await reniecDatabox.add(
                            DataReniecEntity(
                              apellidoMaterno: '',
                              apellidoPaterno: history.lastName,
                              fechaNacimiento: '',
                              nombres: history.names,
                              nombreCompleto: history.fullname,
                              sexo: '',
                              numDocumento: history.numDocument,
                            ),
                          );

                          final isForeign = history.isForeign ?? false;

                          await Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PageThree(
                                history: history,
                                isForeign: isForeign,
                                isLocal: history.isLocal,
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Ver detalles',
                              style: TextStyle(
                                color: ConstantsApp.purpleSecondaryColor,
                                fontSize: 16,
                                fontFamily: ConstantsApp.QSBold,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ConstantsApp.purpleSecondaryColor,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: ConstantsApp.viewSyncHistoryError,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('es local: ${history.isLocal! ? 'si' : 'no'}'),
                            Text('es sync: ${history.isSync! ? 'si' : 'no'}'),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'error sinc mesage:  ${history.syncErrorMessage}',
                              ),
                            ),
                          ],
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
}

class TitleSubtitleWidget extends StatelessWidget {
  TitleSubtitleWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: const TextStyle(
              color: ConstantsApp.textBlackQuaternary,
              fontSize: 15,
              fontFamily: ConstantsApp.OPBold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: ConstantsApp.colorBlackPrimary,
            fontSize: 17,
            fontFamily: ConstantsApp.QSRegular,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Persona {
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;

  Persona({this.nombre, this.apellidoPaterno, this.apellidoMaterno});
}

Persona parseStringFullName(String input) {
  final partes = input.split(' ');

  switch (partes.length) {
    case 1:
      return Persona(
        nombre: partes[0],
        apellidoPaterno: '',
        apellidoMaterno: '',
      );
    case 2:
      return Persona(
        nombre: partes[0],
        apellidoPaterno: partes[1],
        apellidoMaterno: '',
      );
    case 3:
      return Persona(
        nombre: partes[0],
        apellidoPaterno: partes[1],
        apellidoMaterno: partes[2],
      );
    case 4:
      return Persona(
        nombre: partes[0],
        apellidoPaterno: partes[2],
        apellidoMaterno: partes[3],
      );
    case 5:
      return Persona(
        nombre: partes[0],
        apellidoPaterno: partes[3],
        apellidoMaterno: partes[4],
      );
    default:
      return Persona(
        nombre: partes[0],
        apellidoPaterno: partes[partes.length - 2],
        apellidoMaterno: partes[partes.length - 1],
      );
  }
}
