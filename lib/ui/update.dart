import 'package:contact_app_gita/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/update/update_bloc.dart';
import 'home.dart';

class Update extends StatefulWidget {
  final int id;
  final String initialName;
  final String initialNumber;

  const Update({
    super.key,
    required this.id,
    required this.initialName,
    required this.initialNumber,
  });

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _nameController;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _numberController = TextEditingController(text: widget.initialNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  // Future<void> _updateContact() async {
  //   String name = _nameController.text;
  //   String number = _numberController.text;
  //
  //   await FirebaseManager().updateContact(widget.id, name, number);
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const Home()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Update Contact')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/edit.png"),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _nameController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _numberController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<UpdateBloc, UpdateState>(
                listener: (context, state) {
                  if (state is UpdateSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (BuildContext c) => HomeBloc(),
                                child: const Home(),
                              )),
                    );
                  } else if (state is UpdateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<UpdateBloc>().add(
                            UpdateButtonPressed(
                              widget.id,
                              _nameController.text,
                              _numberController.text,
                            ),
                          );
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
