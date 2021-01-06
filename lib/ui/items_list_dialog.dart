import 'package:flutter/material.dart';
import 'package:shopping/models/list_items.dart';
import '../util/dbhelper.dart';

class ItemListDialog {

  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  Widget buildDialog(BuildContext context, ListItem listItem, bool isNew) {
    DbHelper helper = new DbHelper();
    helper.openDB();

    if (!isNew) {
      txtName.text = listItem.name;
      txtQuantity.text = listItem.quantity;
      txtNote.text = listItem.note;
    }

    return AlertDialog(
      title: Text(!isNew ? "Edit Item" : "New Item"),
      content: SingleChildScrollView(
        child: Column(children: [
          TextField(
            controller: txtName,
            decoration: InputDecoration(
                hintText: 'Item Name',
            ),
          ),
          TextField(
            controller: txtQuantity,
            decoration: InputDecoration(
                hintText: 'Item Quantity',
            ),
          ),
          TextField(
            controller: txtNote,
            decoration: InputDecoration(
                hintText: 'Item Notes',
            ),
          ),
          RaisedButton(
            child: Text("Save Item"),
            onPressed: () {
              listItem.name = txtName.text;
              listItem.quantity = txtQuantity.text;
              listItem.note = txtNote.text;
              helper.insertItem(listItem);
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],),
      ),
    );
  }
}
