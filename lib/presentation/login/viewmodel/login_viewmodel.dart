import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:newtest/domain/usecase/login_usecase.dart';
import 'package:newtest/presentation/base/base_view_model.dart';
import 'package:newtest/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _userPasswordController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUsecase _loginUsecase;
  LoginViewModel(this._loginUsecase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _userPasswordController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  //input
  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _userPasswordController.sink;

  @override
  login() async {
    (await _loginUsecase.execute(
      LoginUseCaseInput(loginObject.userName, loginObject.Password),
    )).fold(
      (failure) => {
        print(failure.message)

      },
      (data) => {
        print(data.customer?.name)
      },
    ); //it is a function inside the either to return the left and the right
  }

  //output
  @override
  Stream<bool> get outIsPasswordValid => _userPasswordController.stream.map(
    (password) => _isPasswordValid(password),
  );

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map(
    (userName) => _isUserNameValid(userName),
  );

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(Password: password);
  }

  @override
  setUserName(String userNmae) {
    inputUserName.add(userNmae);
    loginObject = loginObject.copyWith(userName: userNmae);
  }
}

mixin LoginViewModelInput {
  setUserName(String userNmae);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
}

mixin LoginViewModelOutput {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}
