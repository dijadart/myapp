import 'package:advanced_2/core/theming/app_colors.dart';
import 'package:advanced_2/core/theming/theme_provider.dart';
import 'package:advanced_2/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Temporary placeholders – replace later with real screens
class HomeContentView extends StatelessWidget {
  const HomeContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Content'));
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
                    Navigator.pushNamed(context, AppRoutes.login);
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