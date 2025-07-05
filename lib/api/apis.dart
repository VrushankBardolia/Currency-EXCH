import 'dart:convert';
import 'package:http/http.dart' as http;
import 'API_KEY.dart';

final String apiBase = "https://v6.exchangerate-api.com/v6/$API_KEY";
late Map<String, String> currencyNameMap;

// Fetch all currencies: "USD - United States Dollar"
Future<List<String>> fetchCurrencies() async {
  final url = Uri.parse("$apiBase/codes");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List codes = data["supported_codes"];
    // Build the full name list and map
    currencyNameMap = {
      for (var item in codes) item[0]: item[1]
    };

    return codes.map<String>((item) => '${item[0]} - ${item[1]}').toList();
  } else {
    throw Exception("Failed to load currencies");
  }
}

// Fetch base rates for selected currency like "INR"
Future<Map<String, double>> fetchBaseRate(String currency) async {
  final url = Uri.parse("$apiBase/latest/$currency");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final rates = data["conversion_rates"] as Map<String, dynamic>;
    return rates.map((key, value) => MapEntry(key, (value as num).toDouble()));
  } else {
    throw Exception("Failed to load base rates");
  }
}

Future<double> convertRate(String from, String to, double amount) async {
  final url = Uri.parse("$apiBase/pair/$from/$to/$amount");
  final response = await http.get(url);

  if(response.statusCode == 200){
    final data = jsonDecode(response.body);
    final rate = data["conversion_result"] as double;
    return rate;
  } else {
    throw Exception("Failed to convert rate");
  }
}