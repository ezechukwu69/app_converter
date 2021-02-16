import 'package:rxdart/rxdart.dart';

class MainPageController {
  List<CustomStreamHandler> streams = [CustomStreamHandler()];
  Stream<double> totalStream() => CombineLatestStream<double, double>(
          streams.map((e) =>
              Rx.combineLatest2(e.priceStream(), e.discountStream(), (a, b) {
                return a - ((b / 100) * a);
              })), (values) {
        double value = 0;
        values.forEach((element) => value = value + element);
        return value;
      });
}

class CustomStreamHandler {
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
}
