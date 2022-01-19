import 'package:flutter/material.dart';

class SandboxScreen extends StatelessWidget {
  const SandboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: TextButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text("Edit name"),
                        ),
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text("Edit name"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: TextField(),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("SHOW BOTTOM SHEET"),
            ),
          );
        },
      ),
    );
  }
}
