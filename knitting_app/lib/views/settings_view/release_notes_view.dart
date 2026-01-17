import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/providers/release_notes_provider.dart';
import 'package:provider/provider.dart';

class ReleaseNotesView extends StatefulWidget {
  const ReleaseNotesView({super.key});

  @override
  State<ReleaseNotesView> createState() => _ReleaseNotesViewState();
}

class _ReleaseNotesViewState extends State<ReleaseNotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Divider(height: 50, thickness: 15, color: Colors.amber),

          Text('GELİŞTİRİCİ NOTLARI'),
          Expanded(
            child: Consumer<ReleaseNotesProvider>(
              builder: (context, provider, _) {
                final releaseNotes = provider.releaseNotes;

                return ListView.builder(
                  itemCount: releaseNotes.length,
                  itemBuilder: (context, index) {
                    final rn = releaseNotes[index];

                    return Card(
                      child: ListTile(
                        title: Text(rn.version),
                        subtitle: Text("${rn.version}, ${rn.date}"),
                      ),
                    );
                  },
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}
