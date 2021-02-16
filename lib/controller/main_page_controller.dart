import 'package:rxdart/rxdart.dart';

class MainPageController {
  // ignore: close_sinks
  BehaviorSubject<String> title = BehaviorSubject();
  // ignore: close_sinks
  BehaviorSubject<double> price = BehaviorSubject();
  // ignore: close_sinks
  BehaviorSubject<double> discount = BehaviorSubject();

  void titleSink(String a) => title.sink.add(a);
  void priceSink(double a) => price.sink.add(a);
  void discountSink(double a) => discount.sink.add(a);

  Stream titleStream() => title.stream;
  Stream priceStream() => price.stream;
  Stream discountStream() => discount.stream;

  Stream<List<dynamic>> totalStream() =>
      Rx.combineLatest3(priceStream(), discountStream(), titleStream(),
          (a, b, c) {
        var percentage = (b / 100) * a;
        return [a - percentage, c];
      });
}
