import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/enums/year_month_enums.dart';
import 'package:todo_app/features/calendar_page/widgets/date_card_widget.dart';
import 'package:todo_app/global/global_variables.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  final selectedDayProvider = StateProvider.autoDispose<int>((ref) => 0);
  // final now = DateTime.now();
  final ScrollController daysScrollController = ScrollController();
  final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());
  final yearMonthProvider = StateProvider<YearMonth>((ref) => YearMonth.month);

  @override
  void initState() {
    super.initState();
    final now = ref.read(dateProvider);
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
    final now = ref.watch(dateProvider);
    final thisMonth = DateFormat('MMM').format(now);
    final numberOfDays = DateTime(now.year, now.month + 1, 0).day;
    final days = List.generate(numberOfDays, (index) => index + 1);
    double iconSize = width > height ? width * 0.1 : height * 0.1;
    final selectedDay = ref.watch(selectedDayProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Daily Tasks"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            ref
                .read(yearMonthProvider.notifier)
                .update((state) => YearMonth.month);
            pickMonth();
          },
          icon: const Icon(Icons.calendar_month),
        ),
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

  Future<void> pickMonth() {
    DateTime dateProviderValue = ref.read(dateProvider);
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref1, child) {
            final yearMonth = ref1.watch(yearMonthProvider);
            final date = ref1.watch(dateProvider);
            final isMonth = yearMonth == YearMonth.month;
            var list = isMonth
                ? List.generate(12, (index) => DateTime(date.year, index + 1))
                : List.generate(100, (index) => DateTime(2001 + index));
            final theme = Theme.of(context);

            return StatefulBuilder(
              builder: (context, stSt) {
                return AlertDialog(
                  title: Text(
                    "Select ${yearMonth.value}",
                    style: TextStyle(color: theme.primaryColor),
                  ),
                  content: SizedBox(
                    height: height * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (isMonth) {
                              ref1
                                  .read(yearMonthProvider.notifier)
                                  .update((state) => YearMonth.year);
                            } else {
                              ref1
                                  .read(yearMonthProvider.notifier)
                                  .update((state) => YearMonth.month);
                            }
                          },
                          child: Text(
                            DateFormat(isMonth ? 'yyyy' : 'MMMM')
                                .format(dateProviderValue),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Expanded(
                          child: SizedBox(
                            height: height * 0.35,
                            width: width * 0.6,
                            child: GridView.builder(
                              itemCount: list.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isMonth ? 4 : 5,
                                childAspectRatio: isMonth ? 1.5 : 1.8,
                                crossAxisSpacing: width * 0.01,
                                mainAxisSpacing: height * 0.01,
                              ),
                              itemBuilder: (context, index) {
                                final element = list[index];
                                final selectedMonth =
                                    DateFormat(isMonth ? 'MMM' : 'yyyy')
                                        .format(element);
                                final selected = yearMonth == YearMonth.month
                                    ? dateProviderValue.month == element.month
                                    : dateProviderValue.year == element.year;
                                return InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    if (!isMonth) {
                                      ref1
                                          .read(yearMonthProvider.notifier)
                                          .update((state) => YearMonth.month);
                                    }
                                    dateProviderValue = element;
                                    stSt(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? theme.primaryColor.withOpacity(0.7)
                                          : null,
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      selectedMonth,
                                      style: TextStyle(
                                        color: selected
                                            ? theme.scaffoldBackgroundColor
                                            : theme.disabledColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.red)),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(dateProvider.notifier)
                            .update((state) => dateProviderValue);
                        ref
                            .read(selectedDayProvider.notifier)
                            .update((state) => dateProviderValue.day - 1);
                        daysScrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
