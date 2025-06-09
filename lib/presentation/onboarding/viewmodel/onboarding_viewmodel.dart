import 'dart:async';

import 'package:newtest/domain/models.dart';
import 'package:newtest/presentation/base/base_view_model.dart';
import 'package:newtest/presentation/resources/assests_manger.dart';
import 'package:newtest/presentation/resources/strings_manger.dart';

class OnboardingViewmodel extends BaseViewModel
    with OnboardingViewmodelInpute, OnboardingViewmodelOutput {
  //stream controllers outputs
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currnetIndex = 0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //view model start you job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int prevousIndex = ++_currnetIndex;
    if (prevousIndex == _list.length) {
      prevousIndex = 0;
    }

    return prevousIndex;
  }

  @override
  int goPrevious() {
    int prevousIndex = --_currnetIndex;
    if (prevousIndex == -1) {
      prevousIndex = _list.length - 1;
    } 

    return prevousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currnetIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViiewObject) => sliderViiewObject);

  //onboarding private function
  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(_list[_currnetIndex], _list.length, _currnetIndex),
    );
  }

  //onboarding private function
  List<SliderObject> _getSliderData() => [
    SliderObject(
      AppStrings.onboardingTitle1,
      AppStrings.onboardingSubTitle1,
      ImageAssets.onBoarding1,
    ),

    SliderObject(
      AppStrings.onboardingTitle2,
      AppStrings.onboardingSubTitle2,
      ImageAssets.onBoarding2,
    ),

    SliderObject(
      AppStrings.onboardingTitle3,
      AppStrings.onboardingSubTitle3,
      ImageAssets.onBoarding3,
    ),
  ];
}

// inputs mean that "orders" that our view model will receive view
mixin OnboardingViewmodelInpute {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  //stream controller input
  Sink get inputSliderViewObject;
}

mixin OnboardingViewmodelOutput {
  //stream controller ouput
  Stream<SliderViewObject> get outputSliderViewObject;
}
