import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:study_hub/feature/ocr/presentation/ocr_img_screen.dart';
import 'package:study_hub/feature/summarization/presentation/summarize_screen.dart';
import 'package:study_hub/feature/to_do/presentation/to_do_screen.dart';
import 'package:study_hub/feature/home/presentation/widgets/item_grid.dart'; // Ensure this import is correct
import 'package:iconsax/iconsax.dart';
import 'package:study_hub/feature/translation/presentation/translate_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                // Staggered Grid View
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1.3,
                        child: Grid_Item_Container(
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ToDoScreen(),
                            ));
                          },
                          color: Colors.pink,
                          icon: Icons.task_alt_rounded,
                          title: "To Do",
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Grid_Item_Container(
                          color: Colors.orange,
                          isSmall: true,
                          icon: Icons.summarize,
                          title: "Summarization",
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SummarizeScreen(),
                            ));
                          },
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1.3,
                        child: Grid_Item_Container(
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const OCRImgScreen(),
                            ));
                          },
                          color: Colors.green,
                          icon: Iconsax.scanner,
                          title: "OCR",
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Grid_Item_Container(
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TranslateScreen(),
                            ));
                          },
                          color: Colors.blue,
                          isSmall: true,
                          icon: Iconsax.translate,
                          title: "Translation",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
