import 'dart:math';
import 'dart:convert';


class ApiClient {
  static Future<String> getSomething() async {
    Random rng = new Random();

    // The data is JSON encoded only for demonstration
    // Random values are doubles in range [0, 10] with 0.1 step
    var json = jsonEncode({
      'red': (rng.nextDouble() * 101).floorToDouble() / 10,
      'green': (rng.nextDouble() * 101).floorToDouble() / 10,
      'blue': (rng.nextDouble() * 101).floorToDouble() / 10,
    });

    // Simulating async call
    await Future.delayed(Duration(milliseconds: 500));

    // Creating an instance from decoded JSON
    return json.toString();
  }
}