
class Pieces{

  String id;
  String layer;
  String surplus;
  String cutCode;
  String cutId;

  Pieces({this.cutCode,this.id,this.cutId,this.layer,this.surplus});

  factory Pieces.fromJson(Map map){
    return Pieces(
      cutCode: map['cut_code'],
      cutId: map['cut_id'],
      id: map['ID'],
      layer: map['layer'],
      surplus: map['surplus'],
    );
  }
}