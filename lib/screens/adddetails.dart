import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:internship_project/services/auth.dart';

class AddDetails extends StatefulWidget {
  String? email;
  String? pwd;
  // AddDetails({this.email}, {this.pwd}, {super.key});
  AddDetails({Key? key, this.email, this.pwd}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  late DatabaseReference dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('user');
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String mobile = "";
  String name = "";
  String clgname = "";
  String year = "";
  String type = 'Student';
  String showYear = 'Select Year';
  DateTime _selectedYear = DateTime.now();
  String imgUrl = "";
  late final file;
  Future pickUploadProfilePic() async {
    // final result = await FilePick

    try {
      ImagePicker imagePicker = ImagePicker();

      file = await imagePicker.pickImage(source: ImageSource.gallery);

      // print(imgUrl);
      // });
      print("File Path => ${file!.path}");
    } catch (e) {
      print("Error =>${e.toString()}");
    }
  }

  var items = [
    'Student',
    'Faculty',
    'Alumni',
  ];
  DateTime? date;
  selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: SizedBox(
            height: 300,
            width: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime(2025),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                setState(() {
                  _selectedYear = dateTime;
                  showYear = "${dateTime.year}";
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.email);
    // print(widget.pwd);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 10.0),
              Text(
                "Add your details here",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                  onTap: () {
                    pickUploadProfilePic();
                  },
                  child: Container(
                      height: 120,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.shade100,
                      ),
                      child:
                          //imgUrl == ""
                          //     ?
                          Icon(Icons.person)
                      // : Image.file(File(file!.path)),
                      )),
              SizedBox(height: 30.0),
              SizedBox(height: 20.0),
              TextFormField(
                enableSuggestions: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.person_outline),
                  hintText: 'Name',
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid name!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                enableSuggestions: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.phone),
                  hintText: 'Mobile Number',
                ),
                onChanged: (value) {
                  setState(() {
                    mobile = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return 'Enter a valid phone number!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                enableSuggestions: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.school),
                  hintText: 'College Name',
                ),
                onChanged: (value) {
                  setState(() {
                    clgname = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid college name!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      showYear,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectYear(context);
                      },
                      child: const Icon(
                        Icons.calendar_month,
                        textDirection: TextDirection.ltr,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                value: type,
                icon: Icon(Icons.person),
                validator: ((value) =>
                    value!.isEmpty ? 'Please Enter name!' : null),
                onChanged: (val) => setState(() {
                  type = val!;
                }),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        if (showYear == 'Select Year') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please Select a Year')));
                        } else {
                          Map<String, String> data = {
                            'name': name,
                            'college': clgname,
                            'mobile': mobile,
                            'year': showYear,
                            'type': type
                          };
                          String? res;
                          await Authentication.register(
                                  widget.email, widget.pwd, data)
                              .then((value) async {
                            if (value != null) {
                              print("Value is ==> $value");
                              print("File Path ${file!.path}");

                              Reference referenceRoot = FirebaseStorage.instance
                                  .ref()
                                  .child('user/$value');

                              try {
                                print("${file!.path}");
                                await referenceRoot.putFile(File(file!.path));
                              } catch (e) {
                                print("Main Error => ${e.toString()}");
                              }
                            }
                          });
                        }
                      } else {}
                    },
                    child: Text('Sign Up')),
              )
            ],
          ),
        ),
      )),
    );
  }
}
