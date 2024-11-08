import 'package:flutter/material.dart';

class Read_data extends StatelessWidget{

  TextEditingController _controller=TextEditingController();
  late String tittle;
  late bool dont_show_password;

  Read_data(String tittle,{bool dont_show_password=false}){

    this.tittle=tittle;
    this.dont_show_password=dont_show_password;
  }

  TextEditingController getcontrollor(){
    return this._controller;
  }


  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(tittle,style: TextStyle(fontSize: 20),),
        SizedBox(height: 5,),
        TextField(
          controller: _controller,
          obscureText: this.dont_show_password,
          decoration: InputDecoration(border: OutlineInputBorder()),
        )
      ],
    );
  }

  
}