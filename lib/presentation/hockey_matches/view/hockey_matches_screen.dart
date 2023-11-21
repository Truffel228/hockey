// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hockey_news/presentation/hockey_matches/data/hockey_repository.dart';
import 'package:hockey_news/presentation/widgets/hockey_match_item.dart';

class HockeyMatchesScreen extends StatefulWidget {
  const HockeyMatchesScreen({super.key});

  @override
  _HockeyMatchesScreenState createState() => _HockeyMatchesScreenState();
}

class _HockeyMatchesScreenState extends State<HockeyMatchesScreen> {
  final HockeyRepository dataRepository = HockeyRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dataRepository.matches(),
        builder: (context, snapshot) {
          final List<HockeyMatchModel> matchData = snapshot.data ?? [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Text(
                'No matches on this day.\nCreate our match or choose another day!');
          }

          if (matchData.isEmpty) {
            return const Text(
                'No matches on this day.\nCreate our match or choose another day!');
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              const SizedBox(height: 30),
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
                      'Hockey matches',
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
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'TODAY',
                      style: TextStyle(
                        color: Color.fromARGB(255, 56, 56, 56),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  10,
                  (index) => HockeyMatchWidget(
                    match: matchData[index],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
