import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/floating_button/custom_floating_action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {},
        icon: Icons.add,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
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
                        Icons.logout,
                        size: 22,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search notes ...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: sampleNotes.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ListTile(
                      trailing: Container(
                        width: 100,
                        height: 50,
                        child: Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                      title: RichText(
                        text: TextSpan(
                          text: 'Hello \n',
                          style: Theme.of(context).primaryTextTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'World',
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Edited : 10/12/2024',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade800,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
