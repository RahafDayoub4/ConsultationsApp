import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:newtest/domain/usecase/login_usecase.dart';
import 'package:newtest/presentation/base/base_view_model.dart';
import 'package:newtest/presentation/common/freezed_data_classes.dart';
import 'package:newtest/presentation/common/state_randerer/state_render.dart';
import 'package:newtest/presentation/common/state_randerer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _userPasswordController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUsecase _loginUsecase;
  LoginViewModel(this._loginUsecase);

  @override
  void dispose() {
    super
        .dispose(); //added after i made the input stream controller for the flow state
    _userNameStreamController.close();
    _userPasswordController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    //view model should  tell view please show content state
    inputState.add(ContentState());
  }

  //input
  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _userPasswordController.sink;

  @override
  login() async {
    inputPassword.add(
      LoadingState(
        stateRendererType: StateRendererType.popuplLodingState,
      ),
    );
    (await _loginUsecase.execute(
      LoginUseCaseInput(loginObject.userName, loginObject.Password),
    )).fold(
      (failure) => {
        inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message)),
        
        print(failure.message)},
      (data) => {
        //content
        inputState.add(ContentState()),
        
        print(data.customer?.name)},
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

  bool _areAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.Password);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(Password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userNmae) {
    inputUserName.add(userNmae);
    loginObject = loginObject.copyWith(userName: userNmae);
    inputAreAllInputsValid.add(null);
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outIsAreAllInputsValid => _areAllInputsValidStreamController
      .stream
      .map((_) => _areAllInputsValid());
}

mixin LoginViewModelInput {
  setUserName(String userNmae);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

mixin LoginViewModelOutput {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outIsAreAllInputsValid;
}
