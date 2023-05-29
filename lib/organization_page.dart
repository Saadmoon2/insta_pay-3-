


import 'package:flutter/material.dart';
import 'components/organization_page_button.dart';


class OrganizationPage extends StatelessWidget{

  const OrganizationPage({super.key});

@override
Widget build (BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: const Text('Select Categories', style: TextStyle(
        color: Colors.white
      ),),
      backgroundColor: Colors.blue[800],
    ),
    body: GridView.count(
    crossAxisCount: 2,
    children: const  [

      OrganizationButton(imagePath: 'assets/images/organization/sui.png',),
      OrganizationButton(imagePath: 'assets/images/organization/kelectric.png',),
      OrganizationButton(imagePath: 'assets/images/organization/jdc_logo.png',),
      OrganizationButton(imagePath: 'assets/images/organization/siut_logo.png',),
      OrganizationButton(imagePath: 'assets/images/organization/net.png',),
      OrganizationButton(imagePath: 'assets/images/organization/optix.png',),
      OrganizationButton(imagePath: 'assets/images/organization/delizia.png',),
      OrganizationButton(imagePath: 'assets/images/organization/spotify.png',),
      OrganizationButton(imagePath: 'assets/images/organization/outfitters.jpg',),

  ],
)
  );
}

}