enum TripAction {
  tripStarted(1),
  tripEnd(2),
  pickupStart(4),
  pickupEnd(8);

  final int value;

  const TripAction(this.value);
}
