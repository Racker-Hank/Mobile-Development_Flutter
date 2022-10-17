import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:traveloka/repositories/hotel_data.dart';

import '../components/button.dart';
import '../components/hotel_card.dart';
import '../components/search_bar.dart';
import '../config/ui_configs.dart';
import '../entity/hotel.dart';

final Stream<List<Hotel>> _hotelStream = HotelFirebase.readHotels();
List<Hotel> _hotelsSnapshot = [];
List<Hotel> hotels = List.from(_hotelsSnapshot);

late TextEditingController _hotel;
late TextEditingController _dateRange;
late TextEditingController _guests;

class AdvanceSearchBars extends StatefulWidget {
  const AdvanceSearchBars({Key? key, required this.expanded}) : super(key: key);
  final bool expanded;

  @override
  State<AdvanceSearchBars> createState() => _AdvanceSearchBarsState();
}

class _AdvanceSearchBarsState extends State<AdvanceSearchBars> with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dateRange = TextEditingController();
    _guests = TextEditingController();

    prepareAnimation();
    _runExpandCheck();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _dateRange.dispose();
    _guests.dispose();

    _expandController.dispose();
  }

  @override
  void didUpdateWidget(covariant AdvanceSearchBars oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  void prepareAnimation() {
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn
    );
  }

  void _runExpandCheck() {
    if(widget.expanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
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
    return Container(
      clipBehavior: Clip.none,
      child: SizeTransition(
        axisAlignment: 1,
        sizeFactor: animation,
        child: Visibility(
          visible: widget.expanded,
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
      ),
    );
  }
}

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> with SingleTickerProviderStateMixin {
  bool isAdvancedSearch = false;
  bool isShowResult = false;
  double cardWidth = 284;


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

  late final AnimationController _animationController;
  late final PageController _pageController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150)
    );
    _animationController.forward();
    super.initState();

    hotelBoxFocusNode.requestFocus();
    _hotel = TextEditingController();
    _pageController = PageController(viewportFraction: .77);

    _hotel.addListener(_search);

    isShowResult = false;
  }

  void _search() {
    //print(_hotel.text);
    setState(() {
      hotels = _hotelsSnapshot.where((element) =>
          element.name.toLowerCase().contains(_hotel.text.toLowerCase()))
          .toList();

      List<Hotel> searchByLocation = _hotelsSnapshot.where((element) =>
          element.location.toLowerCase().contains(_hotel.text.toLowerCase()))
          .toList();

      hotels = {...hotels, ...searchByLocation}.toList();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _hotel.dispose();
    _animationController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      transformHitTests: false,
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero
      ).animate(_animationController),
      child: Scaffold(
        body: ListView(
          // mainAxisSize: MainAxisSize.min,
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
                          _animationController.reverse().whenComplete(() => Navigator.pop(context));
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
                            AdvanceSearchBars(expanded: isAdvancedSearch,)
                          ],
                        ),
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
            // Expanded(
            SizedBox(
              height: 500,
              child: StreamBuilder<List<Hotel>>(
                  stream: _hotelStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // print(snapshot.error.toString());
                      return Text(snapshot.error.toString());
                    } else if (snapshot.connectionState == ConnectionState.active) {
                      _hotelsSnapshot = snapshot.data!;
                      //hotels = List.from(_hotelsSnapshot);

                      return Visibility(
                        visible: isShowResult,
                        replacement: Column(
                          children: [
                            SizedBox(
                              width: min(cardWidth, .77 * MediaQuery.of(context).size.width),
                              child: Text(
                                'Recommended',
                                style: UIConfig.indicationTextStyle,
                              ),
                            ),
                            HotelCard(
                              hotel: hotels.isNotEmpty ? hotels[0] : _hotelsSnapshot[0],
                              width: min(cardWidth, .77 * MediaQuery.of(context).size.width),
                              // width: 328,
                              height: 420,
                              hMargin: 8,
                              showFacilities: true,
                            ),
                          ],
                        ),
                        child: hotels.isEmpty ?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: Text(
                                '😖😖😖\nSorry, we\'ve got no item matching your search.\n😿😿😿',
                                style: TextStyle(
                                  color: UIConfig.accentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto'
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ) :
                          Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: min(cardWidth, .77 * MediaQuery.of(context).size.width - 16),
                              child: Text(
                                'Search results (${hotels.length})',
                                style: UIConfig.indicationTextStyle,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: PageView.builder(
                                controller: _pageController,
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
                            const SizedBox(height: 16),
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: hotels.length,
                              effect: WormEffect(
                                dotColor: UIConfig.primaryColor.withAlpha(100),
                                activeDotColor: UIConfig.accentColor,
                              ),
                              onDotClicked: (index) {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOutCubic);
                              },
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                        // child: Text(snapshot.connectionState.toString()),
                      );
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}