import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/Model/task_model.dart';
import '../../../../core/constants/size_config.dart';
import '../../../../core/constants/colors.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
    this.task, {
    super.key,
  });
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
          SizeConfig.orientation == Orientation.landscape ? 6 : 16,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGColor(task.color)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title!,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          task.isCompleted == 0
                              ? Icons.access_time_rounded
                              : Icons.done_all,
                          color: Colors.grey[200],
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${task.startTime} - ${task.endTime}',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      task.note!,
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(task.isCompleted == 0 ? 0 : 2),
                color: task.isCompleted == 0
                    ? Colors.grey[200]!.withOpacity(0.7)
                    : Colors.green[300],
              ),
              height: 65,
              width: task.isCompleted == 0 ? 1 : 5,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'COMPLETED',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color:
                      task.isCompleted == 0 ? Colors.white : Colors.green[300],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBGColor(int? color) {
    switch (color) {
      case 0:
        return MyColors.bluishClr;
      case 1:
        return MyColors.pinkClr;
      case 2:
        return MyColors.orangeClr;
      default:
        return MyColors.bluishClr;
    }
  }
}
