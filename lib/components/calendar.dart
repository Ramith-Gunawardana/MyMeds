import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';

class TopCalendar extends StatelessWidget {
  // Function onDateChange;

  TopCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return TimelineCalendar(
      calendarType: CalendarType.GREGORIAN,
      calendarLanguage: "en",
      calendarOptions: CalendarOptions(
        viewType: ViewType.DAILY,
        toggleViewType: false,
        headerMonthElevation: 0,
        weekStartDate:
            DateTime(today.year, today.month, today.day - (today.weekday - 1)),
        weekEndDate:
            DateTime(today.year, today.month, today.day - today.weekday % 7),
        // headerMonthShadowColor: Theme.of(context).colorScheme.secondary,
        // headerMonthBackColor: Theme.of(context).colorScheme.primary,
        // weekStartDate: today.subtract(
        //   Duration(days: today.weekday - 3),
        // ),
        // weekEndDate: today.add(
        //   Duration(days: today.weekday + 3),
        // ),
      ),
      dayOptions: DayOptions(
        compactMode: true,
        dayFontSize: 15,
        weekDaySelectedColor: Theme.of(context).colorScheme.primary,
        selectedBackgroundColor: Theme.of(context).colorScheme.primary,
        // differentStyleForToday: true,
        disableDaysBeforeNow: false,
      ),
      headerOptions: HeaderOptions(
          weekDayStringType: WeekDayStringTypes.SHORT,
          monthStringType: MonthStringTypes.FULL,
          backgroundColor: Colors.transparent,
          headerTextColor: Colors.black),
      onChangeDateTime: (datetime) {
        print(datetime.getDate());
        // onDateChange();
      },
    );
  }
}
