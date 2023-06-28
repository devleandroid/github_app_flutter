
import 'package:flutter/widgets.dart';

class WidgetCallSafe extends StatelessWidget {
  final bool Function() checkIfNull;
  final Widget Function() success;
  final Widget Function() fail;


  const WidgetCallSafe({super.key, required this.checkIfNull, required this.success, required this.fail});

  @override
  Widget build(BuildContext context) {
    final bool isTrue = checkIfNull();
    if(isTrue) {
      return success();
    }
    return fail();
  }
}
