// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation, inference_failure_on_function_return_type, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/common/model/error_response_model.dart';
import 'package:perubeca/app/common/util_common.dart';
import 'package:perubeca/app/common/widgets/alert_image_mesagge_generic_widget.dart';
import 'package:perubeca/app/common/widgets/back_appbar_common.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/card_title_subtitle_email_search_widget.dart';
import 'package:perubeca/app/common/widgets/custom_loader.dart';
import 'package:perubeca/app/common/widgets/title_expansion_tile.widget3.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/database/entities/modalidad_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_filtro_opciones_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/bottom_sheet_bloc/bottom_sheet_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/email_bloc/email_bloc.dart';
import 'package:perubeca/app/modules/scholarship/bloc/search_bloc/filter_cubit.dart';
import 'package:perubeca/app/modules/scholarship/bloc/search_bloc/search_bloc.dart';
import 'package:perubeca/app/modules/scholarship/page/find_credit/page_three.dart';
import 'package:perubeca/app/utils/check_internet_connection.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:perubeca/app/utils/methods.dart';

class ScholarshipSearchPage extends StatefulWidget {
  const ScholarshipSearchPage({super.key});

  @override
  State<ScholarshipSearchPage> createState() => _ScholarshipSearchPageState();
}

class _ScholarshipSearchPageState extends State<ScholarshipSearchPage> {
  final internetConnection = CheckInternetConnection();
  OverlayEntry? _overlayEntry;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    context.read<FilterCubit>().resetFilters();
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
    context.read<SearchBloc>().add(const SearchLoadEvent([], null, null));
  }

  void showLoadingOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            CustomLoader(),
          ],
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void errorMessage(ErrorResponseModel error) {
    context.read<EmailBloc>().initialState();
    if (error.statusCode == getAppStatusCodeError(AppStatusCode.NOINTERNET)) {
      UtilCommon().noInternetNoDataModal(
        context: context,
        ontap: () {
          Navigator.pop(context);
        },
      );
      return;
    }

    if (error.statusCode! >= getAppStatusCodeError(AppStatusCode.SERVER) &&
        error.statusCode! < 900) {
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
        return true;
      },
      child: BackgroundCommon(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  BackAppBarCommon(
                    title: 'Buscador de becas y créditos',
                    subtitle: '',
                    backString: 'Regresar al menú',
                    ontap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  BlocConsumer<SearchBloc, SearchState>(
                    listener: (context, state) {
                      if (state is SearchLoadingState) {
                        print('cargando datos');
                      }
                    },
                    builder: (context, state) {
                      if (state is SearchInitialState ||
                          state is SearchLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is SearchCompleteState) {
                        return BodyPage(state: state, isOffline: isOffline);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
              BlocListener<EmailBloc, EmailState>(
                listener: (context, state) {
                  if (state is ErrorEmailState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      hideLoadingOverlay();
                      errorMessage(state.error);
                    });
                  }

                  if (state is EmailSendCompleteState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      hideLoadingOverlay();
                      context.read<EmailBloc>().initialState();
                      final alert = AlertImageMessageGenericWidget(
                        title: 'CORREO ENVIADO',
                        message:
                            'Se envió la información al correo \ningresado.',
                        consultaId: 0,
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
                      );
                    });
                  }

                  if (state is EmailLoadingState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_overlayEntry == null) {
                        showLoadingOverlay();
                      }
                    });
                  }
                },
                child: Container(),
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
  final SearchCompleteState state;
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
          child: Column(
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      'Según la información filtrada se mostrará las mejores opciones a las que puedes postular:',
                      style: TextStyle(
                        fontFamily: ConstantsApp.OPRegular,
                        fontSize: 16,
                        color: ConstantsApp.colorBlackPrimary,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Expanded(
                            child: search(
                                controller: searchController,
                                state: widget.state)),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffF59D24),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset('assets/filter.svg'),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            openBottomSheet(
                                context, widget.state, searchController);
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SearchCompleteState) {
                        return ScholarshipGrid(
                          modalidades: state.response,
                          isOffline: widget.isOffline,
                        );
                      } else if (state is ErrorSearchState) {
                        return Center(child: Text("Error."));
                      }
                      // Estado inicial
                      return ScholarshipGrid(
                        modalidades: widget.state.response,
                        isOffline: widget.isOffline,
                      );
                    },
                  ),
                  /*ScholarshipGrid(
                    modalidades: widget.state.response,
                    isOffline: widget.isOffline,
                  ),*/
                  CardTitleSubtitleEmailSearchWidget(
                    title: 'Déjanos tu correo electrónico',
                    subtitle:
                        'Para enviarte toda la información sobre \nlos beneficios a los que puedes \npostular.',
                    url: '',
                    dni: '',
                    parametro: 0,
                    ontap: () {},
                    formKey: formKey,
                    ids: widget.state.response.map((e) => e.modId!).toList(),
                  ),
                  const Divider(color: Colors.transparent),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> openBottomSheet(BuildContext context,
      SearchCompleteState state, TextEditingController searchController) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => BottomSheetContent(
        sliderValue2: state.sliderValue,
        searchContoller: searchController,
      ),
    );
  }

  Widget search(
      {TextEditingController? controller, SearchCompleteState? state}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 40,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Buscar',
          alignLabelWithHint: true,
          counterText: '',
          prefixIcon: const Icon(Icons.search),
          labelStyle: const TextStyle(
            backgroundColor: Colors.transparent,
            color: ConstantsApp.colorBlackPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: ConstantsApp.OPSemiBold,
          ),
          hintStyle: const TextStyle(
            color: ConstantsApp.colorBlackInputHidden,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: ConstantsApp.OPSemiBold,
          ),
          floatingLabelStyle: const TextStyle(
            backgroundColor: Colors.transparent,
            color: ConstantsApp.colorBlackPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: ConstantsApp.OPSemiBold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ConstantsApp.blueBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ConstantsApp.cardBorderColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ConstantsApp.blueBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ConstantsApp.blueBorderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        style: const TextStyle(
          color: ConstantsApp.textBlackSecondary,
          fontFamily: ConstantsApp.OPRegular,
          fontSize: 16,
        ),
        onChanged: (value) {
          final selectedOptions = context.read<FilterCubit>().state.toList();
          if (value.isEmpty) {
            context.read<SearchBloc>().add(
                SearchLoadEvent(selectedOptions, state?.sliderValue, null));
          } else {
            context.read<SearchBloc>().add(
                SearchLoadEvent(selectedOptions, state!.sliderValue, value));
          }
        },
        validator: (value) {
          return null;
        },
      ),
    );
  }
}

