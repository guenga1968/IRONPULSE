import 'package:flutter/material.dart';
import 'theme.dart';
import 'core/responsive/layout_values.dart';
import 'core/themes/adaptive_typography.dart';
import 'widgets/layout/fluid_grid.dart';
import 'widgets/layout/master_container.dart';
import 'widgets/adaptive/adaptive_button.dart';
import 'widgets/adaptive/adaptive_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: MasterContainer(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Admin Header
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: LayoutValues.getPadding(context),
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/gym_hero.png',
                          ), // Placeholder
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.background,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WELCOME BACK',
                            style: AdaptiveTypography.bodySmall(context)
                                .copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Admin Portal',
                            style: AdaptiveTypography.headlineSmall(context)
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        AdaptiveButton(
                          isSecondary: true,
                          padding: const EdgeInsets.all(12),
                          onPressed: () {},
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Metrics Grid
            SliverToBoxAdapter(
              child: FluidGrid(
                children: [
                  _AdminMetricCard(
                    icon: Icons.calendar_today_rounded,
                    label: 'Scheduled\nClasses',
                    value: '8',
                    tag: 'Today',
                    context: context,
                  ),
                  _AdminMetricCard(
                    icon: Icons.pie_chart_rounded,
                    label: 'Occupancy\nRate',
                    value: '92%',
                    trend: '+ 5%',
                    progress: 0.92,
                    context: context,
                  ),
                  _AdminMetricCard(
                    label: 'TOTAL STUDENTS',
                    value: '142',
                    trend: '+12%',
                    isDetailed: true,
                    context: context,
                  ),
                  _AdminMetricCard(
                    label: 'ACTIVE TYPES',
                    value: '24',
                    tag: 'types',
                    isDetailed: true,
                    context: context,
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Quick Actions
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QUICK ACTIONS',
                    style: AdaptiveTypography.bodySmall(context).copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: AdaptiveButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline_rounded, size: 20),
                              SizedBox(width: 8),
                              Text('Create Class'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: AdaptiveButton(
                          isSecondary: true,
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month_rounded, size: 20),
                              SizedBox(width: 8),
                              Text('Calendar'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Happening Now Section
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HAPPENING NOW',
                    style: AdaptiveTypography.bodySmall(context).copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: AppColors.primary, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            SliverToBoxAdapter(child: _AdminLiveClassCard(context: context)),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _AdminMetricCard extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  final String? tag;
  final String? trend;
  final double? progress;
  final bool isDetailed;
  final BuildContext context;

  const _AdminMetricCard({
    this.icon,
    required this.label,
    required this.value,
    this.tag,
    this.trend,
    this.progress,
    this.isDetailed = false,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                if (tag != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Text(
                      tag!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ),
                if (trend != null)
                  Text(
                    trend!,
                    style: const TextStyle(
                      color: AppColors.success,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          if (isDetailed) ...[
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AdaptiveTypography.headlineLarge(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
              if (!isDetailed && value.endsWith('%')) ...[
                const SizedBox(width: 2),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    '%',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
              if (isDetailed && trend != null) ...[
                const SizedBox(width: 8),
                Text(
                  trend!,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              if (isDetailed && tag != null && trend == null) ...[
                const SizedBox(width: 4),
                Text(
                  tag!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
          if (!isDetailed) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
          if (progress != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white10,
                color: AppColors.primary,
                minHeight: 4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AdminLiveClassCard extends StatelessWidget {
  final BuildContext context;
  const _AdminLiveClassCard({required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/gym_hero.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withAlpha(80), Colors.black.withAlpha(200)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withAlpha(200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: Colors.white, size: 8),
                    SizedBox(width: 6),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'HIIT w/ Sarah',
              style: AdaptiveTypography.headlineSmall(
                context,
              ).copyWith(color: Colors.white, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.access_time_filled,
                  color: Colors.white70,
                  size: 14,
                ),
                const SizedBox(width: 6),
                const Text(
                  '10:00 AM - 11:00 AM',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '15/20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 30,
                  child: Stack(
                    children: [
                      for (int i = 0; i < 3; i++)
                        Positioned(
                          left: i * 15.0,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/gym_hero.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Text(
                  '+12',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Manage Class',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
