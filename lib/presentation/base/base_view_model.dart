import 'dart:async';

import 'package:newtest/presentation/common/state_randerer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //shared variables and function that will be used through any view model
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  
  Sink get inputState =>_inputStreamController.sink;

  @override
  
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // will be called when view model dies

  Sink get inputState;
}

mixin BaseViewModelOutputs {

  Stream<FlowState> get outputState;

}
