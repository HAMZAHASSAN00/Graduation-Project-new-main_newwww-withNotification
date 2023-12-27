class UserModel {
  String? name;
  String? email;
  Tank? tank; // Use the Tank type
  bool? isTurnedOnTank;
  bool? isTurnedOnSolar;
  bool? isAutomaticMode ;
  String? tankName;
  double? height;
  double? width;
  double?  length;

double? waterTemp;
  double? CurrentBills;
  bool? isAutomaticModeSolar;

  UserModel({this.name, this.email, this.tank,this.isAutomaticMode,this.isTurnedOnSolar,this.isTurnedOnTank,this.tankName,this.height,this.width,this.length,this.waterTemp,this.CurrentBills,this.isAutomaticModeSolar});

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        isTurnedOnTank = json['isTurnedOnTank'],
        isTurnedOnSolar = json['isTurnedOnSolar'],
        isAutomaticMode = json['isAutomaticMode'],
        tankName=json['tankName'],
        height=json['height'],
        width=json['width'],
        length=json['length'],

        waterTemp=json['waterTemp'],
        CurrentBills=json['CurrentBills'],
        isAutomaticModeSolar=json['isAutomaticModeSolar'],

        tank = json['tank'] != null ? Tank.fromJson(json['tank']) : null;


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'tank': tank != null ? tank!.toJson() : null,
      'isTurnedOnTank': isTurnedOnTank,
      'isTurnedOnSolar': isTurnedOnSolar,
      'isAutomaticMode': isAutomaticMode,
      'tankName': tankName,
      'width': width,
      'height': height,
      'length': length,

      'waterTemp': waterTemp,
      'CurrentBills': CurrentBills,
      'isAutomaticModeSolar': isAutomaticModeSolar,

    };
  }
}

class Tank {
  String? cmRoof;
  String? cmGround;

  Tank({this.cmRoof, this.cmGround});

  Tank.fromJson(Map<String, dynamic> json)
      : cmRoof = json['cmRoof'],
        cmGround = json['cmGround'];

  Map<String, dynamic> toJson() {
    return {
      'cmRoof': cmRoof,
      'cmGround': cmGround,
    };
  }
}
