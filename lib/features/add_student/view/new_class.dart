import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewClass extends StatefulWidget {
  final void Function(String) updateClas;

  const NewClass({Key? key, required this.updateClas}) : super(key: key);

  @override
  State<NewClass> createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  final _classInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('New Class'),
      heroTag: null,
      onPressed: () async {
        final dialog = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('New Class'),
            content: TextField(
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Enter the class name'),
              controller: _classInputController,
            ),
            actions: [
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  Get.back();
                  widget.updateClas(_classInputController.text);
                },
              ),
            ],
          ),
        );
        _classInputController.clear();
        return dialog;
      },
    );
  }
}
