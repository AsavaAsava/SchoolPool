import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget{
  final String location;
  final VoidCallback press;

  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: const Icon( Icons.location_on_outlined,),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: Colors.grey,
        ),
      ],
    );
  }

}