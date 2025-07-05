import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';

class RateConversion extends StatefulWidget {
  const RateConversion({super.key});

  @override
  State<RateConversion> createState() => _RateConversionState();
}

class _RateConversionState extends State<RateConversion> {
  String fromCurrency = "USD - United States Dollar";
  String toCurrency = "INR - Indian Rupee";

  TextEditingController fromAmount = TextEditingController();
  TextEditingController resultAmount = TextEditingController();

  swapCurrencies(){
    final tempFrom = fromCurrency;
    final tempTo = toCurrency;
    setState(() {
      fromCurrency = tempTo;
      toCurrency = tempFrom;
    });
  }

  Future<void> convert() async {
    final from = fromCurrency.substring(0,3);
    final to = toCurrency.substring(0,3);
    final amount = double.parse(fromAmount.text);
    final res = await convertRate(from,to, amount);
    setState(() {
      resultAmount.text = res.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Conversion"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder(
              future: fetchCurrencies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownSearch(
                    selectedItem: fromCurrency,
                    items: snapshot.data!,
                    popupProps: PopupProps.menu(showSearchBox: true),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "From Currency",
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    onChanged: (newValue) async {
                      setState(() {
                        fromCurrency = newValue;
                      });
                      convert();
                    },
                  );
                } else {
                  return const TextField(
                    decoration: InputDecoration(
                      hintText: "From Currency",
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  );
                }
              },
            ),

            SizedBox(height: 8),
            TextField(
              controller: fromAmount,
              decoration: InputDecoration(
                hintText: "From Amount",
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),

            SizedBox(height: 20),

            IconButton.filledTonal(
              enableFeedback: true,
              onPressed: swapCurrencies,
              icon: Icon(Icons.swap_vert_rounded),
            ),

            SizedBox(height: 20),

            FutureBuilder(
              future: fetchCurrencies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownSearch(
                    selectedItem: toCurrency,
                    items: snapshot.data!,
                    popupProps: PopupProps.menu(showSearchBox: true),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "To Currency",
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    onChanged: (newValue) async {
                      setState(() {
                        toCurrency = newValue;
                      });
                      convert();
                    },
                  );
                } else {
                  return const TextField(
                    decoration: InputDecoration(
                      hintText: "To Currency",
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  );
                }
              },
            ),

            SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: resultAmount,
              decoration: InputDecoration(
                hintText: "To Amount",
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),

            SizedBox(height: 12),

            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                onPressed: convert,
                child: Text("Convert",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
