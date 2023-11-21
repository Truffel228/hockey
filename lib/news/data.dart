class HoockeyNewsDataSource {
  static const List<HockeyNews> news = [
    HockeyNews(
      title: "THE LATEST PATRICK KANE SPECULATION IN MID-NOVEMBER",
      description:
          "Last week came word that Patrick Kane could be getting closer to deciding on which NHL team he'll play for this season. On Thursday, Daily Faceoff's Frank Seravalli indicated the 35-year-old free-agent winger could make his choice by the end of this week.\n\nAs many as eight clubs are believed to have expressed an interest in Kane, including the Buffalo Sabres, Dallas Stars and Toronto Maple Leafs. However, those three teams could be out of the running.",
      path:
          "https://thehockeynews.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MTk5MTc2MTk3MTY5NDg5MzEw/usatsi_20575698.webp",
    ),
    HockeyNews(
      title:
          "NHL NUGGET: LUNDQVIST BRIEFLY ENTERED THE TOP FIVE FOR ALL-TIME NHL WINS THIS DAY IN 2019",
      description:
          "Here's today's NHL Nugget – this Milestone Monday goes back to Nov. 20, 2019, when Henrik Lundqvist briefly became a top-five netminder in all-time NHL wins. Marc-Andre Fleury took that spot from him later in the 2019-20 season.",
      path:
          "https://thehockeynews.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MjAyMzUxMjcyNjgxMDIyNTMy/usatsi_13698787_168400847_lowres.webp",
    ),
    HockeyNews(
      title:
          "SLEEPERS AND KEEPERS PODCAST: WHOSE FANTASY HOCKEY VALUES ARE QUICKLY CLIMBING OR SINKING?",
      description:
          "Fantasy hockey experts Jason Chen and Michael Amato discuss injuries to Barrett Hayton and Tage Thompson, returns for Aaron Ekblad and Brandon Montour, values rising for a couple players and two others whose values are sinking.\n\nWelcome to the 11th episode of The Hockey News Sleepers and Keepers fantasy hockey podcast. As we enter Week 7 of the NHL season, check out the weekly primer and strength of schedule here.",
      path:
          "https://thehockeynews.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MjAyMzQ5ODAxMTE3ODUyNzQw/usatsi_21921385_168400847_lowres.webp",
    ),
    HockeyNews(
      title:
          "THN ARCHIVE: IN 1964, LEAFS, RANGERS COLLABORATE ON SEVEN-PLAYER BLOCKBUSTER TRADE",
      description:
          "Nearly 60 years ago, the Toronto Maple Leafs and New York Rangers engaged in a seven-player trade. The Leafs would go on to win the Stanley Cup that season, but this deal benefitted both teams.\n\nAs rumors swirl about the Toronto Maple Leafs making a big splash in the trade market this season, it’s a good time to harken back to THN’s Feb. 29, 1964, edition – Vol. 17, Issue 22 – which chronicled a blockbuster trade between the Leafs and New York Rangers.",
      path:
          "https://thehockeynews.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MjAyMzMwNDg3NzIzNjY0Mzk2/vol17iss22-thn-archive.webp",
    ),
    HockeyNews(
      title: "TIDES SHIFT AROUND THE NHL AS KRAKEN DOWN CANUCKS",
      description:
          "The Seattle Kraken are just one of a handful of NHL teams rebounding after a slow start, including the Winnipeg Jets, Washington Capitals and Florida Panthers.\n\nAfter a slow start to the season, the Seattle Kraken are starting to get into gear.\n\nSaturday night, the third-year expansion team handed the Vancouver Canucks their first regulation loss of the year on home ice, winning by a 4-3 score at Rogers Arena.",
      path:
          "https://thehockeynews.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_700/MjAyMzI1OTExNDM2MDEwNTA4/usatsi_21933463_168400847_lowres.webp",
    ),
  ];
}

class HockeyNews {
  final String title;
  final String description;
  final String path;

  const HockeyNews({
    required this.title,
    required this.description,
    required this.path,
  });
}

String isMatchesShow = '';
