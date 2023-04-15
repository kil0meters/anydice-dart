import 'package:anydice/anydice.dart';
import 'package:test/test.dart';

void main() {
  test('getResultFromSite', () {
    AnyDiceWrapper.roll("output 3d6").then((result) {
      expect(result, [
        [3.0, 0.462962962963],
        [4.0, 1.38888888889],
        [5.0, 2.77777777778],
        [6.0, 4.62962962963],
        [7.0, 6.94444444444],
        [8.0, 9.72222222222],
        [9.0, 11.5740740741],
        [10.0, 12.5],
        [11.0, 12.5],
        [12.0, 11.5740740741],
        [13.0, 9.72222222222],
        [14.0, 6.94444444444],
        [15.0, 4.62962962963],
        [16.0, 2.77777777778],
        [17.0, 1.38888888889],
        [18.0, 0.462962962963]
      ]);
    });
  });

  test('calculateProbabilityDistribution', () {
    var res = generateRandomValue([
      [3.0, 50.0],
      [3.0, 50.0]
    ]);
    expect(res, 3.0);
  });
}
