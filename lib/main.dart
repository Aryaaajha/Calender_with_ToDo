import 'package:assignmenr2/AddToDo.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCalendarApp(),
    );
  }
}

class MyCalendarApp extends StatefulWidget {
  @override
  _MyCalendarAppState createState() => _MyCalendarAppState();
}

class _MyCalendarAppState extends State<MyCalendarApp> {
  bool _isExpanded = false;
  String _currentMonth = DateFormat.MMMM().format(DateTime.now());
  List<TaskItem> _pendingTasks = [
  ];
  List<TaskItem> _completedTasks = [
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _handleHeaderTapped();
                    },
                    child: Text(
                      _currentMonth,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarFormat: _isExpanded ? CalendarFormat.month : CalendarFormat.week,
              headerVisible: false,
              onFormatChanged: (format) {
                // Optional: Handle format changes
              },
              onPageChanged: (DateTime focusedDay) {
                _updateMonthName(focusedDay);
              },
              onHeaderTapped: (selectedMonth) {
                _handleHeaderTapped();
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Round corners
              ),) ,
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(_isExpanded ? 'Collapse Calendar' : 'Expand Calendar'),
            ),
            if (!_isExpanded) // Show this only when the calendar is in the collapsed form

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's ToDo",
                      style: TextStyle(fontSize: 18,color: Colors.blue),
                    ),
                    Text(
                      _formattedDate(DateTime.now()),
                      style: TextStyle(fontSize: 14,color: Colors.blue),
                    ),
                  ],
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pending:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _pendingTasks.length,
                    itemBuilder: (context, index) {
                      if (_pendingTasks.isEmpty) {
                        return ListTile(
                          title: Text("No task added", style: TextStyle(color: Colors.black)),
                        );
                      } else {
                      return ListTile(
                        leading: Icon(Icons.assignment_outlined, color: Colors.black),
                        title: Text(_pendingTasks[index].text),
                        trailing: IconButton(
                          icon: _pendingTasks[index].isChecked
                              ? Icon(Icons.check_circle, color: Colors.blue)
                              : Icon(Icons.circle_outlined, color: Colors.blue),
                          onPressed: () {
                            _toggleTask(index);
                          },
                        ),
                      );
    }
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Completed:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  for (TaskItem taskItem in _completedTasks)
                    ListTile(
                      leading: Icon(Icons.assignment_turned_in_rounded, color: Colors.green),
                      title: Text(taskItem.text),
                      trailing: Icon(Icons.done_outline_rounded, color: Colors.green),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnotherScreen(onSubmit: _addTask),
            ),
          );

        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _handleHeaderTapped() {
    setState(() {
      _currentMonth = DateFormat.MMMM().format(DateTime.now());
    });
  }

  void _updateMonthName(DateTime focusedDay) {
    setState(() {
      _currentMonth = DateFormat.MMMM().format(focusedDay);
    });
  }

  String _formattedDate(DateTime date) {
    return DateFormat('d MMMM yyyy, EEEE').format(date);
  }

  void _toggleTask(int index) {
    setState(() {
      _pendingTasks[index].isChecked = !_pendingTasks[index].isChecked;

      // Remove task from pendingTasks only when the icon changes to circle
      if (_pendingTasks[index].isChecked) {
        _completedTasks.add(_pendingTasks[index]);
        _pendingTasks.removeAt(index);
      }
    });
  }
  void _addTask(String task, String time) {
    if (task.isNotEmpty) {
      setState(() {
        String formattedTask = _buildFormattedTask(task, time);
        _pendingTasks.add(TaskItem(text: formattedTask, isChecked: false));
      });
    }
  }

  String _buildFormattedTask(String task, String time) {
    if (task == null && time == null) {
      return "No ToDo added";
    } else if (task == null && time!=null) {
      return "No ToDo added";

    } else {
      return "$task $time";
    }
  }

}

class TaskItem {
  String text;
  bool isChecked;

  TaskItem({required this.text, required this.isChecked});
}