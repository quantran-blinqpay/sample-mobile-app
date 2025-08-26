// ignore_for_file: must_be_immutable

part of 'helper_cubit.dart';

class HelperState extends Equatable {
  const HelperState({
    this.startup,
    this.siteSetting,
    this.currencyRate,
  });

  final GetStartupResponse? startup;
  final SiteSettingData? siteSetting;
  final CurrencyRateResponse? currencyRate;

  HelperState copyWith({
    GetStartupResponse? startup,
    SiteSettingData? siteSetting,
    CurrencyRateResponse? currencyRate,
  }) {
    return HelperState(
      startup: startup ?? this.startup,
      siteSetting: siteSetting ?? this.siteSetting,
      currencyRate: currencyRate ?? this.currencyRate,
    );
  }

  @override
  List<Object?> get props => [
        startup,
        siteSetting,
        currencyRate,
      ];
}
