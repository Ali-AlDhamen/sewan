import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/theme/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  // ====== Constructor ======
  const HomeScreen({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('home_screen'));

  // ====== Fields ======
  final StatefulNavigationShell navigationShell;

  // ====== Methods ======
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  // ====== Widget ======
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = ref.watch(themeControllerProvider);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        // backgroundColor: AppTheme.whiteColor,
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        height: 100.h - MediaQuery.of(context).padding.bottom,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "home",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.local_activity),
            icon: Icon(Icons.local_activity_outlined),
            label: "Track",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.card_giftcard),
            icon: Icon(Icons.card_giftcard_outlined),
            label: "Redeem",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.cabin_outlined),
            icon: Icon(Icons.cabin),
            label: "Membership",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
