// Dashboard repository implementation
    import 'package:flutterweather/features/data/datasource/dashboard_remote.dart';
import 'package:flutterweather/features/domain/repository/dashboard_repo.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<DashboardData>> fetchDashboardData() async {
    return await remoteDataSource.fetchDashboardData();
  }
}

