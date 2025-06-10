import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newtest/domain/models/models.dart';
import 'package:newtest/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:newtest/presentation/resources/color_manger.dart';
import 'package:newtest/presentation/resources/routes_manger.dart';
import 'package:newtest/presentation/resources/values_manger.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  OnboardingViewmodel _viewmodel = OnboardingViewmodel();
  _bind() {
    _viewmodel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewmodel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManger.accent,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManger.white,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numberOfSlides,
          onPageChanged: (index) {
            _viewmodel.onPageChanged(index);
          },

          itemBuilder: (context, index) {
            //return onBoarding page
            return OnBoardingPage(sliderObject: sliderViewObject.sliderObject);
          },
        ),
        bottomSheet: Container(
          color: ColorManger.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.logingRoute);
                  },
                  child: Text(
                    "Skip",
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),

              //widget indicator and arrows
              _getBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //left arrow
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: Icon(Icons.arrow_back_ios),
            ),
            onTap: () {
              _pageController.animateToPage(
                _viewmodel.goPrevious(),
                duration: Duration(microseconds: 300),
                curve: Curves.bounceInOut,
              );
            },
          ),
        ),

        //circle indicator
        Row(
          children: [
            for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
              Padding(
                padding: EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i,sliderViewObject.currentIndex),
              ),
          ],
        ),

        //right arrow
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              width: AppSize.s20,
              height: AppSize.s20,
              child: Icon(Icons.arrow_forward_ios),
            ),
            onTap: () {
              _pageController.animateToPage(
                _viewmodel.goNext(),
                duration: Duration(microseconds: 300),
                curve: Curves.bounceInOut,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getProperCircle(int index , int currentIndex) {
    if (index == currentIndex) {
      return Icon(Icons.circle_outlined);
    } else {
      return Icon(Icons.circle);
    }
  }

  @override
  void dispose() {
    _viewmodel.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;

  const OnBoardingPage({super.key, required this.sliderObject});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),

        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}
