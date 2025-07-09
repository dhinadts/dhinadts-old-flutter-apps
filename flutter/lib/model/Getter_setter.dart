class Kural {
  
  final int id;
  final String pal_tamil;
  final String iyal_tamil;
  final String adhikarm_no;
  final String adhikarm_tamil;
  final int kural_no;
  final String kuralvilakam_tamil;
  final String  kural_tamil1;
  final int isfav;
  final String desc1;
  final String desc2;

Kural({
    
  this.id, 
  this.pal_tamil, 
  this.iyal_tamil, 
  this.adhikarm_no,
  this.adhikarm_tamil,
  this.kural_no,
  this.kuralvilakam_tamil,
  this.kural_tamil1,
  this.isfav,
  
  this.desc1,
  this.desc2
});

  factory Kural.fromJson(Map<String, dynamic> json) {
    return Kural(
      id: json['id'],
      pal_tamil: json['pal_tamil'],
      iyal_tamil: json['iyal_tamil'],
      adhikarm_no: json['adhikarm_no'],
      kural_no: json['kural_no'],
      kuralvilakam_tamil: json['kuralvilakam_tamil'],
      isfav: json['isfav'],
      desc1 : json['desc1'],
      desc2: json['desc2'],

    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["pal_tamil"] = pal_tamil;
    map["iyal_tamil"] = iyal_tamil;
    map["adhikarm_no"] = adhikarm_no;
    map["kural_no"] = kural_no;
    map["kuralvilakam_tamil"] = kuralvilakam_tamil;
    map["isfav"] = isfav;
    map["desc1"] = desc1;
    map["desc2"] = desc2;

    return map;
  }
}