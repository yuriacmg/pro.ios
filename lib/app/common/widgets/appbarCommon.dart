// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perubeca/app/app.dart';
import 'package:perubeca/app/common/cubit/notification_status_cubit.dart';
import 'package:perubeca/app/config/routes_app.dart';
import 'package:perubeca/app/modules/login/bloc/login_bloc.dart';

import 'package:perubeca/app/utils/constans.dart';

class AppBarCommon extends StatelessWidget {
  AppBarCommon({
    required this.title,
    required this.subtitle,
    super.key,
  });

  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 1.8,
          center: Alignment.topCenter,
          colors: [
            ConstantsApp.purplePrimaryColor,
            ConstantsApp.purpleSecondaryColor,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: -30,
            top: 21,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            right: -30,
            top: 7,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            top: -30,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                ConstantsApp.logoIcon,
                fit: BoxFit.cover,
                // height: 23,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: ConstantsApp.OPBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BlocBuilder<NotificationStatusCubit, bool>(
                bloc: getItApp<NotificationStatusCubit>(),
                builder: (context, notificationState) {
                  print('estado de notificacion: $notificationState');
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesApp.notification);
                    },
                    child: notificationState
                        ? Image.asset(ConstantsApp.bell)
                        : const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 28,
                          ),
                  );
                },
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: ConstantsApp.loginView,
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: state is! LoginSuccessState,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesApp.login);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Image.asset(
                                'assets/login/user.png',
                                scale: 1.7,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: state is LoginSuccessState,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesApp.profile);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Image.asset(
                                'assets/login/user-active.png',
                                scale: 1.7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
