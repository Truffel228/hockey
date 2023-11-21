// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hockey_news/news/new_detailed.dart';
import 'package:intl/intl.dart';
import 'data.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

final List<String> _watched = [];

DateTime now = DateTime.now();

// Define the desired format
DateFormat dateFormat = DateFormat('MMMd');

String formattedDate = dateFormat.format(now);

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                    'Hockey news',
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
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => HockeyNew(
                hockeyNew: HoockeyNewsDataSource.news[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: HoockeyNewsDataSource.news.length,
            ),
          ],
        ),
      ),
    );
  }
}

class HockeyNew extends StatelessWidget {
  const HockeyNew({super.key, required this.hockeyNew});
  final HockeyNews hockeyNew;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailedHockeyNew(news: hockeyNew),
      )),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131313),
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                hockeyNew.path,
                width: 80,
                height: 60,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                hockeyNew.title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
