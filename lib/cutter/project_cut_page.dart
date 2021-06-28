import 'package:flutter/material.dart';
import 'package:workshop/cutter/cut_page.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/general_manager/project.dart';

class ProjectCutPage extends StatelessWidget {
  final PageController pageController;
  final List<Cut> cutList;

  ProjectCutPage({this.pageController, this.cutList});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;
    List<Project> projects = [];

    cutList.forEach((element) {
      try{
        projects.firstWhere((item) => item.id == element.project.id);
      }catch(e){
        projects.add(element.project);
      }
    });

    return WillPopScope(
      onWillPop: () async {
        pageController.animateToPage(0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 200));
        return false;
      },
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(8),
        crossAxisSpacing: 4,
        children: List.generate(
          projects.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext c) => CutPage(
                    cutList: cutList,
                    project: projects[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  // color: Colors.black12,
                border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'پروژه ' + projects[index].id,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
