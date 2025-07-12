import 'package:flutter/material.dart';
import 'package:newtest/presentation/common/state_randerer/state_render.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//loading state (popup ,full screen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState({required this.stateRendererType, String message = "loading"});
  @override
  String getMessage() {
    return message!;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

//error state (popup , full screen )
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

//content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() {
    return "Empty";
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.contentState;
  }
}

//empty state

class EmptytState extends FlowState {
  String message;
  EmptytState(this.message);

  @override
  String getMessage() {
    return "Empty";
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.fullScreenEmptyState;
  }
}

extension FlowStateExtention on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popuplLodingState) {
            //show popUp laoding
            showPopup(context, getStateRendererType(), getMessage());
            //show content ui of the screen
            return contentScreenWidget;
          } else {
            //full Screen loading
            return StateRender(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState _:
        {
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            //show popUp laoding
            showPopup(context, getStateRendererType(), getMessage());
            //show content ui of the screen
            return contentScreenWidget;
          } else {
            //full Screen loading
            return StateRender(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptytState:
        {
          return StateRender(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: () {},
          );
        }
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }
}

_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

showPopup(
  BuildContext context,
  StateRendererType stateRendererType,
  String messge,
) {
  WidgetsBinding.instance?.addPostFrameCallback(
    (_) => showDialog(
      context: context,
      builder:
          (BuildContext context) => StateRender(
            stateRendererType: stateRendererType,
            retryActionFunction: () {},
          ),
    ),
  );
}
