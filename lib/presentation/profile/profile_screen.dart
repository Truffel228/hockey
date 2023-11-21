// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_final_fields, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hockey_news/presentation/hockey_matches/data/hockey_repository.dart';
import 'package:hockey_news/presentation/widgets/hockey_match_item.dart';
import 'package:hockey_news/widgets/other/data.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String selectedDayString = '';
  final HockeyRepository dataRepository = HockeyRepository();
  final TextEditingController _textController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String _cachedName = 'Your name';
  @override
  void initState() {
    super.initState();
    _loadCachedName();
    selectedDayString = getFormattedToday();
  }

  void _loadCachedName() async {
    String? cachedEmail = await storage.read(key: 'name');
    if (cachedEmail != null) {
      setState(() {
        _cachedName = cachedEmail;
      });
    }
  }

  void _showEmailInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Enter Name'),
          content: Column(
            children: [
              CupertinoTextField(
                controller: _textController,
                keyboardType: TextInputType.emailAddress,
                placeholder: 'Your name',
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Save'),
              onPressed: () async {
                String email = _textController.text;
                if (email.isNotEmpty) {
                  // Save the email to secure storage
                  await storage.write(key: 'name', value: email);
                  setState(() {
                    _cachedName = email;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _now = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'User profile',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/ava.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        _cachedName,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _showEmailInputDialog();
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          color: const Color(0xFFFFA0A0).withOpacity(0.18),
                          child: const Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: Color(0xFFd51315),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            SingleChildScrollView(
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _now,
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _now = focusedDay;
                    selectedDayString = getFormattedDataFromDate(_selectedDay!);
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onPageChanged: (focusedDay) {
                  _now = focusedDay;
                },
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: GoogleFonts.poppins(
                      color: const Color(0xFFebebeb),
                    ),
                    titleCentered: true,
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, events) {
                    bool sameDay = isSameDay(date, _selectedDay);

                    return Container(
                      decoration: sameDay
                          ? const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFd51315),
                            )
                          : null,
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: sameDay ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) => Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFd51315),
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: dataRepository.matchesByDate(selectedDayString),
                builder: (context, snapshot) {
                  List<HockeyMatchModel> matchData = snapshot.data ?? [];

                  if (matchData.isEmpty) {
                    return const Text(
                      'No matches today.\n\nPlease, create our match or choose another day!',
                      textAlign: TextAlign.center,
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'No matches today.\n\nPlease, create our match or choose another day!',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 1.4,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: 8,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return HockeyMatchWidget(match: matchData[index]);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
