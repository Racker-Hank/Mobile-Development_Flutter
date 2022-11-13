import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traveloka/entity/booking.dart';
import '../../components/button.dart';
import '../../components/hotel_card.dart';
import '../../config/primitive_wrapper.dart';
import '../../entity/hotel.dart';
import '../../config/ui_configs.dart';
import '../../repositories/booking_data.dart';
import '../../repositories/user_data.dart';
import '../hotel/hotel_view_header_buttons.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({
    super.key,
    required this.hotel,
    this.booking,
    this.defaultDateRange,
  });

  final Hotel hotel;
  final Booking? booking;
  final DateTimeRange? defaultDateRange;

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool isSaved = false;
  double imageSpacing = 4;
  late DateTimeRange dateRange;

  late final TextEditingController _guests;
  late FocusNode guestFocusNode;

  @override
  void initState() {
    _guests = TextEditingController();
    _guests.text = '2';
    guestFocusNode = FocusNode();
    dateRange = widget.defaultDateRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 7,
          ),
        );

    UserFirebase.isSaved(widget.hotel.id).then((value) => setState(() {
          isSaved = value;
        }));

    super.initState();
  }

  @override
  void dispose() {
    _guests.dispose();
    guestFocusNode.dispose();

    super.dispose();
  }

  // DateTimeRange dateRange = DateTimeRange(
  //   start: DateTime.now(),
  //   end: DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day + 7,
  //   ),
  // );

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
  }

  @override
  Widget build(BuildContext context) {
    var dateRangeInDay = dateRange.duration.inDays;

    return Scaffold(
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(8)),
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
                child: Hero(
                  tag: 'hotel${widget.hotel.id}_image',
                  child: Container(
                    height: MediaQuery.of(context).size.width * 2 / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.hotel.imageURLs[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // headerButtons(context)
              HotelViewHeaderButtons(
                parentWidgetContext: context,
                isSaved: PrimitiveWrapper(isSaved),
                hotel: widget.hotel,
              ),
            ],
          ),
          Container(
            // margin: const EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.width * 2 / 3,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HeadLine(
                            hotelName: widget.hotel.name,
                            location: widget.hotel.location,
                          ),
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
                      decoration: BoxDecoration(
                        color: const Color(0xFFDADDE3),
                        borderRadius: UIConfig.borderRadius,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Booking ID: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                  color: UIConfig.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Booked on: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                  color: UIConfig.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.booking!.id,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  color: UIConfig.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('MMM d, yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  color: UIConfig.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking detail',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: UIConfig.black),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 16, right: 16, bottom: 16),
                              child: Icon(Icons.calendar_month_rounded),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                      color: UIConfig.black,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('MMM d, yyyy').format(dateRange.start)} - ${DateFormat('MMM d, yyyy').format(dateRange.end)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: UIConfig.black,
                                    ),
                                  ),
                                  Text(
                                    '($dateRangeInDay night${dateRangeInDay > 1 ? 's' : ''})',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: UIConfig.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (!widget.booking!.status)
                              GestureDetector(
                                onTap: pickDateRange,
                                child: Icon(
                                  Icons.border_color_rounded,
                                  color: UIConfig.primaryColor,
                                ),
                              )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 16, right: 16, bottom: 16),
                              child: Icon(Icons.people_rounded),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Guests',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.normal,
                                        color: UIConfig.black),
                                  ),
                                  TextField(
                                    controller: _guests,
                                    focusNode: guestFocusNode,
                                    keyboardType: TextInputType.number,
                                    readOnly: widget.booking!.status,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: 'Insert number of guests',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFB9B9B9),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        color: UIConfig.black),
                                  )
                                ],
                              ),
                            ),
                            if (!widget.booking!.status)
                              GestureDetector(
                                onTap: () => guestFocusNode.requestFocus(),
                                child: Icon(
                                  Icons.border_color_rounded,
                                  color: UIConfig.primaryColor,
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: UIConfig.accentColor,
                      thickness: 2,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: UIConfig.black,
                          ),
                        ),
                        Text(
                          '\$${dateRangeInDay * widget.hotel.price}',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: UIConfig.accentColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                if (!widget.booking!.status)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BookingFirebase.cancelBooking(widget.booking!.id);
                          // setState(() {
                          //   dateRange = DateTimeRange(
                          //     start: DateTime.now(),
                          //     end: DateTime(
                          //       DateTime.now().year,
                          //       DateTime.now().month,
                          //       DateTime.now().day + 7,
                          //     ),
                          //   );

                          //   _guests.text = '2';
                          // });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDC362E),
                            borderRadius: UIConfig.borderRadius,
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
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cancel',
                                style: UIConfig.buttonTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Button(
                        label: 'Confirm',
                        function: () {
                          BookingFirebase.confirmBooking(widget.booking!.id);
                          setState(() {
                            widget.booking!.status = true;
                          });
                          // Navigator.of(context).pop();
                        },
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
