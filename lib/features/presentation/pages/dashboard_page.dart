import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_event.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../dashboard/dashboard_bloc.dart';
import '../dashboard/dashboard_state.dart';
import '../../data/datasource/dashboard_remote.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutterweather/l10n/app_localizations.dart';

//
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    print("CLK dashboard page");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (mounted) {
          context.read<DashboardBloc>().add(FetchDashboardDataEvent());
          FlutterNativeSplash.remove();
        }
      } catch (e) {
        debugPrint(
          '❌ DashboardPage: Error fetching data in initState - ${e.toString()}',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFF1E3C72)],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardError) {
                return _buildErrorState(state.message);
              }

              if (state is DashboardLoaded) {
                return _buildLoadedState(state.data);
              }

              if (state is DashboardLoading) {
                return _buildSkeletonLoading();
              }

              return _buildSkeletonLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildSkeletonCard();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  context.go('/weather');
                },
                tooltip: AppLocalizations.of(context)!.back_to_weather,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dashboard_title,
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!.latest_updates,
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              context.go('/weather');
            },
            tooltip: AppLocalizations.of(context)!.go_to_weather,
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 10),
            Container(
              height: 15,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            const SizedBox(height: 8),
            Container(height: 15, width: 250, color: Colors.grey[200]),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 12, width: 100, color: Colors.grey[200]),
                Container(height: 12, width: 80, color: Colors.grey[200]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(List<DashboardData> data) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _buildDataCard(
                    data[index],
                    index,
                    state.hoverStates[index] ?? false,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDataCard(DashboardData item, int index, bool isHovered) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + (index * 800)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(-50 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => context.read<DashboardBloc>().add(
          DashboardItemHoverEvent(index: index, isHovering: true),
        ),
        onExit: (_) => context.read<DashboardBloc>().add(
          DashboardItemHoverEvent(index: index, isHovering: false),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          transform: isHovered
              ? (Matrix4.identity()..scale(1.02))
              : Matrix4.identity(),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.blue.shade50],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.2 : 0.1),
                blurRadius: isHovered ? 15 : 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.article,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        item.title,
                        style: GoogleFonts.getFont(
                          'Lato',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3C72),
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  item.description,
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          '${AppLocalizations.of(context)!.user_label} ${item.author}',
                          style: GoogleFonts.getFont(
                            'Lato',
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${AppLocalizations.of(context)!.post_label}${item.author}',
                          style: GoogleFonts.getFont(
                            'Lato',
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.error_loading_data,
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color(0xFF1E3C72),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 16,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DashboardBloc>().add(FetchDashboardDataEvent());
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.retry),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                backgroundColor: Color(0xFF667EEA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => context.go('/weather'),
              child: Text(AppLocalizations.of(context)!.skip_to_weather),
            ),
          ],
        ),
      ),
    );
  }
}
