import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/calendar_page/widgets/date_card_widget.dart';
import 'package:todo_app/global/global_variables.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  final selectedDayProvider = StateProvider.autoDispose<int>((ref) => 0);
  final now = DateTime.now();
  final ScrollController daysScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentDayIndex = now.day - 1;
      ref.read(selectedDayProvider.notifier).update((state) => now.day - 1);

      // Auto-scroll to the current day after layout completes
      daysScrollController.animateTo(
        currentDayIndex *
            (width * 0.273), // Calculate position based on item width
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final thisMonth = DateFormat('MMM').format(now);
    final numberOfDays = DateTime(now.year, now.month + 1, 0).day;
    final days = List.generate(numberOfDays, (index) => index + 1);
    double iconSize = width > height ? width * 0.1 : height * 0.1;
    final selectedDay = ref.watch(selectedDayProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Tasks"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(
                  Icons.notifications,
                  size: iconSize * 0.45,
                ),
                Positioned(
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.05),
          Center(
            child: SizedBox(
              width: width,
              height: height * 0.14,
              child: Consumer(
                builder: (context, ref2, child) {
                  return ListView.builder(
                    controller: daysScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: numberOfDays,
                    itemBuilder: (context, index) {
                      final date = days[index];
                      final day = DateFormat("EEE")
                          .format(DateTime(now.year, now.month, date));
                      final selected = date == selectedDay + 1;

                      return GestureDetector(
                        onTap: () {
                          ref2
                              .read(selectedDayProvider.notifier)
                              .update((state) => index);
                        },
                        child: DateCardWidget(
                          month: thisMonth,
                          date: date,
                          day: day,
                          selected: selected,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
