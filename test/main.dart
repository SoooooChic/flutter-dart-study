enum Transmition { auto, manual }

class Car {
  Transmition transmition;
  Car(this.transmition);
}

int plus(int a, int b, [int? c = 1]) => a + b + (c ?? 0);

void main() {
  var car = Car(Transmition.auto);
  print('car transmition is : ${car.transmition}');

  int res = plus(1, 2);

  print('result $res');

  //var a = null;
  //var b = a ?? 0;

  //print('$b');

  var a = 1;
  //a ??= 0;

  print('$a');
}
