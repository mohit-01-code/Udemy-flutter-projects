import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget{
  const LocationInput({super.key});
  @override
  State<LocationInput> createState(){
    return _LocationInputState();
  }

}

class _LocationInputState extends State<LocationInput>{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary)
          ),
          child: Text("No Location Chosen", style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),),
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: (){}, icon: Icon(Icons.location_on), label: Text("Get Current Location")),
            TextButton.icon(onPressed: (){}, icon: Icon(Icons.map), label: Text("Select on Map")),
          ],
        )
      ],
    );
  }
}