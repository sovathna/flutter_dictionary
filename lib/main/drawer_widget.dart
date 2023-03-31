import 'package:flutter/material.dart';
import 'package:flutter_dictionary/app/app_view_model.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class DrawerWidget extends StatelessWidget {
  final Function(int) _onItemSelected;
  const DrawerWidget(this._onItemSelected, {super.key});

  List<Widget> _drawerItems(BuildContext context) {
    final List<Widget> widgets = List.empty(growable: true);
    widgets.add(const SizedBox(height: 32.0));
    drawerItemData.forEachIndexed(
      (i, ele) {
        if (i == 3) {
          widgets.add(const Spacer());
        }
        widgets.add(
          Selector<AppViewModel, bool>(
            selector: (_, vm) => vm.value.selectedPosition == i,
            child: Text(ele.title),
            builder: (_, selected, child) {
              return ListTile(
                selected: selected,
                title: child,
                leading: Icon(ele.iconData),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<AppViewModel>().select(i);
                },
              );
            },
          ),
        );
      },
    );
    widgets.add(const Divider());
    widgets.add(
      const Padding(
        padding: EdgeInsets.only(bottom: 16.0, top: 8.0),
        child: Text(
          "វចនានុក្រមខ្មែរ ជំនាន់១",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0),
        ),
      ),
    );

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: _drawerItems(context),
      ),
    );
  }
}

List<DrawerItemData> drawerItemData = const [
  DrawerItemData("បញ្ជីពាក្យ", Icons.book_rounded),
  DrawerItemData("បញ្ជីពាក្យធ្លាប់មើល", Icons.history_rounded),
  DrawerItemData("បញ្ជីពាក្យចំណាំ", Icons.bookmarks_rounded),
  DrawerItemData("អំពីកម្មវិធី", Icons.info_rounded),
];

@immutable
class DrawerItemData {
  final String title;
  final IconData iconData;

  const DrawerItemData(this.title, this.iconData);
}
