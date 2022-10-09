import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
<<<<<<< HEAD
import 'package:traveloka/config/ui_configs.dart';
=======
import 'package:traveloka/repositories/hotel_firebase.dart';
>>>>>>> 682e5ba8f811be49b3519aab5851a7a413297309

import '../components/button.dart';
import '../components/hotel_card.dart';
import '../components/search_bar.dart';
import '../entity/hotel.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> with SingleTickerProviderStateMixin {
  bool isAdvancedSearch = false;
  bool isShowResult = false;

  FocusNode hotelBoxFocusNode = FocusNode();

  Icon leftIcon = Icon(
    Icons.arrow_back_rounded,
    color: UIConfig.darkGrey,
    size: 20,
  );
  Icon rightIcon = Icon(
    Icons.tune_rounded,
    color: UIConfig.primaryColor,
    size: 20,
  );

  late final TextEditingController _hotel;
  late final TextEditingController _dateRange;
  late final TextEditingController _guests;
  late final AnimationController _animationController;

  // List hotels = Hotel.hotels;

  double cardWidth = 284;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 170)
    );
    Timer(const Duration(milliseconds: 0), () => _animationController.forward());

    super.initState();

    hotelBoxFocusNode.requestFocus();
    _hotel = TextEditingController();
    _dateRange = TextEditingController();
    _guests = TextEditingController();

    isShowResult = false;
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 7,
    ),
  );

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime.now(),
        lastDate: DateTime(
          DateTime.now().year + 2,
          DateTime.now().month,
          DateTime.now().day,
        ),
        builder: (context, child) {
          return Column(
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: UIConfig.accentColor,
                    onPrimary: UIConfig.white,
                    onSurface: UIConfig.primaryColor,
                    surface: UIConfig.accentColor,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: UIConfig.white,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: UIConfig.borderRadius,
                      color: Colors.transparent,
                    ),
                    height: 520,
                    width: MediaQuery.of(context).size.width * .9,
                    child: child,
                  ),
                ),
              ),
            ],
          );
        });
    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
    });

    String dateFormat =
    dateRange.start.year == dateRange.end.year ? 'MMMd' : 'MMM d, yy';
    _dateRange.text =
    '${DateFormat(dateFormat).format(dateRange.start)} - ${DateFormat(dateFormat).format(dateRange.end)}';
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero
      ).animate(_animationController),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LeftRoundIconButton(
                        icon: leftIcon,
                        function: () {
                          _animationController.reverse();
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            SearchBox(
                              controller: _hotel,
                              prefixIcon: Icon(
                                Icons.pin_drop,
                                color: UIConfig.primaryColor,
                                size: 20,
                              ),
                              suffix: Align(
                                alignment: Alignment.centerRight,
                                widthFactor: 1,
                                // heightFactor: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    _hotel.text = '';
                                    setState(() {
                                      isShowResult = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.cancel_rounded,
                                    color: Color(0xFF79747e),
                                    size: 16,
                                  ),
                                ),
                              ),
                              hintText: 'traveloka🚀',
                              labelText: 'Search for a location',
                              focusNode: hotelBoxFocusNode,
                              focussed: () {},
                            ),
                            Visibility(
                              visible: isAdvancedSearch,
                              // replacement: ,
                              child: Column(
                                children: [
                                  const SizedBox(height: 24),
                                  SearchBox(
                                    controller: _dateRange,
                                    focussed: pickDateRange,
                                    prefixIcon: Icon(
                                      Icons.calendar_month_rounded,
                                      color: UIConfig.primaryColor,
                                      size: 20,
                                    ),
                                    labelText: 'Pick a date',
                                    hintText:
                                    '${DateFormat('MMMd').format(dateRange.start)} - ${DateFormat('MMMd').format(dateRange.end)}',
                                  ),
                                  const SizedBox(height: 24),
                                  SearchBox(
                                    controller: _guests,
                                    focussed: () {},
                                    prefixIcon: Icon(
                                      Icons.people_rounded,
                                      color: UIConfig.primaryColor,
                                      size: 20,
                                    ),
                                    labelText: 'Guests',
                                    hintText: 2,
                                    keyboardType: TextInputType.number,
                                    suffix: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            int guests = int.parse(
                                                _guests.text.isNotEmpty
                                                    ? _guests.text
                                                    : '0');
                                            guests++;
                                            _guests.text = '$guests';
                                          },
                                          child: Icon(
                                            Icons.add_rounded,
                                            color: UIConfig.primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          '|',
                                          style:
                                          TextStyle(color: UIConfig.darkGrey),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            int guests = int.parse(
                                                _guests.text.isNotEmpty
                                                    ? _guests.text
                                                    : '0');
                                            if (guests > 1) {
                                              guests--;
                                              _guests.text = '$guests';
                                            } else {}
                                          },
                                          child: Icon(
                                            Icons.remove_rounded,
                                            color: UIConfig.primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
<<<<<<< HEAD
                      const SizedBox(width: 16),
                      RightRoundIconButton(
                        icon: rightIcon,
                        function: () {
                          setState(() {
                            isAdvancedSearch = !isAdvancedSearch;
                          });
                          hotelBoxFocusNode.requestFocus();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Button(
                    function: () {
                      debugPrint(
                          '${_hotel.text} ${_dateRange.text} ${_guests.text}');
                      setState(() {
                        isShowResult = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            Expanded(
              child: Visibility(
                visible: isShowResult,
                replacement: Column(
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: Text(
                        'Recommended',
                        style: UIConfig.indicationTextStyle,
                      ),
                    ),
                    HotelCard(
                      hotel: hotels[0],
                      // hotelID: hotels[0].id,
                      // imageURL: hotels[0].imageURL,
                      // hotelName: hotels[0].name,
                      // location: hotels[0].location,
                      // ratings: hotels[0].ratings,
                      // price: hotels[0].price,
                      // description: hotels[0].description,
                      width: cardWidth,
                      // width: 328,
                      height: 420,
                      hMargin: 8,
                      showFacilities: true,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: Text(
                        'Search results (${hotels.length})',
                        style: UIConfig.indicationTextStyle,
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: PageController(viewportFraction: .77),
                        itemCount: hotels.length,
                        // separatorBuilder: (context, index) => const SizedBox(
                        //   width: 16,
                        // ),
                        // addAutomaticKeepAlives: false,
                        // cacheExtent: 100,
                        // padding: const EdgeInsets.symmetric(vertical: 30),
                        // padding: EdgeInsets.fromLTRB(39, 16, 39, 16),

                        // scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, i) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HotelCard(
                                hotel: hotels[i],
                                // hotelID: hotels[i].id,
                                // imageURL: hotels[i].imageURL,
                                // hotelName: hotels[i].name,
                                // location: hotels[i].location,
                                // ratings: hotels[i].ratings,
                                // price: hotels[i].price,
                                // description: hotels[i].description,
                                width: cardWidth,
                                // width: 328,
                                height: 420,
                                hMargin: 8,
                                showFacilities: true,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
=======
                    ),
                    const SizedBox(width: 16),
                    RightRoundIconButton(
                      icon: rightIcon,
                      function: () {
                        setState(() {
                          isAdvancedSearch = !isAdvancedSearch;
                        });
                        hotelBoxFocusNode.requestFocus();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Button(
                  function: () {
                    debugPrint(
                        '${_hotel.text} ${_dateRange.text} ${_guests.text}');
                    setState(() {
                      isShowResult = true;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          Expanded(
            child: StreamBuilder<List<Hotel>>(
                stream: HotelFirebase.readHotels(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    // print(snapshot.error.toString());
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    final hotels = snapshot.data!;

                    return Visibility(
                      visible: isShowResult,
                      replacement: Column(
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: Text(
                              'Recommended',
                              style: UIConfig.indicationTextStyle,
                            ),
                          ),
                          HotelCard(
                            hotel: hotels[0],
                            width: cardWidth,
                            // width: 328,
                            height: 420,
                            hMargin: 8,
                            showFacilities: true,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: Text(
                              'Search results (${hotels.length})',
                              style: UIConfig.indicationTextStyle,
                            ),
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: PageController(viewportFraction: .77),
                              itemCount: hotels.length,
                              itemBuilder: ((context, i) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HotelCard(
                                      hotel: hotels[i],
                                      width: cardWidth,
                                      // width: 328,
                                      height: 420,
                                      hMargin: 8,
                                      showFacilities: true,
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                      // child: Text(snapshot.connectionState.toString()),
                    );
                  }
                }),
          ),
        ],
>>>>>>> 682e5ba8f811be49b3519aab5851a7a413297309
      ),
    );
  }
}