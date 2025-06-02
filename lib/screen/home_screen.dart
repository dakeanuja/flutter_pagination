import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination/screen/product_data_screen.dart';

import '../bloc/collection_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Flutter Pagination Demo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (Context) => BlocProvider(
                      create: (context) => CollectionBloc(),
                      child: ProductDataScreen(),
                    ),
              ),
            );
          },
          child: Text(
            'Click Me',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
