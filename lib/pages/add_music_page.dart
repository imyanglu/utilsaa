import 'package:flutter/material.dart';

class AddMusicPage extends StatelessWidget {
  const AddMusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Music')),
      body: const Center(child: Text('Add Music Page')),
    );
  }
}
