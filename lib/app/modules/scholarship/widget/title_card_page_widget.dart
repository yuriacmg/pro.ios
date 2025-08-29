// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:perubeca/app/utils/constans.dart';

class TitleCardPageTwoWidget extends StatelessWidget {
  TitleCardPageTwoWidget({
    required this.title,
    this.subtitle,
    this.icon,
    this.isOffline = false,
    super.key,
  });
  String title;
  String? subtitle;
  String? icon;
  bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontFamily: ConstantsApp.OPSemiBold,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ConstantsApp.textBlackQuaternary,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Html(data: subtitle)),
            const SizedBox(
              width: 15,
            ),
            if (isOffline)
              Image.asset('assets/scholarship$icon')
            else
              CachedNetworkImage(
                imageUrl: icon!,
                // height: 60,
                // width: 60,
              ),
          ],
        ),
      ],
    );
  }
}
