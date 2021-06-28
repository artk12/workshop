import 'package:flutter/material.dart';
import 'package:workshop/cutter/calculate_cutter.dart';
import 'package:workshop/cutter/cutter_detail_page.dart';
import 'package:workshop/module/cutter/cut.dart';

class CutCard extends StatelessWidget {
  final double width;
  final double height;
  final Cut cut;

  CutCard({this.width = 200, this.height, this.cut});

  @override
  Widget build(BuildContext context) {

    int totalPieces = 0;
    List
    <PiecesLayer> piecesList = CalculateCutter.getPiecesFromJson(cut.pieces);
    try{
      piecesList.forEach((element) {
        totalPieces += int.parse(element.layer);
      });
    }catch(e){}



    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CutterDetailPage(
            cutDetail: cut,
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(cut.year + "/" + cut.month + "/" + cut.day),
                        Text(totalPieces.toString()+" لایه")
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("کد پروژه : " + cut.project.id,style: Theme.of(context).textTheme.headline3,),
                  SizedBox(
                    height: 10,
                  ),
                  Text("بارکد : " + cut.fabric.barCode,style: Theme.of(context).textTheme.headline2,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
