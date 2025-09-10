import 'package:qwid/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/list_order/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if(state.productInfo == null || state.dataCurrencyRate == null) return SizedBox.shrink();
        final price = state.productInfo?.pricePattern?.calSalePrice(
            'NZ', state.dataCurrencyRate?.rateAudToNzd ?? 1);
        final originalPrice = state.productInfo?.pricePattern?.calOriginalPrice(
            'NZ', state.dataCurrencyRate?.rateAudToNzd ?? 1);
        final discount = state.productInfo?.pricePattern?.calDiscountPercent(
            salePrice: price ?? 0, originalPrice: originalPrice ?? 0);

        OrderPresenter e = OrderPresenter(
          id: state.productInfo?.id ?? -1,
          name: state.productInfo?.title ?? '',
          description: state.productInfo?.brand?.title ?? '',
          price: originalPrice?.toDouble() ?? 0.0,
          discountPrice: price?.toDouble() ?? 0.0,
          image: state.productInfo?.primaryImage?.data?.urlThumb ?? '',
          size: state.productInfo?.sizes?.data?.map((e) => '${e.genericSize} / ${e.altSize}').join(', ') ?? '',
          discountPercent: discount ?? 0,

        );
        return OrderItem(item: e);
      },
    ); /*Column(
      mainAxisSize: MainAxisSize.min,
      children: orders.map((e) => OrderItem(item: e)).toList(),
    );*/
  }

// List<OrderPresenter> orders = [
//   OrderPresenter(
//     id: 1,
//     name: 'Toteme',
//     description: 'T-Lock Croc Dark Brown',
//     price: 289.00,
//     discountPrice: 260.10,
//     image: 'https://cashion.vn/wp-content/uploads/2023/10/Gucci-Marmont.jpg',
//     size: 'O/S',
//     discountPercent: 10,
//   ),
//   OrderPresenter(
//     id: 2,
//     name: 'AGOLDE',
//     description: 'Luna Pieced Jean in Split',
//     price: 499.10,
//     discountPrice: 449.10,
//     image: 'https://sites.create-cdn.net/siteimages/24/5/0/245036/21/2/5/21251170/1000x819.jpg?1730137998',
//     size: '26/8',
//     discountPercent: 10,
//   )
// ];
}

class OrderPresenter {
  int id;
  String name;
  String description;
  double price;
  double discountPrice;
  String image;
  String size;
  int discountPercent;

  OrderPresenter({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.image,
    required this.size,
    required this.discountPercent,
  });
}