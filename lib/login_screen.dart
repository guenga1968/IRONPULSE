import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'theme.dart';
import 'register_screen.dart';
import 'admin_navigation_wrapper.dart';
import 'auth_service.dart';
import 'ui/widgets/radical/asymmetric_layout.dart';
import 'ui/widgets/radical/luxury_button.dart';
import 'ui/animations/luxury_animations.dart';

// ================================================
// 🎨 LUXURY LOGIN SCREEN - Asymmetric 90/10
// ================================================
// Design Commitment: LUXURY + EXTREME ASYMMETRY
// Layout: 90% massive typography / 10% form (right edge)
// Geometry: 0px borders, sharp luxury
// Animation: Staggered reveal + spring physics
// ================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Welcome back, Athlete'),
            backgroundColor: LuxuryColors.gold,
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminNavigationWrapper(),
          ),
        );
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: LuxuryColors.error,
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred'),
            backgroundColor: LuxuryColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: LuxuryColors.pureBlack,
      body: AsymmetricSplit(
        primaryOnLeft: false, // Form on right (10%)
        splitRatio: 0.35, // 35% form, 65% typography (adjusted for mobile)
        dividerColor: LuxuryColors.gold,
        dividerWidth: 2,

        // 65% LEFT: Massive Typography Background
        secondaryChild: Container(
          color: LuxuryColors.pureBlack,
          child: Stack(
            children: [
              // Massive "IRON PULSE" text as background
              Positioned(
                top: size.height * 0.15,
                left: -20,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'IRON',
                    style: TextStyle(
                      fontSize: size.width * 0.25, // Responsive massive text
                      fontWeight: FontWeight.w900,
                      color: LuxuryColors.gold.withValues(alpha: 0.08),
                      letterSpacing: -8,
                      height: 0.9,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.35,
                left: -20,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'PULSE',
                    style: TextStyle(
                      fontSize: size.width * 0.25,
                      fontWeight: FontWeight.w900,
                      color: LuxuryColors.brandCyan.withValues(alpha: 0.08),
                      letterSpacing: -8,
                      height: 0.9,
                    ),
                  ),
                ),
              ),

              // Decorative gold line
              Positioned(
                top: size.height * 0.6,
                left: 40,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(_fadeAnimation),
                  child: Container(
                    width: size.width * 0.3,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          LuxuryColors.gold,
                          LuxuryColors.gold.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Tagline
              Positioned(
                bottom: 60,
                left: 40,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PREMIUM',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          color: LuxuryColors.gold,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'FITNESS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                          color: LuxuryColors.textSecondary,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 35% RIGHT: Login Form (Compressed)
        primaryChild: Container(
          color: LuxuryColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),

                // Welcome Text
                LuxuryAnimations.staggeredReveal(
                  delay: const Duration(milliseconds: 150),
                  children: [
                    Text(
                      'WELCOME',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: LuxuryColors.textPrimary,
                            fontSize: 32,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'BACK',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: LuxuryColors.gold, fontSize: 32),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Access your training',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: LuxuryColors.textSecondary,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Email Field
                    _LuxuryTextField(
                      label: 'EMAIL',
                      hint: 'athlete@ironpulse.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),

                    // Password Field
                    _LuxuryTextField(
                      label: 'PASSWORD',
                      hint: '••••••••',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: LuxuryColors.gold,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: LuxuryTextButton(
                        text: 'FORGOT PASSWORD?',
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: LuxuryButton(
                        onPressed: _isLoading ? null : _signIn,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: LuxuryColors.pureBlack,
                                ),
                              )
                            : const Text('SIGN IN'),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: LuxuryColors.textPrimary.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 10,
                              color: LuxuryColors.textTertiary,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: LuxuryColors.textPrimary.withValues(
                              alpha: 0.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Sign Up Link
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'New athlete? ',
                            style: TextStyle(
                              color: LuxuryColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: LuxuryColors.gold,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

// ================================================
// LUXURY TEXT FIELD - Sharp gold-focused input
// ================================================

class _LuxuryTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _LuxuryTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w100,
            color: LuxuryColors.gold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: LuxuryColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}
