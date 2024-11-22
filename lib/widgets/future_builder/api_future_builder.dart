import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T) onComplete;

  const ApiFutureBuilder(
      {super.key, required this.future, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasError &&
            snapshot.connectionState == ConnectionState.done) {
          return onComplete(snapshot.data as T);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          if (kDebugMode) {
            print("[AFB] Error: ${snapshot.error.toString()}");
          }
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text('An error occurred'),
                  ElevatedButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("[AFB] Reloading ${future.toString()}");
                      }
                      future;
                    },
                    child: Text('Retry'),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: future,
    );
  }
}
