import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CostomerResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CostomerResponse(this.id, this.name, this.numOfNotifications);
  //from json to fetch from API
  factory CostomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CostomerResponseFromJson(json);

  // to json if I want to send It to API
  Map<String, dynamic> toJson() => _$CostomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? eamil;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.eamil, this.link);
  //from json to fetch from API
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  // to json if I want to send It to API
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CostomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);

  //from json to fetch from API
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json if I want to send It to API
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
