import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/presentation/assets/svgs.dart';
import 'package:news_app/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBar(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 19),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.border.withOpacity(0.9),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  icon: Svgs.news,
                  isActive: navigationShell.currentIndex == 0,
                  onTap: () => _onTap(0),
                ),
                _buildNavItem(
                  icon: Svgs.selectedNews,
                  isActive: navigationShell.currentIndex == 1,
                  onTap: () => _onTap(1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget _buildNavItem({
    required String icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          isActive ? AppColors.primary : AppColors.inactiveButton,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
