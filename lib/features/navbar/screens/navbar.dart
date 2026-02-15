import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/common/coming_soon.dart';
import 'package:todo_app/features/calendar_page/screens/calendar_page.dart';
import 'package:todo_app/features/home/screens/home.dart';
import 'package:todo_app/features/navbar/widgets/navbar_icons.dart';
import 'package:todo_app/features/profile/screens/profile.dart';

class NavBar extends ConsumerStatefulWidget {
  const NavBar({super.key});

  @override
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  final selectedIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final width = size.width;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    const whiteColor = Colors.white;

    return Scaffold(
      body: getWidget(selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomAppBar(
          color: primaryColor.withOpacity(0.2),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomNavbarItem(
                icon: Icons.home,
                activeColor: primaryColor,
                inactiveColor: whiteColor,
                isActive: selectedIndex == 0,
                onPressed: () {
                  ref.read(selectedIndexProvider.notifier).update((state) => 0);
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: CustomNavbarItem(
                  icon: Icons.calendar_month,
                  activeColor: primaryColor,
                  inactiveColor: whiteColor,
                  isActive: selectedIndex == 1,
                  onPressed: () {
                    ref
                        .read(selectedIndexProvider.notifier)
                        .update((state) => 1);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: CustomNavbarItem(
                  icon: CupertinoIcons.doc_text_fill,
                  activeColor: primaryColor,
                  inactiveColor: whiteColor,
                  isActive: selectedIndex == 2,
                  onPressed: () {
                    ref
                        .read(selectedIndexProvider.notifier)
                        .update((state) => 2);
                  },
                ),
              ),
              CustomNavbarItem(
                icon: Icons.people,
                activeColor: primaryColor,
                inactiveColor: whiteColor,
                isActive: selectedIndex == 3,
                onPressed: () {
                  ref.read(selectedIndexProvider.notifier).update((state) => 3);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget getWidget(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CalendarPage();
      case 2:
        return const ComingSoonPage();
      case 3:
        return const Profile();
      default:
        return const SizedBox();
    }
  }
}
