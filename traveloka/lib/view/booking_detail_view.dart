import 'dart:html';

import 'package:flutter/material.dart';
import '../components/hotel_card.dart';
import '../entity/hotel.dart';
import '../config/UI_configs.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({
    super.key,
    required this.hotel,
  });

  final Hotel hotel;

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool isSaved = false;
  String heroImageURL = '';
  double imageSpacing = 4;

  @override
  Widget build(BuildContext context) {
    var smallImageWidth =
        (MediaQuery.of(context).size.width - imageSpacing * 4) / 5;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(
        children: [
          imagesContainer(context, smallImageWidth),
          headerButtons(context)
        ],
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 50),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: HeadLine(
                      hotelName: widget.hotel.name,
                      location: widget.hotel.location),
                ),
                Ratings(
                  avgRatings: widget.hotel.reviews.isNotEmpty
                      ? widget.hotel.reviews
                              .map((e) => e.rating)
                              .reduce((a, b) => a + b) /
                          widget.hotel.reviews.length
                      : 0,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              color: ,
              child: [
                Text()
              ],
            )
            // AnchorButtons(
            //   descriptionKey: descriptionKey,
            //   widget: widget,
            //   reviewsKey: reviewsKey,
            // ),
            // const SizedBox(height: 16),
            // ReadMoreText(
            //   key: descriptionKey,
            //   widget.hotel.description,
            //   style: UIConfig.bodyMediumTextStyle,
            //   trimCollapsedText: 'Expand',
            //   trimExpandedText: 'Collapse',
            //   moreStyle: UIConfig.indicationTextStyle,
            //   lessStyle: UIConfig.indicationTextStyle,
            // ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            // Directions(widget: widget),
            // const SizedBox(height: 16),
            // Reviews(
            //   reviewsKey: reviewsKey,
            //   widget: widget,
            // ),
          ],
        ),
      ),
    ]);
  }

  Container headerButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_rounded,
              color: UIConfig.white,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  isSaved = !isSaved;
                }),
                child: AnimatedCrossFade(
                  firstChild: Icon(
                    Icons.bookmark_border_rounded,
                    color: UIConfig.white,
                  ),
                  secondChild: Icon(
                    Icons.bookmark_rounded,
                    color: UIConfig.white,
                  ),
                  crossFadeState: isSaved
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
              ),
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

  Container imagesContainer(BuildContext context, double smallImageWidth) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(70, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            offset: Offset(0, 6),
            blurRadius: 10,
            spreadRadius: 4,
          ),
        ],
        color: UIConfig.screenBackgroundColor,
      ),
      child: Column(
        children: [
          Hero(
            tag: 'hotel${widget.hotel.id}_image',
            child: Container(
              height: MediaQuery.of(context).size.width * 2 / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(heroImageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: imageSpacing),
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                GestureDetector(
                  onTap: () => setState(() {
                    heroImageURL = widget.hotel.imageURLs[i];
                  }),
                  child: Container(
                    width: smallImageWidth,
                    height: smallImageWidth,
                    margin: EdgeInsets.only(right: imageSpacing),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.hotel.imageURLs[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  if (widget.hotel.imageURLs.length == 5) {
                    setState(() {
                      heroImageURL = widget.hotel.imageURLs[4];
                    });
                  }
                },
                child: Container(
                  width: smallImageWidth,
                  height: smallImageWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.hotel.imageURLs[4]),
                      fit: BoxFit.cover,
                      colorFilter: widget.hotel.imageURLs.length - 5 > 0
                          ? ColorFilter.mode(
                              UIConfig.black.withOpacity(.4),
                              BlendMode.softLight,
                            )
                          : null,
                    ),
                  ),
                  child: widget.hotel.imageURLs.length - 5 > 0
                      ? Center(
                          child: Text(
                            '+${widget.hotel.imageURLs.length - 4}',
                            style: TextStyle(
                              fontSize: 16,
                              color: UIConfig.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
                      : null,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
