import 'package:flutter/material.dart';
import 'package:newtest/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:newtest/presentation/resources/assests_manger.dart';
import 'package:newtest/presentation/resources/color_manger.dart';
import 'package:newtest/presentation/resources/values_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _bind() {
    _viewModel.start();
    _userNameController.addListener(
      () => _viewModel.setUserName(_userNameController.text),
    );
    _passWordController.addListener(
      () => _viewModel.setUserName(_passWordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        color: ColorManger.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Image(image: AssetImage(ImageAssets.onBoarding1)),
                ),
                SizedBox(height: AppSize.s20),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: "User Name",
                          labelText: "User Name",
                          errorText:
                              (snapshot.data ?? true)
                                  ? null
                                  : "Please Enter your name",
                        ),
                      );
                    },
                  ),
                ),

                //password text form field
                SizedBox(height: AppSize.s20),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _passWordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          errorText:
                              (snapshot.data ?? true)
                                  ? null
                                  : "Please Enter Password",
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: AppSize.s20),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p20),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsAreAllInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: () {
                          (snapshot.data ?? false)
                              ? () {
                                _viewModel.login();
                              }
                              : null;
                        },
                        child: Text("login"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
