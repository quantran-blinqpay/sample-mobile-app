import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';

enum TransactionType {
  exchange,
  deposit,
  withdrawal,
  payment,
  transfer,
  refund,
  fee,
  reward,
  cryptoBuy,
  cryptoSell,
  cryptoSwap,
}

enum TransactionStatus {
  success,
  processing,
  checking,
  hold,
  failed,
}

class TransactionHistoryItem extends StatelessWidget {
  const TransactionHistoryItem({
    super.key,
    required this.name,
    required this.currency,
    required this.amount,
    required this.date,
    required this.type,
    required this.currencySymbol,
    required this.status
  });

  final String? name;
  final String? currency;
  final String? amount;
  final String? date;
  final String? currencySymbol;
  final TransactionType? type;
  final TransactionStatus? status;

  Widget _buildAvatar() {
    if (type == TransactionType.deposit) {
      return SizedBox(
        width: 40,
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            border: Border.all(color: Color(0xffF3F5F7), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: CountryFlag.fromCurrencyCode(
                currency ?? 'NGN',
                width: 18,
                height: 12,
                shape: Rectangle(),
              ),
            ),
          ),
        ),
      );
    } else if (type == TransactionType.exchange) {
      return SizedBox(
        width: 40,
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            border: Border.all(color: Color(0xffF3F5F7), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: SvgPicture.asset(icQwidExchange, width: 20, height: 20),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: 40,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          border: Border.all(color: Color(0xffF3F5F7), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              ((name?.length ?? 0) > 2 ? name!.substring(0, 2) : name ?? '')
                  .toUpperCase(),
              style: TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 16.67,
                fontWeight: FontWeight.w400,
                color: Color(0xffAEB3BE),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          Stack(
            children: [
              _buildAvatar(),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    status == TransactionStatus.success
                        ? icQwidTransferSuccess
                        : status == TransactionStatus.processing
                          ? icQwidWarningOrange
                            : status == TransactionStatus.checking
                              ? icQwidWarningBlue
                                : status == TransactionStatus.hold
                                  ? icQwidWarningViolet
                                  : icQwidFailure,
                    width: 12,
                    height: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0A0A0C),
                  ),
                ),
                Text(
                  date ?? '',
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff92939E),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '+$currencySymbol',
                      style: const TextStyle(
                        fontFamily: 'Helonik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff0A0A0C),
                      ),
                    ),
                    TextSpan(
                      text: amount,
                      style: const TextStyle(
                        fontFamily: 'Helonik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff0A0A0C),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                status == TransactionStatus.success
                    ? 'Successful'
                    : status == TransactionStatus.processing
                        ? 'Pending'
                        : 'Failed',
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff92939E),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
