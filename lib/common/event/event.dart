import 'package:event_bus/event_bus.dart';

class EventBusHelper {
  static final EventBus _eventBus = new EventBus();

  EventBusHelper._();

  static void fire(dynamic event) {
    _eventBus.fire(event);
  }

  static Stream<EventType> getEventTypeStream<EventType>() {
    return _eventBus.on<EventType>();
  }
}

class HttpErrorEvent {
  final int code;

  final String message;

  final bool noTip;

  HttpErrorEvent(this.code, this.message, this.noTip);
}

class SelectDateEvent {
  final DateTime _dateTime;
  SelectDateEvent(this._dateTime);
  DateTime get dateTime {
    return _dateTime;
  }
}