import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTile extends StatelessWidget {
  final String name;
  final Widget nextScreen;

  const HomeTile({super.key, required this.name, required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: ListTile(
        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => nextScreen)),
        title: Text(name),
        iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
        textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontFamily: GoogleFonts.figtree().fontFamily
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 20,),
      ),
    );
  }
}
