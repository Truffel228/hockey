// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final InAppReview inAppReview = InAppReview.instance;

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                      'Settings',
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
              SetTile(
                title: 'Privacy Policy',
                iconP: 'assets/check.svg',
                onTapped: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Showing(
                      url:
                          'https://docs.google.com/document/d/1PuEL9YqW7HfA3r9ZpcvFzru44tmh2P1P58_DMgHQg2c/edit?usp=sharing',
                      name: 'Privacy Policy',
                    ),
                  ),
                ),
              ),
              SetTile(
                title: 'Terms & Conditions',
                iconP: 'assets/chat.svg',
                onTapped: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Showing(
                      url:
                          'https://docs.google.com/document/d/1U9n2Q4ht5Q1EpQtteVd69qoTg-VeUiCkLlz-uqedYYE/edit?usp=sharing',
                      name: 'Terms & Conditions',
                    ),
                  ),
                ),
              ),
              SetTile(
                title: 'Support',
                iconP: 'assets/bag.svg',
                onTapped: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Showing(
                      url: 'https://forms.gle/WD4SqZQgL3qm2Kz98',
                      name: 'Support',
                    ),
                  ),
                ),
              ),
              SetTile(
                title: 'Rate App',
                iconP: 'assets/star.svg',
                onTapped: () =>
                    inAppReview.openStoreListing(appStoreId: '6472300004'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SetTile extends StatelessWidget {
  const SetTile(
      {super.key,
      required this.title,
      required this.iconP,
      required this.onTapped});
  final String title;
  final String iconP;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            SvgPicture.asset(iconP),
            const SizedBox(width: 24),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Showing extends StatefulWidget {
  final String url;
  final String name;

  const Showing({super.key, required this.url, required this.name});

  @override
  State<Showing> createState() => _ShowingState();
}

class _ShowingState extends State<Showing> {
  var _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source: "javascript:(function() { " +
                        "var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');" +
                        "ele[0].parentNode.removeChild(ele[0]);" +
                        "var footer = document.getelementsbytagname('footer')[0];" +
                        "footer.parentnode.removechild(footer);" +
                        "})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.url),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
