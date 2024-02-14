abstract class ColorMatchCommonEvent {}

class NextColor extends ColorMatchCommonEvent {
  final bool restart;

  NextColor({
    this.restart = true,
  });
}

class TimerTick extends ColorMatchCommonEvent {
  final int tick;

  TimerTick(this.tick);
}
