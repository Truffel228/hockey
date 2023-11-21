import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hockey_news/news/hockey_news_data_source.dart';
import 'package:hockey_news/widgets/other/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final remoteConfig = FirebaseRemoteConfig.instance;
Future<bool> checkMatchesData() async {
  try {
    await remoteConfig.fetchAndActivate();
    final String showing = remoteConfig.getString('show');
    if (showing.contains('isShow')) {
      return false;
    } else {
      isMatchesShow = showing;
      return true;
    }
  } catch (e) {
    return false;
  }
}

class HockeyRepository {
  final String apiKey = '6b5e993ad23a4d155b992de4e5db82a6';
  final String apiHost = 'v3.football.api-sports.io';
  final String endpoint = 'fixtures';

  Future<List<HockeyMatchModel>> matches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastUpdateDate = prefs.getString('lastUpdateDate') ?? '';
    final String todayDate = getFormattedToday();
    if (lastUpdateDate != todayDate) {
      final response = await http.get(
        Uri.https(apiHost, endpoint, {'date': todayDate}),
        headers: {
          'x-rapidapi-host': apiHost,
          'x-rapidapi-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await prefs.setString('lastUpdateDate', todayDate);
        await prefs.setString('cachedData', json.encode(data));
        return (data['response'] as List<dynamic>)
            .map((e) => HockeyMatchModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final String cachedData = prefs.getString('cachedData') ?? '';
      if (cachedData.isNotEmpty) {
        final data = json.decode(cachedData);
        return (data['response'] as List<dynamic>)
            .map((e) => HockeyMatchModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Cached data is empty');
      }
    }
  }

  Future<List<HockeyMatchModel>> matchesByDate(String date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastUpdateDate = prefs.getString('lastUpdateDate') ?? '';
    if (lastUpdateDate != date) {
      final response = await http.get(
        Uri.https(apiHost, endpoint, {'date': date}),
        headers: {
          'x-rapidapi-host': apiHost,
          'x-rapidapi-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await prefs.setString('lastUpdateDate', date);
        await prefs.setString('cachedData', json.encode(data));
        return (data['response'] as List<dynamic>)
            .map((e) => HockeyMatchModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final String cachedData = prefs.getString('cachedData') ?? '';
      if (cachedData.isNotEmpty) {
        final data = json.decode(cachedData);
        return (data['response'] as List<dynamic>)
            .map((e) => HockeyMatchModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Cached data is empty');
      }
    }
  }
}

class HockeyMatchModel {
  const HockeyMatchModel({
    required this.homeTeamTitle,
    required this.homeTeamLogo,
    required this.awayTeamTitle,
    required this.awayTeamLogo,
    required this.time,
    required this.league,
  });
  final String homeTeamTitle;
  final String homeTeamLogo;
  final String awayTeamTitle;
  final String awayTeamLogo;
  final DateTime time;
  final String league;

  factory HockeyMatchModel.fromJson(Map<String, dynamic> json) =>
      HockeyMatchModel(
        homeTeamTitle: json['teams']['home']['name'],
        homeTeamLogo: json['teams']['home']['logo'],
        awayTeamTitle: json['teams']['away']['name'],
        awayTeamLogo: json['teams']['away']['logo'],
        time: DateTime.fromMillisecondsSinceEpoch(
          json['fixture']['timestamp'] * 1000,
        ),
        league: json['league']['name'],
      );
}
