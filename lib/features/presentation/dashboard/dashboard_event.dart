abstract class DashboardEvent {}

class FetchDashboardDataEvent extends DashboardEvent {}

class AppPausedEvent extends DashboardEvent {}

class AppResumedEvent extends DashboardEvent {}

class DashboardItemHoverEvent extends DashboardEvent {
  final int index;
  final bool isHovering;

  DashboardItemHoverEvent({required this.index, required this.isHovering});
}
