// Dashboard data source - fetches data from a different API
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DashboardData {
  final String title;
  final String description;
  final String author;
  final String date;

  DashboardData({
    required this.title,
    required this.description,
    required this.author,
    required this.date,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      title: json['title']?.toString() ?? 'No Title',
      description: json['body']?.toString() ?? json['description']?.toString() ?? 'No Description',
      author: json['userId']?.toString() ?? json['name']?.toString() ?? json['author']?.toString() ?? 'Unknown',
      date: json['date']?.toString() ?? DateTime.now().toString(),
    );
  }
}

class DashboardRemoteDataSource {
  // Using JSONPlaceholder API for demo - you can change to any API
  Future<List<DashboardData>> fetchDashboardData() async {
    try {
      
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      debugPrint('🌐 DashboardRemote: Fetching from ${url.toString()}');
      
      // Add proper headers to avoid 403 errors
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'Mozilla/5.0 (compatible; FlutterApp/1.0)',
      };
      
      final response = await http.get(url, headers: headers).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          debugPrint('⏱️ DashboardRemote: Request timeout');
          throw Exception('Request timeout: Unable to fetch dashboard data. Please check your internet connection.');
        },
      );
      debugPrint('📡 DashboardRemote: Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          debugPrint('⚠️ DashboardRemote: Empty response body');
          throw Exception('Empty response from API');
        }
        
        try {
          final List<dynamic> jsonList = json.decode(response.body);
          debugPrint('📦 DashboardRemote: Parsed ${jsonList.length} items from JSON');
          if (jsonList.isEmpty) {
            debugPrint('⚠️ DashboardRemote: JSON list is empty');
            throw Exception('No data received from API');
          }
          // Limit to 5 items
          final limitedList = jsonList.take(5).toList();
          final data = limitedList.map((json) => DashboardData.fromJson(json as Map<String, dynamic>)).toList();
          debugPrint('✅ DashboardRemote: Successfully created ${data.length} DashboardData objects');
          return data;
        } on FormatException catch (e) {
          debugPrint('❌ DashboardRemote: JSON parsing error - ${e.toString()}');
          throw Exception('Invalid JSON response: ${e.toString()}');
        }
      } else if (response.statusCode == 403) {
        debugPrint('❌ DashboardRemote: 403 Forbidden - API access denied');
        // Return mock data as fallback for 403 errors
        debugPrint('🔄 DashboardRemote: Using fallback mock data');
        return _getMockData();
      } else {
        debugPrint('❌ DashboardRemote: HTTP error - Status code ${response.statusCode}');
        throw Exception('Failed to load dashboard data: Status code ${response.statusCode}');
      }
    } on SocketException catch (e) {
      debugPrint('❌ DashboardRemote: SocketException - ${e.toString()}');
      throw Exception('No internet connection. Please check your network.');
    } catch (e) {
      debugPrint('❌ DashboardRemote: Unexpected error - ${e.toString()}');
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Failed to load dashboard data: ${e.toString()}');
    }
  }

  // Fallback mock data when API is unavailable
  List<DashboardData> _getMockData() {
    return [
      DashboardData(
        title: 'Welcome to Dashboard',
        description: 'This is sample dashboard data. The API is currently unavailable, but you can still explore the app features.',
        author: '1',
        date: DateTime.now().toString(),
      ),
      DashboardData(
        title: 'Weather Updates',
        description: 'Check the weather page for real-time weather information from multiple cities around the world.',
        author: '2',
        date: DateTime.now().toString(),
      ),
      DashboardData(
        title: 'Notifications',
        description: 'Stay updated with push notifications. Tap on notifications to navigate directly to specific pages.',
        author: '3',
        date: DateTime.now().toString(),
      ),
      DashboardData(
        title: 'App Features',
        description: 'This app includes authentication, weather tracking, and notification management. Explore all the features!',
        author: '4',
        date: DateTime.now().toString(),
      ),
      DashboardData(
        title: 'Get Started',
        description: 'Navigate to the weather page using the arrow button in the header to see live weather data.',
        author: '5',
        date: DateTime.now().toString(),
      ),
    ];
  }
}

