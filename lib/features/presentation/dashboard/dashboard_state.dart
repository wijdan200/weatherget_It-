import 'package:flutterweather/features/data/datasource/dashboard_remote.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<DashboardData> data;
  
  DashboardLoaded(this.data);
}

class DashboardError extends DashboardState {
  final String message;
  
  DashboardError(this.message);
}

