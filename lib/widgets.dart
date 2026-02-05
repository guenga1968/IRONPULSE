import 'package:flutter/material.dart';
import 'theme.dart';
import 'models.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.white54, size: 20),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// LUXURY FEATURED CLASS CARD - Premium depth card
class FeaturedClassCard extends StatelessWidget {
  final ClassSchedule schedule;
  final VoidCallback onBook;

  const FeaturedClassCard({
    super.key,
    required this.schedule,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = (screenSize.width * 0.80).clamp(240.0, 300.0);
    final isVeryNarrow = screenSize.width < 360;

    final gymClass = schedule.gymClass;
    final title = gymClass?.name ?? 'Clase';
    final intensity = gymClass?.intensity.name.toUpperCase() ?? 'MEDIUM';
    final instructor = schedule.instructor?.name ?? 'Coach - No Info';
    final time = schedule.formattedTime;
    final duration = schedule.duration;
    final spotsText = schedule.isFull
        ? 'FULL'
        : '${schedule.availableSpots} SPOTS';

    final imageUrl = gymClass?.imageUrl;
    final ImageProvider backgroundImage;
    if (imageUrl != null && imageUrl.startsWith('http')) {
      backgroundImage = NetworkImage(imageUrl);
    } else if (imageUrl != null && imageUrl.startsWith('assets/')) {
      backgroundImage = AssetImage(imageUrl);
    } else {
      backgroundImage = const AssetImage('assets/images/gym_hero.png');
    }

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: LuxuryColors.surface,
        borderRadius: BorderRadius.zero, // Sharp 0px
        border: const Border(
          top: BorderSide(color: LuxuryColors.gold, width: 3), // Gold accent
        ),
        boxShadow: DepthSystem.depth4, // Premium depth
        image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isVeryNarrow ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spots indicator
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: LuxuryColors.pureBlack.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.zero,
                  border: Border.all(
                    color: schedule.isFull
                        ? LuxuryColors.error
                        : LuxuryColors.success,
                    width: 1,
                  ),
                ),
                child: Text(
                  spotsText,
                  style: TextStyle(
                    color: schedule.isFull
                        ? LuxuryColors.error
                        : LuxuryColors.success,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const Spacer(),

            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Intensity badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: LuxuryColors.brandCyan.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.zero,
                    border: Border.all(color: LuxuryColors.brandCyan, width: 1),
                  ),
                  child: Text(
                    intensity,
                    style: const TextStyle(
                      color: LuxuryColors.brandCyan,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Title
                Text(
                  title,
                  style: TextStyle(
                    color: LuxuryColors.textPrimary,
                    fontSize: isVeryNarrow ? 18 : 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Instructor
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: LuxuryColors.gold,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        instructor,
                        style: const TextStyle(
                          color: LuxuryColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Time
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: LuxuryColors.gold,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$time • $duration',
                      style: const TextStyle(
                        color: LuxuryColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Book button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: schedule.isFull ? null : onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LuxuryColors.pureBlack,
                      foregroundColor: LuxuryColors.gold,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: LuxuryColors.gold, width: 2),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'RESERVAR',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: isVeryNarrow ? 14 : 16,
                        letterSpacing: 1.5,
                      ),
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

// LUXURY FILTER CHIP - Sharp gold-bordered chip
class AppFilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? LuxuryColors.pureBlack : LuxuryColors.surface,
          borderRadius: BorderRadius.zero, // Sharp 0px
          border: Border.all(
            color: isActive
                ? LuxuryColors.gold
                : LuxuryColors.textTertiary.withValues(alpha: 0.3),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isActive ? LuxuryColors.gold : LuxuryColors.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

// LUXURY UPCOMING CLASS CARD - Depth card with cyan accent
class UpcomingClassCard extends StatelessWidget {
  final ClassSchedule schedule;

  const UpcomingClassCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isVeryNarrow = screenSize.width < 360;

    final gymClass = schedule.gymClass;
    final title = gymClass?.name ?? 'Clase';
    final isToday = schedule.startTime.day == DateTime.now().day;
    final time = schedule.formattedTime;
    final instructor = schedule.instructor?.name ?? 'Coach - No Info';
    final duration = schedule.duration;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        horizontal: isVeryNarrow ? 12 : 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: LuxuryColors.surface,
        borderRadius: BorderRadius.zero, // Sharp 0px
        border: Border.all(
          color: LuxuryColors.brandCyan.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: DepthSystem.depth2, // Subtle depth
      ),
      child: Row(
        children: [
          // Left: Time & Day
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: LuxuryColors.pureBlack,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: LuxuryColors.gold, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isToday ? 'TODAY' : 'TMRW',
                  style: const TextStyle(
                    color: LuxuryColors.gold,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    color: LuxuryColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Center: Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: LuxuryColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 13,
                      color: LuxuryColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        instructor,
                        style: const TextStyle(
                          color: LuxuryColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.access_time,
                      size: 13,
                      color: LuxuryColors.brandCyan,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: LuxuryColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right: Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: LuxuryColors.brandCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.zero,
              border: Border.all(color: LuxuryColors.brandCyan, width: 1),
            ),
            child: const Text(
              'OPEN',
              style: TextStyle(
                color: LuxuryColors.brandCyan,
                fontWeight: FontWeight.w900,
                fontSize: 9,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
