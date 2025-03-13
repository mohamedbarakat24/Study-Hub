import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'package:tasky/services/notification_services%20from%20course.dart';

import '../../../core/Model/task_model.dart';
import '../../translation/logic/controller/task_controller.dart';
import '../../../core/constants/size_config.dart';

import '../../../core/constants/colors.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widget/mybutton.dart';

import 'widget/task_tile.dart';
import 'add_task_screen.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  void initState() {
    super.initState();
    _taskController.getTasks();
  }

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Tasks',
          style: headingStyle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _addTaskBar(),
            _addDateBar(),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  Widget _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 14, bottom: 8, right: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            lable: '+ Add Task',
            onTap: () async {
              await Get.to(() => const AddTaskScreen());
              //ThemeServices().switchMode();

              _taskController.getTasks();
            },
          )
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 14, bottom: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        selectionColor: MyColors.primaryClr,
        selectedTextColor: Colors.white,
        dayTextStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w600, fontSize: 20, color: Colors.grey),
        dateTextStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.grey),
        monthTextStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey),
        initialSelectedDate: DateTime.now(),
        onDateChange: (selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
          });
        },
      ),
    );
  }

  Future<void> onRefresh() async {
    _taskController.getTasks();
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          if (_taskController.taskList.isEmpty) {
            return _noTaskMsg();
          } else {
            return RefreshIndicator(
              onRefresh: onRefresh,
              color: MyColors.primaryClr,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var task = _taskController.taskList[index];
                  if (task.date == DateFormat.yMd().format(_selectedDate)) {
                    return AnimationConfiguration.staggeredList(
                      duration: const Duration(milliseconds: 700),
                      position: index,
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                context,
                                task,
                              );
                            },
                            child: TaskTile(
                              task,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: _taskController.taskList.length,
              ),
            );
          }
        },
      ),
    );
  }

  _buildButtomSheet({
    required String lable,
    required Function() onTap,
    required Color clr,
    bool isClosed = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClosed
                  ? Get.isDarkMode
                      ? Colors.grey[200]!
                      : Colors.grey[600]!
                  : clr,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClosed ? Colors.transparent : clr),
        child: Center(
          child: Text(lable,
              style: isClosed
                  ? titleStyle
                  : titleStyle.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.3
                : SizeConfig.screenHeight * 0.4),
        color: Get.isDarkMode ? MyColors.darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
              ),
            ),
            task.isCompleted == 1
                ? Container()
                : _buildButtomSheet(
                    lable: 'Task Completed',
                    onTap: () {
                      _taskController.setTaskAsCompleted(taskId: task.id!);

                      Get.back();
                    },
                    clr: MyColors.primaryClr,
                  ),
            task.isCompleted == 1
                ? Container()
                : Divider(
                    color: Get.isDarkMode
                        ? Colors.grey
                        : const Color.fromARGB(255, 206, 197, 197),
                    endIndent: 20,
                    indent: 20,
                  ),
            _buildButtomSheet(
              lable: 'Delete',
              onTap: () {
                _taskController.deleteTask(task: task);

                Get.back();
              },
              clr: Colors.red,
            ),
            Divider(
              color: Get.isDarkMode
                  ? const Color.fromARGB(255, 204, 194, 194)
                  : const Color.fromARGB(255, 206, 197, 197),
              endIndent: 20,
              indent: 20,
            ),
            _buildButtomSheet(
                lable: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: Colors.grey),
          ],
        ),
      ),
    ));
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 950),
          child: RefreshIndicator(
            color: MyColors.primaryClr,
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 230,
                        ),
                  SvgPicture.asset(
                    'assets/images/task.svg',
                    semanticsLabel: 'Task',
                    color: MyColors.primaryClr.withOpacity(0.65),
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      'You do not have any Tasks yet! \n Add new tasks to make your day prefect',
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 120,
                        )
                      : const SizedBox(
                          height: 180,
                        ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
