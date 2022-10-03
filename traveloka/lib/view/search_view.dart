import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/button.dart';
import '../components/location_card.dart';
import '../components/search_bar.dart';
import '../config/UI_configs.dart';
import '../entity/hotel.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  bool isAdvancedSearch = false;

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

  List hotels = Hotel.hotels;

  @override
  void initState() {
    super.initState();

    hotelBoxFocusNode.requestFocus();
    _hotel = TextEditingController();
    _dateRange = TextEditingController();
    _guests = TextEditingController();
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
    return Scaffold(
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
                                  focussed: () {},
                                ),
                              ],
                            ),
                          ),
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
                    print('${_hotel.text} ${_dateRange.text} ${_guests.text}');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          Expanded(
            child: PageView.builder(
              controller: PageController(viewportFraction: .8),
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
                      hotelID: hotels[i].id,
                      imageURL: hotels[i].imageURL,
                      hotelName: hotels[i].hotelName,
                      location: hotels[i].location,
                      ratings: hotels[i].ratings,
                      price: hotels[i].price,
                      description: hotels[i].description,
                      width: 284,
                      height: 420,
                      hMargin: 8,
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}