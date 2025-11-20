import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/weatherbloc.dart';
import 'package:flutterweather/features/presentation/bloc/weatherevent.dart' as weather_events;
import 'package:flutterweather/features/presentation/dashboard/dashboard_bloc.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_event.dart' as dashboard_events;

// class AppLifecycleObserver extends StatefulWidget {
//   final Widget child;

//   const AppLifecycleObserver({
//     super.key,
//     required this.child,
//   });

//   @override
//   State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
// }

// class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
//   late final AppLifecycleListener _listener;
//   WeatherBloc? _weatherBloc;
//   DashboardBloc? _dashboardBloc;

//   @override
//   void initState() {
//     super.initState();
//     _listener = AppLifecycleListener(
//       onShow: () => _handleTransition('show'),
//       onResume: () => _handleTransition('resume'),
//       onInactive: () => _handleTransition('inactive'),
//       onPause: () => _handleTransition('pause'),
//       onDetach: () => _handleTransition('detach'),
//       onStateChange: _handleStateChange,
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _weatherBloc = context.read<WeatherBloc>();
//     _dashboardBloc = context.read<DashboardBloc>();
//   }

//   @override
//   void dispose() {
//     _listener.dispose();
//     super.dispose();
//   }

//   void _handleTransition(String name) {
//     if (!mounted) return;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;

//       try {
//         switch (name) {
//           case 'pause':
//             _weatherBloc?.add(weather_events.AppPausedEvent());
//             _dashboardBloc?.add(dashboard_events.AppPausedEvent());
//             break;
//           case 'resume':
//             _weatherBloc?.add(weather_events.AppResumedEvent());
//             _dashboardBloc?.add(dashboard_events.AppResumedEvent());
//             break;
//           default:
//             break;
//         }
//       } catch (e, stackTrace) {
//         debugPrint('❌ AppLifecycleObserver: Exception in _handleTransition($name) - ${e.toString()}');
//         debugPrint('Stack trace: $stackTrace');
//         // Re-throw to allow exception handling upstream if needed
//         // Or handle gracefully based on your requirements
//       }
//     });
//   }

//   void _handleStateChange(AppLifecycleState state) {
//     // Handle state changes if needed
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }


class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  const AppLifecycleObserver({required this.child, super.key});

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.paused:
        debugPrint("App went to background");
        break;
      case AppLifecycleState.resumed:
        debugPrint("App is in foreground");
        break;
      case AppLifecycleState.detached:
        debugPrint("App is detached (may be killed)");
        break;
      case AppLifecycleState.inactive:
        debugPrint("App is inactive");
        break;
      case AppLifecycleState.hidden:
       
     debugPrint("App is hidden");

    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}



// class AppLifecyclePage extends StatefulWidget {
//   const AppLifecyclePage({super.key, required MaterialApp child});

//   @override
//   State<AppLifecyclePage> createState() => _AppLifecyclePageState();
// }

// class _AppLifecyclePageState extends State<AppLifecyclePage> {
//   late final AppLifecycleListener _listener;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the AppLifecycleListener class and pass callbacks
//     _listener = AppLifecycleListener(
//       onStateChange: _onStateChanged,
//     );
//   }

//   @override
//   void dispose() {
//     // Do not forget to dispose the listener
//     _listener.dispose();

//     super.dispose();
//   }

//   // Listen to the app lifecycle state changes
//   void _onStateChanged(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.detached:
//         _onDetached();
//       case AppLifecycleState.resumed:
//         _onResumed();
//       case AppLifecycleState.inactive:
//         _onInactive();
//       case AppLifecycleState.hidden:
//         _onHidden();
//       case AppLifecycleState.paused:
//         _onPaused();
//     }
//   }

//   void _onDetached() => print('detached');

//   void _onResumed() => print('resumed');

//   void _onInactive() => print('inactive');

//   void _onHidden() => print('hidden');

//   void _onPaused() => print('paused');

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Placeholder(),
//     );
//   }
// }