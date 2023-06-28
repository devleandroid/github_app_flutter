import 'package:flutter/widgets.dart';

class AsyncLayoutConstructor<T> extends StatefulWidget {

  final Future<T> future;
  final T? initialData;
  final Widget Function(T data) hasDataWidget;
  final Widget Function() hasDataEmptyWidget;
  final Widget Function(Object err) hasErrorWidget;
  final Widget Function() loadingWidget;

  const AsyncLayoutConstructor({super.key, required this.future, this.initialData, required this.hasDataWidget, required this.hasDataEmptyWidget, required this.hasErrorWidget, required this.loadingWidget});

  @override
  _AsyncLayoutConstructorState<T> createState() => _AsyncLayoutConstructorState<T>();
}

class _AsyncLayoutConstructorState<T> extends State<AsyncLayoutConstructor<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return widget.hasDataWidget(snapshot.data as T);
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget();
        }
        if(snapshot.hasError) {
          return widget.hasErrorWidget(snapshot.hasError);
        }
        return widget.hasDataEmptyWidget();
      },
    );
  }
}
