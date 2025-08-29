// ignore_for_file: omit_local_variable_types
import 'package:flutter/material.dart';
import 'package:perubeca/app/common/widgets/background_common.dart';
import 'package:perubeca/app/common/widgets/botton_center_widget.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/info/constants_text_info_app.dart';
import 'package:perubeca/app/modules/info/widget/body_widget.dart';
import 'package:perubeca/app/modules/info/widget/circular_center_widget.dart';
import 'package:perubeca/app/modules/info/widget/title_subtitle_widget.dart';
import 'package:perubeca/app/utils/constans.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final PageController pageController = PageController();
  int position = 1;

  void nextPage(int index) {
    setState(() {
      position = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCommon(
      child: BodyWidget(
        children: [
          const CircularCenterWidget(),
          Positioned(
            child: Align(
              child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        ConstantsApp.twoIcon,
                      ),
                    ),
                    TitleSubtitleWidget(
                      title: ConstantsTextInfoApp().titleTwo,
                      subtitle: ConstantsTextInfoApp().subTitleTwo,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: BottonCenterWidget(
              text: 'Listo',
              ontap: () {
                Navigator.pushReplacementNamed(context, RoutesApp.home);
              },
            ),
          ),
        ],
      ),
    );
  }
}
