// ignore_for_file: must_be_immutable, lines_longer_than_80_chars, library_private_types_in_public_api, cascade_invocations, inference_failure_on_function_invocation, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perubeca/app/database/entities/enlace_relacionado_entity.dart';
import 'package:perubeca/app/modules/scholarship/bloc/enlace_relacionado_bloc/enlace_relacionado_bloc.dart';
import 'package:perubeca/app/utils/constans.dart';
import 'package:url_launcher/url_launcher.dart';

class EnlaceRelacionado extends StatelessWidget {
  EnlaceRelacionado({required this.isOffline, super.key});

  bool isOffline;
  List<EnlaceRelacionadoEntity> enlaces = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnlaceRelacionadoBloc>(
      create: (context) =>
          EnlaceRelacionadoBloc()..add(GetEnlaceRelacionadoDataLocalEvent()),
      child: BlocListener<EnlaceRelacionadoBloc, EnlaceRelacionadoState>(
        listener: (context, state) {
          if (state is EnlaceRelacionadoLoadLocalCompleteState) {
            enlaces = state.listEnlaceRelacionadoo;
          }
        },
        child: BlocBuilder<EnlaceRelacionadoBloc, EnlaceRelacionadoState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 110, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Text(
                              'Enlace relacionado',
                              style: TextStyle(
                                color: ConstantsApp.textBluePrimary,
                                fontFamily: ConstantsApp.QSBold,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (state is EnlaceRelacionadoLoadLocalCompleteState)
                        GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 220,
                            childAspectRatio: 3 / 2.5,
                            mainAxisSpacing: 1,
                          ),
                          itemCount: state.listEnlaceRelacionadoo.length,
                          itemBuilder: (BuildContext context, int index) {
                            final enlace = state.listEnlaceRelacionadoo[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                _launchUrl(enlace.vEnlace!);
                                },
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                             if (isOffline)
                                              Image.asset(
                                                'assets${enlace.vEnlaceImagenOffline}',
                                                height: 60,
                                                width: 120,
                                              )
                                            else
                                              CachedNetworkImage(
                                                imageUrl: enlace.vEnlaceImagen!,
                                                width: (constraints.maxWidth > 1000)
                                                    ? MediaQuery.of(context).size.width * 0.1
                                                    : MediaQuery.of(context).size.width * 0.4,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      enlace.vNombre!,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                        color: ConstantsApp
                                                            .textBlackQuaternary,
                                                        fontFamily:
                                                            ConstantsApp.QSBold,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      else
                        Container(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $uri');
  }
}

}
