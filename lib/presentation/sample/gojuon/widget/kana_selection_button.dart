import 'package:flutter/material.dart';
import 'package:flutter_resume/presentation/sample/gojuon/gojuon.dart';
import 'package:flutter_resume/utils/utils.dart';

class KanaSelectionButton extends StatelessWidget {
  const KanaSelectionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GojuonBloc.of(context);
    final gojuon = bloc.gojuon;
    final selectedRows = bloc.state.selectedRows;
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.5),
          barrierDismissible: true,
          builder: (context) {
            return KanaSelectionDialog(
              gojuon: gojuon,
              selectedRows: selectedRows,
            );
          },
        );
        bloc.add(UpdateSelectedRows(selectedRows));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.ss())),
          border: Border.all(
            color: Colors.black,
            width: 2.ss(),
          ),
        ),
        child: const Center(
          child: Text(
            '行',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
