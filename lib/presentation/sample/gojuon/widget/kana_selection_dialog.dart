import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';
import 'package:flutter_resume/utils/utils.dart';

class KanaSelectionDialog extends StatelessWidget {
  final Gojuon gojuon;
  final Map<int, bool> selectedRows;

  const KanaSelectionDialog({
    Key? key,
    required this.gojuon,
    required this.selectedRows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height * 0.6;
    final kanaList = gojuon.kanaList;
    return Center(
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: 16.ss(),
          vertical: 16.ss(),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.ss()),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.ss())),
          border: Border.all(
            color: Colors.black,
            width: 2.ss(),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: _KanaSelectionList(
                kanaList: kanaList,
                selectedRows: selectedRows,
              ),
            ),
            SizedBox(height: 20.ss()),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class _KanaSelectionList extends StatelessWidget {
  const _KanaSelectionList({
    required this.kanaList,
    required this.selectedRows,
  });

  final List<Kana> kanaList;
  final Map<int, bool> selectedRows;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height * 0.6;
    return ListView.separated(
      itemCount: kanaList.length ~/ 5,
      itemBuilder: (context, index) {
        String text = '';
        for (int i = 0; i < 5; i++) {
          final kana = kanaList[index * 5 + i];
          final hiragana = kana.hiragana.isNotEmpty
              ? kana.hiragana
              : '\u{00A0}\u{00A0}\u{00A0}';
          final katakana = kana.katakana.isNotEmpty
              ? kana.katakana
              : '\u{00A0}\u{00A0}\u{00A0}';
          text += '$hiragana/$katakana';
          if (i < 4) {
            text += '\u{00A0}\u{00A0}\u{00A0}\u{00A0}';
          }
        }
        bool isSelected = selectedRows.containsKey(index);
        return _KanaSelectionItem(
          text: text,
          width: width,
          height: height / 11,
          initSelected: isSelected,
          canUnselectCallback: () {
            return selectedRows.keys.length > 1;
          },
          selectCallback: (selected) {
            if (selected) {
              selectedRows[index] = true;
            } else {
              if (selectedRows.keys.length > 1) {
                selectedRows.remove(index);
              }
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

class _KanaSelectionItem extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final bool initSelected;
  final bool Function() canUnselectCallback;
  final void Function(bool isSelected) selectCallback;

  const _KanaSelectionItem({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.initSelected,
    required this.canUnselectCallback,
    required this.selectCallback,
  }) : super(key: key);

  @override
  State<_KanaSelectionItem> createState() => _KanaSelectionItemState();
}

class _KanaSelectionItemState extends State<_KanaSelectionItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSelected && !widget.canUnselectCallback()) {
          return;
        }
        setState(() {
          isSelected = !isSelected;
          widget.selectCallback(isSelected);
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: isSelected
            ? Theme.of(context).primaryColor.withValues(alpha: 0.8)
            : Colors.transparent,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
