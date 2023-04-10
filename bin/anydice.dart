import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

class AnyDiceWrapper {
  static const String baseURL = "https://anydice.com/calculator_limited.php";

  // returns a probability distribution when given a roll
  static Future<List<List<double>>> roll(String diceExpression) async {
    var body = {'program': diceExpression};
    http.Response response = await http.post(Uri.parse(baseURL), body: body);
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      final data = res["distributions"]["data"];

      return <List<double>>[
        for (var first in data[0])
          <double>[for (var second in first) second.toDouble()]
      ];
    } else {
      throw Exception(
          "Failed to load dice expression: ${response.statusCode} ${response.reasonPhrase}");
    }
  }
}

// {distributions: {data: [[[3, 0.462962962963], [4, 1.38888888889], [5, 2.77777777778], [6, 4.62962962963], [7, 6.94444444444], [8, 9.72222222222], [9, 11.5740740741], [10, 12.5], [11, 12.5], [12, 11.5740740741], [13, 9.72222222222], [14, 6.94444444444], [15, 4.62962962963], [16, 2.77777777778], [17, 1.38888888889], [18, 0.462962962963]]], labels: [output 1], minX: 3, maxX: 18, minY: 0, maxY: 12.5}}

int generateRandomValue(List<List<double>> probabilityDistribution) {
  var rng = Random();

  var acc = 0.0;
  final value = rng.nextDouble() * 100;

  for (var i = 0; i < probabilityDistribution.length; i++) {
    acc += probabilityDistribution[i][1];

    if (value < acc) {
      return probabilityDistribution[i][0].round();
    }
  }

  return -1;
}

void main() async {
  try {
    var result = await AnyDiceWrapper.roll("output 3d6");
    print(generateRandomValue(result));
  } catch (e) {
    print("Error: $e");
  }
}
