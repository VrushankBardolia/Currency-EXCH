import 'package:currency_exch/api/apis.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BaseRate extends StatefulWidget {
  const BaseRate({super.key});

  @override
  State<BaseRate> createState() => _BaseRateState();
}

class _BaseRateState extends State<BaseRate> {
  String? selectedCurrency;
  Map<String, double>? baseRates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Base Rate"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            FutureBuilder(
              future: fetchCurrencies(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return DropdownSearch(
                    items: snapshot.data!,
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          labelText: "Search Currency",
                          border: OutlineInputBorder(),
                      ),
                    ),
                    onChanged: (newValue) async {
                      final code = newValue.toString().substring(0, 3);
                      final rates = await fetchBaseRate(code);
                      setState(() {
                        selectedCurrency = code;
                        baseRates = rates.cast<String, double>();
                      });
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            // Text(selectedCurrency)
            if(baseRates != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: ListView(
                    children: baseRates!.entries.map((item)=>ListTile(
                      title: Text(item.key,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(currencyNameMap[item.key]!),
                      trailing: Text(item.value.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
