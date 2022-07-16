import 'package:flutter/material.dart';
class grpui extends StatefulWidget {
  const grpui({Key? key}) : super(key: key);

  @override
  _grpuiState createState() => _grpuiState();
}

class _grpuiState extends State<grpui> {
  TextEditingController grpNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)

                ),
                hintText: "Group Name",
                hintStyle: TextStyle(
                    fontSize: 16
                ),

              ),
                  controller: grpNameController,
            ),
          )
        ],
      ),
    );
  }
}
