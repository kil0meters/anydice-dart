import 'package:anydice/anydice.dart';

void main() async {
  try {
    var result = await AnyDiceWrapper.roll("output 3d6");
    print(result);
    print(generateRandomValue(result));
  } catch (e) {
    print("Error: $e");
  }
}
