part of 'injections.dart';

void injectPaymentDependencies(GetIt di) {
  di
    .registerSingleton<PaymentCubit>(PaymentCubit(di<PaymentRepository>(), di<ProfileRepository>()));
}