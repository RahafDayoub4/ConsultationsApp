import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String Password) = _LoginObject;
  
  @override
  // TODO: implement Password
  String get Password => throw UnimplementedError();
  
  @override
  // TODO: implement userName
  String get userName => throw UnimplementedError();
}
