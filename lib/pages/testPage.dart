import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController controller = new TextEditingController();
  bool currentValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller.text = "test value";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            setState(() {
              _myListView.add(_buildRow());
            });
          },
          child: Text("اضافة مهمه جديدة", style: TextStyle(color: Colors.blue)),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _myListView),
        ));
  }

  Widget _buildRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: EditableText(
              backgroundCursorColor: Colors.black,
              controller: controller,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              cursorColor: Colors.black,
              focusNode: FocusNode(),
            ),
          ),
          Checkbox(
            activeColor: Colors.black,
              value: currentValue,
              onChanged: (val) {
                setState(() {
                  currentValue = val!;
                });
              })
        ],
      ),
    );
  }

  List<Widget> _myListView = [Text("data")];
}
