part of '../home_screen.dart';

class _TransactionLisTile extends StatelessWidget {
  const _TransactionLisTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.yellowAccent,
      elevation: 25,
      child: ListTile(
        style: ListTileStyle.list,
        tileColor: Colors.yellow.shade300,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        title: AppText.semiBold(
          'Transaction',
          color: Colors.black,
          fontSize: 16.spMin,
        ),
        subtitle: AppText.regular(
          'Some desc here',
          color: const Color(0xFF707070),
          fontSize: 16.spMin,
        ),
        leading: const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xffDDFCDF),
          child: FaIcon(FontAwesomeIcons.indianRupeeSign, color: Colors.black),
        ),
      ),
    );
  }
}
