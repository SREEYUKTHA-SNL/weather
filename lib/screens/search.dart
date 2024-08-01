import 'package:flutter/material.dart';

class Managepage extends StatelessWidget {
  const Managepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
        height: 800,
        width: double.infinity,
        
        decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(25),
          
          gradient: LinearGradient(
                      colors: [
                        Color(0xff62B8F6),
                        Color(0xff2C79C1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ), ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            
                            children: [
                              IconButton(onPressed: () {
                                
                              }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                              SizedBox(width: 50),
                               Text('Manage location',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                       Container(
                        height: 30,
                        width: 350,
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                         child: TextField(decoration: null,
                          
                         ),
                       )
                      ],
                    ),
        
        ),
      ),
    );
  }
}