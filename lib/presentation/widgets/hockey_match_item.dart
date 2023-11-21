import 'package:flutter/material.dart';
import 'package:hockey_news/presentation/hockey_matches/data/hockey_repository.dart';
import 'package:intl/intl.dart';

class HockeyMatchWidget extends StatelessWidget {
  const HockeyMatchWidget({super.key, required this.match});

  final HockeyMatchModel match;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = match.time;
    Duration remainingTime = dateTime.difference(DateTime.now());

    int hours = remainingTime.inHours;
    int minutes = remainingTime.inMinutes.remainder(60);

    final timeLeft = '$hours h $minutes min';

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF222232)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    timeLeft,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF545560),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    match.homeTeamLogo,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    match.homeTeamTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                DateFormat('HH:mm').format(match.time),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    match.league,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF545560),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    match.awayTeamLogo,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    match.awayTeamTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
