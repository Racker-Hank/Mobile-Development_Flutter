import 'package:flutter/material.dart';
import 'package:traveloka/entity/hotel.dart';

import '../../config/primitive_wrapper.dart';
import '../../config/ui_configs.dart';
import '../../repositories/user_data.dart';

class HotelViewHeaderButtons extends StatefulWidget {
  const HotelViewHeaderButtons({
    super.key,
    required this.parentWidgetContext,
    required this.isSaved,
    required this.hotel,
  });

  final BuildContext parentWidgetContext;
  final Hotel hotel;
  final PrimitiveWrapper<bool> isSaved;

  @override
  State<HotelViewHeaderButtons> createState() => _HotelViewHeaderButtonsState();
}

class _HotelViewHeaderButtonsState extends State<HotelViewHeaderButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(widget.parentWidgetContext),
            child: Icon(
              Icons.arrow_back_rounded,
              color: UIConfig.white,
            ),
          ),
          Row(
            children: [
              FutureBuilder(
                  future: UserFirebase.isSaved(widget.hotel.id),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () async {
                        await UserFirebase.saveHotel(
                            widget.hotel.id, widget.isSaved.value);
                        setState(() {
                          widget.isSaved.value = !widget.isSaved.value;
                        });
                      },
                      child: AnimatedCrossFade(
                        firstChild: Icon(
                          Icons.bookmark_border_rounded,
                          color: UIConfig.white,
                        ),
                        secondChild: Icon(
                          Icons.bookmark_rounded,
                          color: UIConfig.white,
                        ),
                        crossFadeState: snapshot.data ?? widget.isSaved.value
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                    );
                  }),
              const SizedBox(width: 16),
              Icon(
                Icons.share_rounded,
                color: UIConfig.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
