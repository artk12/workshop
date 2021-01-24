class ItemLog{
  String id;
  String itemId;
  String log;
  String person;
  String amount;
  String year;
  String month;
  String day;
  String description;

  ItemLog({this.itemId,this.day,this.year,this.month,this.description,this.person,this.id,this.amount,this.log});

  factory ItemLog.fromJson(Map map){
    return ItemLog(description: map['description'],day: map['day'],month: map['month'],year: map['year'],id: map['ID'],itemId: map['item_id'],amount: map['amount'],log: map['log'],person: map['person']);
  }

}