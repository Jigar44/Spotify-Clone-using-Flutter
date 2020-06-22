import 'package:flutter/material.dart';

//Basic UI Classes
class ShowCustomAlertDialog extends ChangeNotifier{
  Future<Widget> showCustomDialog(BuildContext context, String message){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(message,  style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
          actions: <Widget>[
            Center(
              child: RaisedButton(
                color: Colors.green,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Okay!", style: new TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      }
    );
  }
}
