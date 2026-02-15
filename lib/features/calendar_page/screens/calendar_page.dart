import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/enums/year_month_enums.dart';
import 'package:todo_app/core/utils/month_picker_custom.dart';
import 'package:todo_app/features/calendar_page/widgets/date_card_widget.dart';
import 'package:todo_app/features/calendar_page/widgets/task_widget.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage>
    with SingleTickerProviderStateMixin {
  final selectedDayProvider = StateProvider.autoDispose<int>((ref) => 0);
  final ScrollController daysScrollController = ScrollController();
  final dateProvider =
      StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
  final yearMonthProvider =
      StateProvider.autoDispose<YearMonth>((ref) => YearMonth.month);
  final activeIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
  List<String> tabTexts = ["All", "To Do", "In Progress", "Completed"];
  late final TabController tabController;

  List<Tab> tabs(
    double width,
    double height, {
    required int activeIndex,
    required ThemeData theme,
    required Radius radius,
  }) {
    return List.generate(
      tabTexts.length,
      (index) {
        final act = index == activeIndex;
        return Tab(
          child: Container(
            height: height * 0.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !act ? theme.primaryColor.withOpacity(0.2) : null,
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomLeft: radius,
                bottomRight: radius,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Text(tabTexts[index]),
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> taskWidgetValues = [
    {
      "taskGroup": "Office Project",
      "icon": Icons.cases_sharp,
      "task": "Market Research",
      "time": "10:00 AM",
      "status": 3,
      "iconColor": Colors.pink.shade500,
    },
    {
      "taskGroup": "Office Project",
      "icon": Icons.cases_sharp,
      "task": "Competitive Analysis",
      "time": "12:00 PM",
      "status": 2,
      "iconColor": Colors.pink.shade500,
    },
    {
      "taskGroup": "Personal Project",
      "icon": Icons.person,
      "task": "Create Low-fidelity Wireframe",
      "time": "07:00 PM",
      "status": 1,
      "iconColor": Colors.purple,
    },
    {
      "taskGroup": "Daily Study",
      "icon": Icons.menu_book_outlined,
      "task": "How to pitch a Design Sprint",
      "time": "09:00 PM",
      "status": 1,
      "iconColor": Colors.orange.shade800,
    },
  ];

  Widget tasks({
    required int activeIndex,
    required List<Map<String, dynamic>> filteredList,
    required double width,
    required double height,
  }) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06)
          .copyWith(bottom: height * 0.035),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        var value = filteredList[index];
        const noDataString = "No Data";
        final taskGroup = value['taskGroup'] ?? noDataString;
        final icon = value['icon'] ?? Icons.error;
        final task = value['task'] ?? noDataString;
        final time = value['time'] ?? noDataString;
        final status = value['status'] ?? 1;
        final iconColor = value['iconColor'] ?? Colors.red;

        return TaskWidget(
          taskGroup: taskGroup,
          icon: icon,
          task: task,
          time: time,
          status: status,
          iconColor: iconColor,
        );
      },
    );
  }

  List<List<Map<String, dynamic>>> generatedList = [];

  @override
  void initState() {
    super.initState();
    final now = ref.read(dateProvider);
    tabController = TabController(length: tabTexts.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        ref
            .read(activeIndexProvider.notifier)
            .update((state) => tabController.index);
      }
    });
    tabController.animation?.addListener(() {
      final value = tabController.animation?.value;
      final roundedValue = value?.round() ?? tabController.index;
      ref.read(activeIndexProvider.notifier).update((state) => roundedValue);
    });
    generatedList = List.generate(tabTexts.length, (index) {
      if (index == 0) {
        return taskWidgetValues;
      }
      return taskWidgetValues
          .where((element) => element['status'] == index)
          .toList();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final width = MediaQuery.of(context).size.width;
      final currentDayIndex = now.day - 1;
      ref.read(selectedDayProvider.notifier).update((state) => now.day - 1);

      // Auto-scroll to the current day after layout completes
      daysScrollController.animateTo(
        currentDayIndex *
            (width * 0.273), // Calculate position based on item width
        duration: const Duration(microseconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    tabController.animation?.removeListener(() {});
    tabController.removeListener(() {});
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final now = ref.watch(dateProvider);
    final thisMonth = DateFormat('MMM').format(now);
    final numberOfDays = DateTime(now.year, now.month + 1, 0).day;
    final days = List.generate(numberOfDays, (index) => index + 1);
    final iconSize = width > height ? width * 0.1 : height * 0.1;
    final selectedDay = ref.watch(selectedDayProvider);
    final theme = Theme.of(context);
    const radius = Radius.elliptical(20, 40);
    final primaryColor = theme.primaryColor;
    final activeIndex = ref.watch(activeIndexProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Daily Tasks"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            final val = await monthPickerCustomFun(
              context,
              startYear: 2000,
              endYear: 2100,
              currentDate: now,
            );
            if (val != null) {
              ref.read(dateProvider.notifier).state = val;
              ref.read(selectedDayProvider.notifier).update((state) => 0);
              daysScrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeInOut,
              );
            }
          },
          icon: const Icon(Icons.calendar_month),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Badge(
              isLabelVisible: true,
              alignment: Alignment.topRight,
              // label: Text('0'),
              smallSize: 18,
              backgroundColor: primaryColor,
              child: Icon(
                Icons.notifications,
                size: iconSize * 0.45,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.02),
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
          ),
          SizedBox(height: height * 0.03),
          TabBar(
            controller: tabController,
            tabs: tabs(
              width,
              height,
              activeIndex: activeIndex,
              theme: theme,
              radius: radius,
            ),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            indicator: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomLeft: radius,
                bottomRight: radius,
              ),
            ),
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
            dividerHeight: 0,
            unselectedLabelColor: primaryColor,
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: List.generate(
                tabTexts.length,
                (index) {
                  final filteredList = generatedList[index];
                  return tasks(
                    activeIndex: index,
                    filteredList: filteredList,
                    width: width,
                    height: height,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
