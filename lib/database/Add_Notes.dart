import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ADD_DB extends StatefulWidget {
  const ADD_DB({Key? key}) : super(key: key);

  @override
  State<ADD_DB> createState() => _ADD_DBState();
}

class _ADD_DBState extends State<ADD_DB> {
  var key = GlobalKey<FormState>();
  var title =TextEditingController();
  var desc =TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('Notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: key,
                  child: Column(
                    children: [
                    TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2
                        )
                      )
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Title can\'t be empty';
                       }
                      },

                  ),
                    SizedBox(height: 20,),
                    TextFormField(
                    controller: desc,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2
                        )
                      )
                    ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Description can\'t be empty';
                        }
                      },

                  )
                ],
              )),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                if(key.currentState!.validate()) {
                  post();
                }
              }, child: Text('Save Note'))
            ],
          ),
        ),
      ),
    );
  }
  post(){

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    fireStore.doc(id).set({
      'title': title.text.toString(),
      'desc' : desc.text.toString(),
      'id' : id
    }).then((value){
      print('Saved');
      Navigator.pop(context);
    }).onError((error, stackTrace){
      print(error);
    });
  }
}
