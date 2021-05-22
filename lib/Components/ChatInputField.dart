import 'package:buy_book_app/Models/ChatMessage.dart';
import 'package:buy_book_app/Services/DatabaseService.dart';
import 'package:flutter/material.dart';
class ChatInputField extends StatelessWidget {
  final controller=TextEditingController();
  String sender,receiver;
   ChatInputField({
    Key key,
    @required this.sender,
    @required this.receiver
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0 * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        onChanged: (value){
                          msg=value;
                        },
                        controller: controller,
                      ),
                    ),
                    SizedBox(width: 3.0),
                    GestureDetector(
                      onTap: (){
                        if(msg.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Text Field can not be empty')));
                        }else{
                          print(DateTime.now().microsecondsSinceEpoch);
                          ChatMessage message=ChatMessage(message: msg,sender: sender,time: DateTime.now().microsecondsSinceEpoch);
                          DatabaseService.instance.sendMsg(sender, receiver, message);
                          controller.clear();
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                    ),

                  ],
                ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}