class response{
  late bool issucces;
  late String message;
  response(
    this.issucces,
    this.message,
  );
    response.fromJson(Map json){
      issucces = json["succes"];
      message = json["message"];
    }

  
  }