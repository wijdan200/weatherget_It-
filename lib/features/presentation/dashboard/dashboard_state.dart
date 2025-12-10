import 'package:flutterweather/features/data/datasource/dashboard_remote.dart';

abstract class DashboardState {
  final Map<int, bool> hoverStates;
  const DashboardState({this.hoverStates = const {}});
}

class DashboardInitial extends DashboardState {
  const DashboardInitial({super.hoverStates});
}

class DashboardLoading extends DashboardState {
  const DashboardLoading({super.hoverStates});
}

class DashboardLoaded extends DashboardState {
  final List<DashboardData> data;

  const DashboardLoaded(this.data, {super.hoverStates});
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message, {super.hoverStates});
}
