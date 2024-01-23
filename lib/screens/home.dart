import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notes',
                style: Theme.of(context).primaryTextTheme.headlineMedium,
              ),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade800.withOpacity(.8),
                    ),
                    child: const Icon(
                      Icons.sort,
                      size: 28,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes ...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintStyle: const TextStyle(color: Colors.grey),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent))),
          ),
          Expanded(
              child: ListView(
            children: [
              Card(
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: 'Hello \n',
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: ' World',
                          style: Theme.of(context).primaryTextTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    ));
  }
}
