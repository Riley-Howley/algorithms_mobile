import 'package:flutter/material.dart';

import '../Http/requests.dart';

class AllDataWidget extends StatefulWidget {
  @override
  State<AllDataWidget> createState() => _AllDataWidgetState();
}

class _AllDataWidgetState extends State<AllDataWidget> {
  @override
  var idController = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.8,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              "View your Data",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: "User ID",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          list.isEmpty
              ? ElevatedButton(
                  onPressed: () async {
                    await getAllData(idController.text);

                    setState(() {});
                  },
                  child: Text("Recieve"))
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text("${list[index].userid}"),
                            Text("${list[index].latitude}"),
                            Text("${list[index].longitude}"),
                            Text("${list[index].description}"),
                          ],
                        ),
                      );
                    },
                    itemCount: list.length,
                  ),
                ),
        ],
      ),
    );
  }
}
