import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterweather/features/domain/repository/dashboard_repo.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_event.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;
  bool _isLoading = false;

  DashboardBloc(this.repository) : super(DashboardInitial()) {
    on<FetchDashboardDataEvent>((event, emit) async {
      if (_isLoading) {
        return;
      }

      _isLoading = true;
      emit(DashboardLoading());
      
      try {
        final data = await repository.fetchDashboardData();
        if (data.isEmpty) {
          emit(DashboardError('No data available'));
        } else {
          debugPrint('✅ DashboardBloc: Data loaded successfully');
          emit(DashboardLoaded(data));
        }
      } catch (e) {
        debugPrint('❌ DashboardBloc: Error - ${e.toString()}');
        emit(DashboardError(e.toString()));
      } finally {
        _isLoading = false;
      }
    });

    on<AppPausedEvent>((event, emit) {
      debugPrint('📱 DashboardBloc: Application paused');
    });

    on<AppResumedEvent>((event, emit) {
      debugPrint('📱 DashboardBloc: Application resumed');
    });
  }
}

