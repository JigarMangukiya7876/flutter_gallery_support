import 'package:flutter/material.dart';
import 'package:fluttergallerysupport/picker/picker.dart';
import 'package:fluttergallerysupport/picker/selection.dart';
import 'media.dart';
import 'picker/thumbnail.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MediaPickerSelection selection;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Media Gallery"),
        ),
        body: SelectionGrid(
          selection: selection,
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              final result = await MediaPicker.show(context);
              if (result != null) {
                setState(() => selection = result);
              }
            },
            child: Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}

class SelectionGrid extends StatelessWidget {
  final MediaPickerSelection selection;

  const SelectionGrid({
    @required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20, bottom: 100, top: 20),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(16),
      ),
      child: selection == null || selection.selectedMedias.isEmpty
          ? Align(
              alignment: Alignment.center,
              child: Text("No assets are selected"))
          : Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                ...selection.selectedMedias.map<Widget>(
                  (x) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaViewerPage(media: x),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: MediaThumbnailImage(media: x),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
