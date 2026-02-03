import 'package:flutter/material.dart';
import 'theme.dart';
import 'data_service.dart';
import 'models.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final DataService _dataService = DataService();
  final AuthService _authService = AuthService();

  String? _selectedCategoryId;
  late Future<List<Category>> _categoriesFuture;
  late Future<List<ClassSchedule>> _featuredFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _dataService.fetchCategories();
    _featuredFuture = _dataService.fetchFeaturedSchedules();
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
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    // Adaptive font scaling factor
    final fontScale = isLargeScreen ? 1.2 : 1.0;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _categoriesFuture = _dataService.fetchCategories();
              _featuredFuture = _dataService.fetchFeaturedSchedules();
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Greeting Column - Maximum priority
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Hola, $userName 👋',
                                style: textTheme.displayLarge!.copyWith(
                                  fontSize: 36, // Imposing size
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.2,
                                  height: 1.0,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '¿Listo para superar tus límites?',
                              style: textTheme.bodyMedium!.copyWith(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Logout Button
                      GestureDetector(
                        onTap: () async {
                          await _authService.signOut();
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Featured Classes Title
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Featured Classes',
                            style: textTheme.headlineMedium!.copyWith(
                              fontSize: 16 * fontScale, // Standard Level 2
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13, // Standard secondary level
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.primary,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Featured Classes Carousel
                Container(
                  height:
                      screenSize.height *
                      (isLargeScreen ? 0.45 : 0.38), // Increased for better fit
                  constraints: BoxConstraints(
                    maxHeight: isLargeScreen ? 420 : 360, // Increased
                    minHeight: isLargeScreen ? 340 : 280, // Increased
                  ),
                  child: FutureBuilder<List<ClassSchedule>>(
                    future: _featuredFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
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
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];
                          return FeaturedClassCard(
                            schedule: schedule,
                            onBook: () async {
                              try {
                                await _dataService.createBooking(schedule.id);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('¡Reserva confirmada!'),
                                  ),
                                );
                              } catch (e) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Categories
                FutureBuilder<List<Category>>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    final categories = snapshot.data ?? [];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Upcoming Classes',
                                style: textTheme.headlineMedium!.copyWith(
                                  fontSize: 16 * fontScale,
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(width: 8),
                              // Count bubble as seen in screenshot
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(10),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '5', // This should ideally be dynamic
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10 * fontScale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Upcoming Classes List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder<List<ClassSchedule>>(
                    future: _dataService.fetchUpcomingSchedules(
                      categoryId: _selectedCategoryId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final schedules = snapshot.data ?? [];
                      if (schedules.isEmpty) {
                        return const Center(
                          child: Text(
                            'No classes found',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }
                      return Column(
                        children: schedules
                            .map((s) => UpcomingClassCard(schedule: s))
                            .toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100), // Extra space for bottom nav
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
          top: 12,
        ),
        decoration: BoxDecoration(color: AppColors.background),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1D23),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(40),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary.withAlpha(100),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
