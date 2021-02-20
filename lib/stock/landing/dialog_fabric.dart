import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/stock/calculate_stock.dart';
import 'package:workshop/style/component/stockpile/dialog_background_blur.dart';
import 'package:workshop/style/component/stockpile/fabric_log_card.dart';

class FabricLogDialog extends StatelessWidget {
  final List<FabricLog> fabricLogs;
  final List<Fabric> fabrics;
  final Fabric fabric;
  FabricLogDialog({this.fabricLogs, this.fabric, @required this.fabrics});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget space(double height) => SizedBox(height: height);

    CalculateStock.sortFabric(fabrics);
    List<FabricLogHolder> fabricLogHolder = FabricToFabricLogHolder(fabricLogs: fabricLogs,fabric: fabric,fabrics: fabrics).convert();

    return BlurDialogBg(
      maxWidth: 400,
      child: Column(
        children: [
          space(5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("توضیحات", style: theme.textTheme.headline2),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(fabric.calite + " # ",
                          style: theme.textTheme.bodyText1),
                    ),
                  ],
                ),
                space(5),
                Text(
                  fabric.description.isEmpty
                      ? "توضیحات ندارد."
                      : fabric.description,
                  style: theme.textTheme.bodyText1.copyWith(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
                space(5),
              ],
            ),
          ),
          space(5),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 2, color: Colors.white.withOpacity(0.1)))),
          ),
          space(5),
          Expanded(
              child: ListView.builder(
            itemCount: fabricLogHolder.length,
            itemBuilder: (context, index) => FabricLogCard(fabricHolder: fabricLogHolder[index],),
          ))
        ],
      ),
    );
  }
}

class FabricLogHolder {
  DateTime input;
  DateTime output;
  String calite;
  FabricLogHolder({this.calite, this.input, this.output});
}
class FabricToFabricLogHolder{
  final List<Fabric> fabrics;
  final Fabric fabric;
  final List<FabricLog> fabricLogs;
  FabricToFabricLogHolder({this.fabrics,this.fabric,this.fabricLogs});

   List<FabricLogHolder> convert(){
     List<FabricLogHolder> fabricsLogHolder = [];
    fabrics.forEach((element) {
      if(element.id != fabric.id){
        DateTime input = DateTime(element.year.parseInt(),element.month.parseInt(),element.day.parseInt());
        String calite = element.calite;

        FabricLog fabricLog = fabricLogs.firstWhere((log) => log.fabricId == element.id,orElse: (){return null;});
        DateTime output;
        if(fabricLog != null){
          output = DateTime(fabricLog.year.parseInt(),fabricLog.month.parseInt(),fabricLog.day.parseInt());
        }
        fabricsLogHolder.add(FabricLogHolder(calite: calite,input: input,output: output));
      }
    });
    return fabricsLogHolder;
  }
}
