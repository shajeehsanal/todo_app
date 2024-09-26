import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/enums/year_month_enums.dart';
import 'package:todo_app/global/global_variables.dart';

Future<DateTime?> monthPickerCustomFun(
  BuildContext context, {
  required int startYear,
  required int endYear,
  required DateTime currentDate,
}) =>
    showDialog(
      context: context,
      builder: (context) => MonthPickerCustom(
        currentDate: currentDate,
        endYear: endYear,
        startYear: startYear,
      ),
    );

class MonthPickerCustom extends ConsumerStatefulWidget {
  final int startYear;
  final int endYear;
  final DateTime currentDate;
  const MonthPickerCustom({
    super.key,
    required this.currentDate,
    required this.endYear,
    required this.startYear,
  });

  @override
  ConsumerState<MonthPickerCustom> createState() => _MonthPickerCustomState();
}

class _MonthPickerCustomState extends ConsumerState<MonthPickerCustom> {
  final yearMonthProvider =
      StateProvider.autoDispose<YearMonth>((ref) => YearMonth.month);
  final dateProvider =
      StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

  late DateTime dateValue;

  @override
  void initState() {
    super.initState();
    dateValue = widget.currentDate;
  }

  @override
  Widget build(BuildContext context) {
    final yearsLength = (widget.endYear - widget.startYear) + 1;
    final yearMonth = ref.watch(yearMonthProvider);
    final isMonth = yearMonth == YearMonth.month;
    var list = isMonth
        ? List.generate(12, (index) => DateTime(dateValue.year, index + 1))
        : List.generate(
            yearsLength, (index) => DateTime(widget.startYear + index));
    final theme = Theme.of(context);

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
                  ref
                      .read(yearMonthProvider.notifier)
                      .update((state) => YearMonth.year);
                } else {
                  ref
                      .read(yearMonthProvider.notifier)
                      .update((state) => YearMonth.month);
                }
              },
              child: Text(
                DateFormat(isMonth ? 'yyyy' : 'MMMM').format(dateValue),
              ),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: SizedBox(
                height: height * 0.35,
                width: width * 0.6,
                child: GridView.builder(
                  itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: isMonth ? 1.5 : 1.8,
                    crossAxisSpacing: width * 0.01,
                    mainAxisSpacing: height * 0.01,
                  ),
                  itemBuilder: (context, index) {
                    final element = list[index];
                    final selectedMonth =
                        DateFormat(isMonth ? 'MMM' : 'yyyy').format(element);
                    final selected = yearMonth == YearMonth.month
                        ? dateValue.month == element.month
                        : dateValue.year == element.year;
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (!isMonth) {
                          ref
                              .read(yearMonthProvider.notifier)
                              .update((state) => YearMonth.month);
                        }
                        dateValue = element;
                        setState(() {});
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
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            ref.read(dateProvider.notifier).update((state) => dateValue);
            // ref
            //     .read(selectedDayProvider.notifier)
            //     .update((state) => dateValue.day - 1);
            // daysScrollController.animateTo(
            //   0,
            //   duration: const Duration(milliseconds: 1),
            //   curve: Curves.easeInOut,
            // );
            Navigator.pop(context, dateValue);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }

  Future<DateTime?> monthPickerCustom(
    BuildContext context,
    WidgetRef ref, {
    required int startYear,
    required int endYear,
    required DateTime currentDate,
  }) {
    DateTime dateValue = currentDate;
    final yearsLength = (endYear - startYear) + 1;
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref1, child) {
            final yearMonth = ref1.watch(yearMonthProvider);
            // final date = ref1.watch(dateProvider);
            final isMonth = yearMonth == YearMonth.month;
            var list = isMonth
                ? List.generate(
                    12, (index) => DateTime(dateValue.year, index + 1))
                : List.generate(
                    yearsLength, (index) => DateTime(startYear + index));
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
                                .format(dateValue),
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
                                crossAxisCount: 4,
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
                                    ? dateValue.month == element.month
                                    : dateValue.year == element.year;
                                return InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    if (!isMonth) {
                                      ref1
                                          .read(yearMonthProvider.notifier)
                                          .update((state) => YearMonth.month);
                                    }
                                    dateValue = element;
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
                            .update((state) => dateValue);
                        // ref
                        //     .read(selectedDayProvider.notifier)
                        //     .update((state) => dateValue.day - 1);
                        // daysScrollController.animateTo(
                        //   0,
                        //   duration: const Duration(milliseconds: 1),
                        //   curve: Curves.easeInOut,
                        // );
                        Navigator.pop(context, dateValue);
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