class ScholarshipGrid extends StatefulWidget {
  final List<ModalidadEntity> modalidades;
  final bool isOffline;

  const ScholarshipGrid({
    Key? key,
    required this.modalidades,
    required this.isOffline,
  }) : super(key: key);

  @override
  State<ScholarshipGrid> createState() => _ScholarshipGridState();
}

class _ScholarshipGridState extends State<ScholarshipGrid> {
  String? selectedGroupKey;

  late Map<String, List<ModalidadEntity>> groupedData;
  late List<ModalidadEntity> ungroupedData;
  late List<String> groupKeys;

  void _rebuildGroups() {
    groupedData = {};
    ungroupedData = [];

    for (var item in widget.modalidades) {
      final group = item.grupo?.trim();

      if (group != null && group.isNotEmpty) {
        groupedData.putIfAbsent(group, () => []).add(item);
      } else {
        ungroupedData.add(item);
      }
    }

    final singleItemGroups =
        groupedData.entries.where((entry) => entry.value.length == 1).toList();

    for (var entry in singleItemGroups) {
      ungroupedData.add(entry.value.first);
      groupedData.remove(entry.key);
    }

    groupKeys = groupedData.keys.toList();
  }

  @override
  void initState() {
    super.initState();
    _rebuildGroups();
  }

