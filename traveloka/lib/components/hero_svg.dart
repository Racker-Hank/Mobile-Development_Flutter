import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/ui_configs.dart';
import 'clip_path.dart';

class HeroSvg extends StatefulWidget {
  const HeroSvg({super.key});

  @override
  State<HeroSvg> createState() => _HeroSvgState();
}

class _HeroSvgState extends State<HeroSvg> {
  int svgIndex = Random().nextInt(3) + 1;
  String path = '../../assets/';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const CustomClipPath(),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
          child: Column(
            children: [
              Container(
                height: 320,
                child: SvgPicture.asset(
                  '$path$svgIndex.svg',
                  // width: MediaQuery.of(context).size.width - 128,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'traveloka',
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 36,
                  color: UIConfig.primaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
