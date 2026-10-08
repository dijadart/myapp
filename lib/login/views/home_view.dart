import 'package:advanced_2/core/theming/app_colors.dart';
import 'package:advanced_2/core/theming/theme_provider.dart';
import 'package:advanced_2/login/login.dart';
import 'package:advanced_2/login/views/register_interview_page.dart';
import 'package:advanced_2/main.dart';
import 'package:advanced_2/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advanced_2/core/theming/app_colors.dart'; // if you have it

class HomeContentView extends StatelessWidget {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A0B2E), // deep purple
            Color(0xFF2D1B4E),
            Color(0xFF1A1225),
          ],
        ),
      ),
      child: Stack(
        children: [
          // subtle stars / dots
          ..._buildStars(),

          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),

                // Small label
                Text(
                  'A NEW KIND OF CLASSROOM',
                  style: TextStyle(
                    color: const Color(0xFFC084FC),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),

                SizedBox(height: 16.h),

                // Main headline
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      color: Colors.white,
                    ),
                    children: const [
                      TextSpan(text: 'We don’t teach\n'),
                      TextSpan(text: 'code.\n'),
                      TextSpan(
                        text: 'We launch minds.',
                        style: TextStyle(
                          color: Color(0xFFE879F9), // pink-purple
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Subtitle
                Text(
                  'Jupiter Academy turns curiosity into skill – kids write, build robots, and compete with confidence.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 15.sp,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32.h),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterInterviewPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC026D3),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Join us',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Navigate to courses tab or screen
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.4),
                            width: 1.5,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          'See courses',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Code window card
                _buildCodeCard(),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC026D3).withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Window header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F57)),
                SizedBox(width: 6.w),
                _dot(const Color(0xFFFEBC2E)),
                SizedBox(width: 6.w),
                _dot(const Color(0xFF28C840)),
                SizedBox(width: 12.w),
                Text(
                  "Today's class",
                  style: TextStyle(
                    color: const Color(0xFF4B5563),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Code area
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            color: const Color(0xFF1E1E2E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeLine(1, 'fun ', 'hello', '() {', highlight: true),
                _codeLine(2, '  print(', '"Hello, Jupiter"', ')', string: true),
                _codeLine(3, '}', '', ''),
              ],
            ),
          ),

          // Tags
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _tag('Coding'),
                _tag('Robotics'),
                _tag('Competitions'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10.w,
      height: 10.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _codeLine(int number, String part1, String part2, String part3,
      {bool highlight = false, bool string = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.w,
            child: Text(
              '$number',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 13.sp,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: part1,
                    style: TextStyle(
                      color: highlight
                          ? const Color(0xFFC084FC)
                          : Colors.white70,
                    ),
                  ),
                  TextSpan(
                    text: part2,
                    style: TextStyle(
                      color: string
                          ? const Color(0xFF4ADE80)
                          : const Color(0xFF60A5FA),
                    ),
                  ),
                  TextSpan(
                    text: part3,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF7C3AED),
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Widget> _buildStars() {
    // simple decorative dots
    final positions = [
      const Offset(0.1, 0.15),
      const Offset(0.85, 0.1),
      const Offset(0.7, 0.35),
      const Offset(0.2, 0.55),
      const Offset(0.9, 0.6),
      const Offset(0.4, 0.8),
      const Offset(0.15, 0.9),
      const Offset(0.75, 0.85),
    ];

    return positions.map((pos) {
      return Positioned(
        left: pos.dx * 400, // approximate, will look fine
        top: pos.dy * 700,
        child: Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        ),
      );
    }).toList();
  }
}

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Courses'));
  }
}

class MyBatchesView extends StatelessWidget {
  const MyBatchesView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('My Batches'));
  }
}

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications'));
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    final isLoggedIn = userState.isLoggedIn;
    final userProfile = userState.userProfile;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screens = isLoggedIn
        ? const [HomeContentView(), MyBatchesView(), NotificationsView()]
        : const [HomeContentView(), CoursesView()];

    final resolvedIndex = currentIndex >= screens.length ? 0 : currentIndex;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1A1225) // deep purple-black
          : AppColors.lightGray,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 220.w,
        backgroundColor: isDark ? const Color(0xFF1A1225) : AppColors.white,
        surfaceTintColor: Colors.transparent,
        leading: isLoggedIn
            ? Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: isDark
                            ? AppColors.primary.withOpacity(0.2)
                            : AppColors.softPurple,
                        backgroundImage: (userProfile?.profileURL != null &&
                                userProfile!.profileURL!.isNotEmpty)
                            ? NetworkImage(userProfile.profileURL!)
                            : null,
                        child: (userProfile?.profileURL == null ||
                                userProfile!.profileURL!.isEmpty)
                            ? Text(
                                (userProfile?.username.isNotEmpty == true
                                        ? userProfile!.username[0]
                                        : 'U')
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: Text(
                        userProfile?.username ?? 'User',
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login(visibilityProvider: visibilityProvider)));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                  ),
                  icon: Icon(Icons.login_rounded, size: 20.sp),
                  label: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
        actions: [
          // ── Dark / Light Mode Toggle ──
          IconButton(
            tooltip: isDark ? 'Light Mode' : 'Dark Mode',
            onPressed: () {
              ref.read(themeModeProvider.notifier).state =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.amber : AppColors.primary,
              size: 24.sp,
            ),
          ),
          
          // ── Logo ──
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Image.asset(
              'assets/images/Jupiter Logo raw.png',
              height: 38.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: screens[resolvedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF231833) : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(isDark ? 0.15 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: resolvedIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: AppColors.primary,
          unselectedItemColor: isDark ? Colors.grey[400] : AppColors.gray,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          type: BottomNavigationBarType.fixed,
          items: isLoggedIn
              ? [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded, size: 24.sp),
                    activeIcon: Icon(Icons.home_rounded, size: 26.sp),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded, size: 24.sp),
                    activeIcon: Icon(Icons.menu_book_rounded, size: 26.sp),
                    label: 'My Batches',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_rounded, size: 24.sp),
                    activeIcon: Icon(Icons.notifications_rounded, size: 26.sp),
                    label: 'Notifications',
                  ),
                ]
              : [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded, size: 24.sp),
                    activeIcon: Icon(Icons.home_rounded, size: 26.sp),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school_rounded, size: 24.sp),
                    activeIcon: Icon(Icons.school_rounded, size: 26.sp),
                    label: 'Courses',
                  ),
                ],
        ),
      ),
    );
  }
}

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

}