  @override
  void didUpdateWidget(covariant ScholarshipGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!listEquals(oldWidget.modalidades, widget.modalidades)) {
      selectedGroupKey = null;
      _rebuildGroups();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isShowingGroup =
        selectedGroupKey != null && groupedData.containsKey(selectedGroupKey);

    if (isShowingGroup) {
      final currentItems = groupedData[selectedGroupKey]!;
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 3 / 2.5,
          mainAxisSpacing: 1,
        ),
        itemCount: currentItems.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Botón Atrás
            return Padding(
              padding: const EdgeInsets.all(10),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => setState(() => selectedGroupKey = null),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Atrás"),
              ),
            );
          }
          final item = currentItems[index - 1];
          return _buildItemCard(item);
        },
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        childAspectRatio: 3 / 2.5,
        mainAxisSpacing: 1,
      ),
      itemCount: groupKeys.length + ungroupedData.length,
      itemBuilder: (context, index) {
        // Bloque de grupos
        if (index < groupKeys.length) {
          final groupKey = groupKeys[index];
          return _buildGroupCard(groupKey);
        }
        // Bloque de modalidades sin agrupar
        final ungroupedIndex = index - groupKeys.length;
        final item = ungroupedData[ungroupedIndex];
        return _buildItemCard(item);
      },
    );
  }

  Widget _buildGroupCard(String groupKey) {
    late ModalidadEntity model;

    model = groupedData[groupKey]!.first;
    late int colorDegradadoInicio;
    colorDegradadoInicio =
        int.parse(model.grupoColorDegradadoInicio.toString());
    late int colorDegradadoFin;
    colorDegradadoFin = int.parse(model.grupoColorDegradadoFin.toString());

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(colorDegradadoInicio),
                Color(colorDegradadoFin),
              ],
              stops: const [0.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.isOffline)
                Image.asset(
                  'assets/scholarship/find${model.grupoEnlaceLogoGrupoOffline}',
                  height: 70,
                )
              else
                CachedNetworkImage(
                  imageUrl: model.grupoEnlaceLogoGrupo!,
                  height: 70,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              InkWell(
                onTap: () => setState(() => selectedGroupKey = groupKey),
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
                    SizedBox(width: 7),
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
        ),
      ),
    );
  }

  Widget _buildItemCard(ModalidadEntity model) {
    late int colorDegradadoInicio;
    colorDegradadoInicio = int.parse(model.colorDegradadoInicio.toString());
    late int colorDegradadoFin;
    colorDegradadoFin = int.parse(model.colorDegradadoFin.toString());

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(colorDegradadoInicio),
                Color(colorDegradadoFin),
              ],
              stops: const [0.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.isOffline)
                Image.asset(
                  'assets/scholarship/find${model.enlaceLogOffline}',
                  height: 70,
                )
              else
                CachedNetworkImage(
                  imageUrl: model.enlaceLog!,
                  height: 70,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              InkWell(
                onTap: () {
                  registerPageAnalytics('/DetailScholarshipSelected');
                  model.beneficios = '';

                  final send = SendModelDetail(
                    data: model,
                    isLocal: false,
                    isSync: true,
                    consultaId: 0,
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
                    SizedBox(width: 7),
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
        ),
      ),
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent(
      {required this.searchContoller,
      this.sliderValue2,
      this.textSearch2,
      super.key});
  final double? sliderValue2;
  final String? textSearch2;
  final TextEditingController searchContoller;
  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  double? sliderValue;
  String? textSearch;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.sliderValue2;
    textSearch = widget.textSearch2;
  }

  void resetFilters() {
    context.read<FilterCubit>().resetFilters();
    context.read<SearchBloc>().add(const SearchLoadEvent([], null, null));
    widget.searchContoller.text = '';
    setState(() {
      sliderValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<BottomSheetBloc>().add(const BottomSheetLoadEvent());
    return SafeArea(
      right: false,
      left: false,
      top: false,
      child: DraggableScrollableSheet(
        controller: _controller,
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Handle(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: resetFilters,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.refresh,
                                  color: ConstantsApp.purpleTerctiaryColor,
                                ),
                              ),
                              Text(
                                'Limpiar',
                                style: TextStyle(
                                  color: ConstantsApp.purpleTerctiaryColor,
                                  fontFamily: ConstantsApp.OPSemiBold,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:
                                BlocBuilder<BottomSheetBloc, BottomSheetState>(
                              builder: (context, state) {
                                if (state is BottomSheetLoadingState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (state is BottomSheetCompleteState) {
                                  return ListView.builder(
                                    controller: scrollController,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.response.length,
                                    itemBuilder: (context, index) {
                                      final option = state.response[index];
                                      if (option.objeto == 'numerico') {
                                        final start = option.opciones!
                                            .where(
                                                (e) => e.filtroContenidoId == 1)
                                            .toList()
                                            .first;
                                        final end = option.opciones!
                                            .where((e) =>
                                                e.filtroContenidoId == 31)
                                            .toList()
                                            .first;
                                        return SliderAgeApp(
                                          parametro: option,
                                          sliderValue: sliderValue,
                                          startAge:
                                              double.parse(start.opciones!),
                                          endAge: double.parse(end.opciones!),
                                          onValueChanged: (value) {
                                            setState(() {
                                              sliderValue = value;
                                            });
                                            context
                                                .read<FilterCubit>()
                                                .updateSliderValue(
                                                    option, value);
                                          },
                                        );
                                      }
                                      if (option.objeto == 'boton') {
                                        return ListOptions(parametro: option);
                                      }

                                      if (option.objeto == 'ckeckbox' ||
                                          option.objeto == 'checkbox') {
                                        return CheckBoxSection(
                                            parametro: option);
                                      }

                                      return Text(option.titulo!);
                                    },
                                  );
                                }

                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                      if (kIsWeb) Container(height: 50) else Container(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    widget.searchContoller.text = '';
                    textSearch = null;
                    final selectedOptions =
                        context.read<FilterCubit>().state.toList();
                    context.read<SearchBloc>().add(SearchLoadEvent(
                        selectedOptions, sliderValue, textSearch));
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    decoration: BoxDecoration(
                      color: ConstantsApp.purpleTerctiaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ConstantsApp.purpleTerctiaryColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Aplicar',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: ConstantsApp.OPSemiBold,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ListOptions extends StatelessWidget {
  const ListOptions({
    required this.parametro,
    super.key,
  });

  final ParametroFiltroEntity parametro;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        TitleExpansionTileWidget3(title: parametro.titulo!),
        BlocBuilder<FilterCubit, Set<ParametroFiltroOpcionesEntity>>(
          builder: (context, selectedOptions) {
            return Wrap(
              spacing: 3,
              children: List.generate(
                parametro.opciones!.length,
                (index) {
                  final option = parametro.opciones![index];
                  final isSelected = selectedOptions.contains(option);
                  return GestureDetector(
                    onTap: () =>
                        context.read<FilterCubit>().toggleSelection(option),
                    child: ChipApp(option: option, isSelected: isSelected),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class SliderAgeApp extends StatelessWidget {
  const SliderAgeApp({
    required this.parametro,
    required this.sliderValue,
    required this.startAge,
    required this.endAge,
    required this.onValueChanged,
    super.key,
  });

  final ParametroFiltroEntity parametro;
  final double? sliderValue;
  final double startAge;
  final double endAge;
  final ValueChanged<double> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        TitleExpansionTileWidget3(
            title:
                '${parametro.titulo!} ${sliderValue == null ? '' : sliderValue?.toStringAsFixed(0)}'),
        Column(
          children: [
            SliderApp(
              sliderValue: sliderValue,
              parametro: parametro,
              minValue: startAge,
              maxValue: endAge,
              onValueChanged: onValueChanged,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${startAge.toStringAsFixed(0)} años'),
                Text('${endAge.toStringAsFixed(0)} años'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CheckBoxSection extends StatelessWidget {
  const CheckBoxSection({
    required this.parametro,
    super.key,
  });

  final ParametroFiltroEntity parametro;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        TitleExpansionTileWidget3(title: parametro.titulo!),
        BlocBuilder<FilterCubit, Set<ParametroFiltroOpcionesEntity>>(
          builder: (context, selectedOptions) {
            return Row(
              children: parametro.opciones!.map((option) {
                return Expanded(
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      option.opciones!,
                      style: const TextStyle(
                          color: Color(0xff6E6C6D),
                          fontWeight: FontWeight.w600),
                    ),
                    value: selectedOptions.contains(option),
                    checkColor: const Color(0xffF59D24),
                    activeColor: const Color(0xffF59D24),
                    side: const BorderSide(color: Color(0xff9F9F9F), width: 2),
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onChanged: (bool? value) {
                      if (value != null && value) {
                        context
                            .read<FilterCubit>()
                            .toggleSingleSelection(option);
                      } else {
                        context.read<FilterCubit>().toggleSelection(option);
                      }
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class ChipApp extends StatelessWidget {
  const ChipApp({
    required this.option,
    required this.isSelected,
    super.key,
  });

  final ParametroFiltroOpcionesEntity option;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          width: 2,
          color: isSelected ? const Color(0xffFFB26C) : Colors.grey.shade300,
        ),
      ),
      backgroundColor: isSelected
          ? const Color(0xffFFB26C).withOpacity(0.4)
          : Colors.grey.shade300,
      label: Text(
        option.opciones!,
        style: const TextStyle(color: Color(0xff6E6C6D)),
      ),
    );
  }
}

class Handle extends StatelessWidget {
  const Handle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class SliderApp extends StatefulWidget {
  const SliderApp({
    required this.sliderValue,
    required this.parametro,
    required this.minValue,
    required this.maxValue,
    required this.onValueChanged,
    super.key,
  });

  final double? sliderValue;
  final ParametroFiltroEntity parametro;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onValueChanged;

  @override
  State<SliderApp> createState() => _SliderAppState();
}

class _SliderAppState extends State<SliderApp> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        valueIndicatorColor: const Color(0xffF59D24),
        activeTickMarkColor: const Color(0xffF59D24),
        inactiveTickMarkColor: Colors.grey,
        activeTrackColor: Colors.red,
        allowedInteraction: SliderInteraction.tapAndSlide,
        disabledActiveTickMarkColor: Colors.grey,
        disabledActiveTrackColor: Colors.grey,
        disabledInactiveTickMarkColor: Colors.grey,
        disabledInactiveTrackColor: Colors.grey,
        disabledSecondaryActiveTrackColor: Colors.grey,
        disabledThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey,
        overlappingShapeStrokeColor: Colors.grey,
        secondaryActiveTrackColor: Colors.grey,
        thumbColor: Colors.grey,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
        ),
        valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        value: widget.sliderValue ?? widget.minValue,
        min: widget.minValue,
        max: widget.maxValue,
        divisions:
            int.parse((widget.maxValue - widget.minValue).toStringAsFixed(0)),
        label: (widget.sliderValue ?? widget.minValue).round().toString(),
        activeColor: Colors.amber,
        autofocus: true,
        allowedInteraction: SliderInteraction.tapAndSlide,
        thumbColor: Colors.white,
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.amber.withOpacity(0.2);
          }
          return Colors.amber.withOpacity(0.1);
        }),
        onChanged: (double value) {
          setState(() {
            widget.onValueChanged(value); // Notify parent about value change
          });
        },
      ),
    );
  }
}
