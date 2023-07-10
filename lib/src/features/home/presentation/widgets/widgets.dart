part of '../home_screen.dart';

class TransactionLisTile extends StatelessWidget {
  final String type;
  final double? amount;
  const TransactionLisTile({
    Key? key,
    required this.type,
    this.amount,
  }) : super(key: key);

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
          type,
          color: Colors.black,
          fontSize: 16.spMin,
        ),
        trailing: amount != null
            ? AppText.semiBold(
                amount.toString(),
                color: Colors.black,
                fontSize: 16.spMin,
              )
            : null,
        leading: CircleAvatar(
          radius: 20.r,
          backgroundColor: const Color(0xffDDFCDF),
          child: const FaIcon(FontAwesomeIcons.indianRupeeSign,
              color: Colors.black),
        ),
      ),
    );
  }
}

class AllTransactionListTile extends StatelessWidget {
  final String? amount;
  final String? createdAt;
  final String type;
  const AllTransactionListTile({
    super.key,
    this.amount,
    this.createdAt,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      tileColor: Colors.transparent,
      title: AppText.semiBold(
        type,
        color: Colors.white,
        fontSize: 16.spMin,
      ),
      trailing: amount != null
          ? AppText.semiBold(
              '- ₹${amount!}',
              color: Colors.redAccent,
              fontSize: 16.spMin,
            )
          : null,
      subtitle: createdAt != null
          ? Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    child: FaIcon(
                      FontAwesomeIcons.clock,
                      size: 12.spMin,
                      color: const Color(0xFF707070),
                    ),
                  ),
                  TextSpan(
                    text: ' $createdAt',
                    style: TextStyle(
                      fontSize: 12.spMin,
                      color: const Color(0xFF707070),
                    ),
                  ),
                ],
              ),
            )
          : null,
      leading: CircleAvatar(
        radius: 25.r,
        backgroundColor: Colors.red.withOpacity(0.7),
        child:
            const FaIcon(FontAwesomeIcons.indianRupeeSign, color: Colors.white),
      ),
    );
  }
}
