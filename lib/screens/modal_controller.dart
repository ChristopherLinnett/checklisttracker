import 'package:checklisttracker/shared_widgets/screen_title.dart';
import 'package:flutter/material.dart';

Future<String> launchModal({required context, required String type}) async {
  String textValue = '';
  var returnedValue = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.black87,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ScreenTitle(title: 'Add $type'),
                Container(
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Center(
                            child: Text('New $type Name',
                                style: const TextStyle(color: Colors.grey))),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        alignLabelWithHint: true),
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    onChanged: ((value) {
                      textValue = value;
                    }),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    Navigator.pop(context, textValue != '' ? textValue : '');
                  },
                ),
              ],
            ),
          ),
        );
      });
  return returnedValue ?? '';
}
