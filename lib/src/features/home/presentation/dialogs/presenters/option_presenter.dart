class OptionPresenter{
  OptionPresenter({
    required this.reducePercent,
    required this.price,
    required this.id,
    required this.currency,
    this.isRecommended = false
  });

  double price;
  int reducePercent;
  String currency;
  int id;
  bool isRecommended;
}