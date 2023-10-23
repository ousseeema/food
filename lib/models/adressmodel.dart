// ignore_for_file: unused_field

class AdressModel{
 late int? _id;
 late String _AddressType;
 late String? _contactpersonName;
 late String? _contactpersonNumber;
 late String _Address;
 late String _longitude;
 late String _latitude;
 AdressModel({
   id, 
   required AddressType,
   contactpersonName,
   contactpersonNumber,
   Address, 
   longitude,
   latitude

 }){
  _id= id;
  _AddressType = AddressType;
  _contactpersonName= contactpersonName;
  _contactpersonNumber = contactpersonNumber;
  _Address =Address;
  _longitude = longitude;
  _latitude  = latitude ;


 }


 String get addresstype => _AddressType;
 String get  address => _Address;
 String? get contactpersonname => _contactpersonName;
 String? get contactpersonnumber => _contactpersonNumber;
 String get latitude => _latitude;
 String get longitude => _longitude;

  AdressModel.fromJson(Map<String, dynamic> json){
    _id = json["id"];
    _AddressType =json['address_type']??"";
    _contactpersonName = json ['contact_person_name']??"";
    _contactpersonNumber = json ['contact_person_number']??"";
    _Address= json["address"];
    _longitude= json["longitude"];
    _latitude= json ["latitude"];
    
  }


  Map<String, dynamic> toJson(){
    return {
      "id":_id,
      "address":_Address ,
      'address_type':_AddressType,
      'contact_person_name':_contactpersonName,
      'contact_person_number':_contactpersonNumber,
      'longitude':_longitude,
      'latitude':_latitude
      
    };
  }
}