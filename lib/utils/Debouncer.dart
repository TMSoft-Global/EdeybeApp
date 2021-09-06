import 'dart:async';

class Debouncer {
  Timer _timer;
  Duration duration;
  Debouncer({this.duration});
  void run(Function callback) {
    if (_timer != null && _timer.isActive) _timer.cancel();
    _timer = Timer(duration ?? Duration(milliseconds: 800), callback);
  }

  void debouceDuration(Duration duration) {
    this.duration = duration;
  }

  void cancel() {
    if (_timer.isActive) _timer.cancel();
  }
}
