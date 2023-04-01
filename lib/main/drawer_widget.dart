import 'package:flutter/material.dart';
import 'package:flutter_dictionary/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: List.generate(
            drawerItemData.length,
            (index) {
              if (index == 3) {
                return Expanded(
                  child: Column(
                    children: [
                      const Spacer(),
                      _DrawerItemWidget(index, drawerItemData[index]),
                      const Divider(
                        thickness: 0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0, top: 8.0),
                        child: Text(
                          "វចនានុក្រមខ្មែរ ជំនាន់១",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _DrawerItemWidget(index, drawerItemData[index]);
            },
          ),
        ),
      ),
    );
  }
}

class _DrawerItemWidget extends ConsumerWidget {
  final int position;
  final DrawerItemData data;

  const _DrawerItemWidget(this.position, this.data);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
            appViewModelProvider.select((value) => value.selectedPosition)) ==
        position;
    return ListTile(
      selected: selected,
      title: Text(data.title),
      leading: Icon(data.iconData),
      onTap: () {
        Navigator.of(context).pop();
        ref.read(appViewModelProvider.notifier).select(position);
      },
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
