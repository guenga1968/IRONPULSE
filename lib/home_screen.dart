import 'package:flutter/material.dart';
import 'theme.dart';
import 'data_service.dart';
import 'models.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'widgets.dart';

import 'core/responsive/layout_values.dart';
import 'core/themes/adaptive_typography.dart';
import 'widgets/layout/fluid_grid.dart';
import 'widgets/layout/master_container.dart';
import 'widgets/adaptive/adaptive_button.dart';
import 'widgets/adaptive/adaptive_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  final AuthService _authService = AuthService();

  String? _selectedCategoryId;
  late Future<List<Category>> _categoriesFuture;
  late Future<List<ClassSchedule>> _featuredFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _categoriesFuture = _dataService.fetchCategories();
      _featuredFuture = _dataService.fetchFeaturedSchedules();
    });
  }

  void _onCategorySelected(String? categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final userMetadata = user?.userMetadata;
    final userName =
        userMetadata?['full_name'] ?? user?.email?.split('@')[0] ?? 'Athlete';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MasterContainer(
        child: RefreshIndicator(
          onRefresh: () async => _refreshData(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Adaptive Header
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: LayoutValues.getPadding(context),
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hola, $userName 👋',
                              style: AdaptiveTypography.displayLarge(
                                context,
                              ).copyWith(color: Colors.white, height: 1.0),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '¿Listo para superar tus límites?',
                              style: AdaptiveTypography.bodyMedium(
                                context,
                              ).copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      AdaptiveButton(
                        isSecondary: true,
                        onPressed: () async {
                          await _authService.signOut();
                          if (!context.mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Icon(Icons.logout_rounded, size: 20),
                      ),
                    ],
                  ),
                ),
              ),

              // Featured Classes Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Classes',
                        style: AdaptiveTypography.headlineMedium(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Featured Carousel (Fluid Grid in Desktop)
              SliverToBoxAdapter(
                child: FutureBuilder<List<ClassSchedule>>(
                  future: _featuredFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: AppColors.error),
                        ),
                      );
                    }
                    final schedules = snapshot.data ?? [];
                    if (schedules.isEmpty) {
                      return const Center(
                        child: Text(
                          'No featured classes today',
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }

                    return SizedBox(
                      height:
                          LayoutValues.getLayoutFactor(context) *
                          220, // Adaptive height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: schedules.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: LayoutValues.getMargin(context) - 10,
                        ),
                        itemBuilder: (context, index) => FeaturedClassCard(
                          schedule: schedules[index],
                          onBook: () {},
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Categories Filter
              SliverToBoxAdapter(
                child: FutureBuilder<List<Category>>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    final categories = snapshot.data ?? [];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          AppFilterChip(
                            label: 'All Classes',
                            isActive: _selectedCategoryId == null,
                            onTap: () => _onCategorySelected(null),
                          ),
                          ...categories.map(
                            (cat) => Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: AppFilterChip(
                                label: cat.name,
                                isActive: _selectedCategoryId == cat.id,
                                onTap: () => _onCategorySelected(cat.id),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Upcoming Classes Section
              SliverToBoxAdapter(
                child: Text(
                  'Upcoming Classes',
                  style: AdaptiveTypography.headlineMedium(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              FutureBuilder<List<ClassSchedule>>(
                future: _dataService.fetchUpcomingSchedules(
                  categoryId: _selectedCategoryId,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Error loading classes: ${snapshot.error}',
                          style: const TextStyle(color: AppColors.error),
                        ),
                      ),
                    );
                  }
                  final schedules = snapshot.data ?? [];

                  return SliverToBoxAdapter(
                    child: FluidGrid(
                      children: schedules
                          .map(
                            (s) => AdaptiveCard(
                              padding: const EdgeInsets.all(0),
                              child: UpcomingClassCard(schedule: s),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
