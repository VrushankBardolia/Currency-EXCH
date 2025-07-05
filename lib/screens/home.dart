import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/components/homeTile.dart';
import '/screens/baseRate.dart';
import '/screens/rateConvertion.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  showInfo(){
    showModalBottomSheet(
      context: context,
      showDragHandle:true,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context)=>SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('About This App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              const Text('Currency Exchange is a simple and lightweight app to check live exchange rates and convert between currencies instantly.'),
              const SizedBox(height: 12),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('App Version'),
                trailing: const Text('1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Developer'),
                trailing: const Text('Vrushank Bardolia'),
              ),

              // Mail
              FilledButton.tonal(
                onPressed: ()=> launchUrl(Uri.parse('mailto:vrushank1793@gmail.com')),
                child: Row(
                  children: const [
                    Icon(Icons.mail_outline_outlined),
                    SizedBox(width: 8),
                    Text('Mail'),
                  ],
                ),
              ),

              // Twitter
              FilledButton.tonal(
                // padding: EdgeInsets.zero,
                onPressed: () => launchUrl(Uri.parse('https://x.com/Vrushank_Tweets')),
                child: Row(
                  children: const [
                    Icon(Icons.link),
                    SizedBox(width: 8),
                    Text('X: @Vrushank_Tweets'),
                  ],
                ),
              ),

              // LinkedIn
              FilledButton.tonal(
                onPressed: ()=> launchUrl(Uri.parse('https://www.linkedin.com/in/vrushank-bardolia')),
                child: Row(
                  children: const [
                    Icon(Icons.link),
                    SizedBox(width: 8),
                    Text('LinkedIn: Vrushank Bardolia'),
                  ],
                ),
              ),

              // GitHub
              FilledButton.tonal(
                onPressed: ()=>launchUrl(Uri.parse('https://github.com/VrushankBardolia')),
                child: Row(
                  children: const [
                    Icon(Icons.link),
                    SizedBox(width: 8),
                    Text('GitHub: github.com/VrushankBardolia'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency EXCH"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(onPressed: showInfo, icon: Icon(Icons.info_outline_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: Column(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeTile(name: "Base Rate", nextScreen: BaseRate()),
              HomeTile(name: "Rate Conversion", nextScreen: RateConversion()),
            ],
          ),
        ),
      ),
    );
  }
}
