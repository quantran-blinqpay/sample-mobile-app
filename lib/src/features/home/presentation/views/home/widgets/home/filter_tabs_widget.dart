import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/filter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class FilterTabsWidget extends StatelessWidget {
  final List<CategoryEntity> categories;

  const FilterTabsWidget({required this.categories, super.key});
  static final String tokenizationKey = 'eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSXNJbWx6Y3lJNkltaDBkSEJ6T2k4dllYQnBMbk5oYm1SaWIzZ3VZbkpoYVc1MGNtVmxaMkYwWlhkaGVTNWpiMjBpZlEuZXlKbGVIQWlPakUzTlRVM056STBPRGdzSW1wMGFTSTZJbUZqWVdJeU5XRTBMVEZrWm1RdE5ERmpZeTA1WTJZM0xUSTBORGcyT1dNMVpURXdNeUlzSW5OMVlpSTZJamM1YURONGNUWnlibkUwZW1kek9XWWlMQ0pwYzNNaU9pSm9kSFJ3Y3pvdkwyRndhUzV6WVc1a1ltOTRMbUp5WVdsdWRISmxaV2RoZEdWM1lYa3VZMjl0SWl3aWJXVnlZMmhoYm5RaU9uc2ljSFZpYkdsalgybGtJam9pTnpsb00zaHhObkp1Y1RSNlozTTVaaUlzSW5abGNtbG1lVjlqWVhKa1gySjVYMlJsWm1GMWJIUWlPbVpoYkhObExDSjJaWEpwWm5sZmQyRnNiR1YwWDJKNVgyUmxabUYxYkhRaU9tWmhiSE5sZlN3aWNtbG5hSFJ6SWpwYkltMWhibUZuWlY5MllYVnNkQ0pkTENKelkyOXdaU0k2V3lKQ2NtRnBiblJ5WldVNlZtRjFiSFFpWFN3aWIzQjBhVzl1Y3lJNmV5SndZWGx3WVd4ZlkyeHBaVzUwWDJsa0lqb2lRV0pNUkdzeGFrMXFWbkpsYUhOeFJ6aHZSVlk0U20xUVUwcHlhVTF2T1VOU1lsRlZaVTFOV0haRWMyZHRNSEZ1Um0xU1FtaHhjR3RyTlVadVRHUjNRMHMxTlc1TVYzbHlNMDR0WjFaM1FYQWlmWDAuX1NsZGZiNUNpUkY0TVlTQVpBUm1ZVENwM2c4N3ZkcVVBWGE2U3gwc0tzYWhDclhESTdZaDVDbkVzNUYydWU5a2dtRW5HNWlsdm9yWE9JV3l0eDVFMXciLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvNzloM3hxNnJucTR6Z3M5Zi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgiLCJmZWF0dXJlcyI6WyJ0b2tlbml6ZV9jcmVkaXRfY2FyZHMiXX0sImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy83OWgzeHE2cm5xNHpnczlmL2NsaWVudF9hcGkiLCJlbnZpcm9ubWVudCI6InNhbmRib3giLCJtZXJjaGFudElkIjoiNzloM3hxNnJucTR6Z3M5ZiIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwidmVubW8iOiJvZmYiLCJjaGFsbGVuZ2VzIjpbImN2diJdLCJ0aHJlZURTZWN1cmVFbmFibGVkIjp0cnVlLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9vcmlnaW4tYW5hbHl0aWNzLXNhbmQuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS83OWgzeHE2cm5xNHpnczlmIn0sInBheXBhbEVuYWJsZWQiOnRydWUsInBheXBhbCI6eyJiaWxsaW5nQWdyZWVtZW50c0VuYWJsZWQiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjpmYWxzZSwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImFsbG93SHR0cCI6dHJ1ZSwiZGlzcGxheU5hbWUiOiJEZXNpZ25lciBXYXJkcm9iZSIsImNsaWVudElkIjoiQWJMRGsxak1qVnJlaHNxRzhvRVY4Sm1QU0pyaU1vOUNSYlFVZU1NWHZEc2dtMHFuRm1SQmhxcGtrNUZuTGR3Q0s1NW5MV3lyM04tZ1Z3QXAiLCJhY2NvdW50TnVtYmVyIjpudWxsLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJicmFpbnRyZWVDbGllbnRJZCI6Im1hc3RlcmNsaWVudDMiLCJtZXJjaGFudEFjY291bnRJZCI6InRlc3RfbnpkX2FjY291bnRfaWQiLCJjdXJyZW5jeUlzb0NvZGUiOiJOWkQifX0=';

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () async {
                final request = BraintreeCreditCardRequest(
                  cardNumber: '4111111111111111',
                  expirationMonth: '12',
                  expirationYear: '2021',
                  cvv: '123',
                );
                final result = await Braintree.tokenizeCreditCard(
                  tokenizationKey,
                  request,
                );
                if (result != null) {
                  showNonce(context, result);
                  debugPrint('quanth: result?.nonce= ${result.nonce}');
                }
                debugPrint('quanth: result?.nonce= null');
              },
              child: FilterItemWidget(categories[index].categoryName ?? ''));
        },
      ),
    );
  }

  void showNonce(BuildContext context, BraintreePaymentMethodNonce nonce) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }
}