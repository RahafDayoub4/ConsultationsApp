import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:newtest/data/network/failure.dart';
import 'package:newtest/presentation/resources/color_manger.dart';
import 'package:newtest/presentation/resources/font_manger.dart';
import 'package:newtest/presentation/resources/styles_manger.dart';
import 'package:newtest/presentation/resources/values_manger.dart';

enum StateRendererType {
  //POPUP STATEES (DILAOG)
  popuplLodingState,
  popupErrorState,

  //FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //genral
  contentState,
}

class StateRender extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Failure? failure;
  Function retryActionFunction;

  StateRender({
    required this.stateRendererType,
    this.message = " ",
    this.title = " ",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popuplLodingState:
        return _getPopUpDialog(context, [_getImage()]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getImage(),
          _getMessage(message),
          _getButton("OK", context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([_getImage(), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getImage(),
          _getMessage(message),
          _getButton("Try Again", context),
        ]);
      case StateRendererType.fullScreenEmptyState:
       return  _getItemsColumn([_getImage(), _getMessage(message)]);
      case StateRendererType.contentState:
        return Container();
      
      
    }
    
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> childern) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManger.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogcontent(context, childern),
      ),
    );
  }

  Widget _getDialogcontent(BuildContext context, List<Widget> childern) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: childern,
    );
  }

  Widget _getItemsColumn(List<Widget> childern) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: childern,
    );
  }

  Widget _getImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Container(),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
            color: ColorManger.darkGrey,
            fontSize: FontSize.s18,
          ),
        ),
      ),
    );
  }

  Widget _getButton(String buttonTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.fullScreenErrorState) {
              //call retry function
              retryActionFunction.call();
            } else {
              //popup error state
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonTitle),
        ),
      ),
    );
  }
}
