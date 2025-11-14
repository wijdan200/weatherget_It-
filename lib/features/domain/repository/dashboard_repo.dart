// Dashboard repository interface
import '../../data/datasource/dashboard_remote.dart';

abstract class DashboardRepository {
  Future<List<DashboardData>> fetchDashboardData();
}

