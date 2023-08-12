import 'package:flutter/material.dart';
import 'package:note_app/TextStyles.dart';
class Full_Note extends StatefulWidget {
  dynamic data;
  Full_Note(this.data);


  @override
  State<Full_Note> createState() => _Full_NoteState();
}

class _Full_NoteState extends State<Full_Note> {

  @override
  Widget build(BuildContext context) {
    dynamic data = widget.data;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes Description'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

              children: [
                const SizedBox(height: 30,),
                Text(data['title'],style: title(color: Colors.black),),
                const SizedBox(height: 30,),
                Text(data['desc'],
                    textAlign: TextAlign.center,style: desc(color: Colors.black),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
