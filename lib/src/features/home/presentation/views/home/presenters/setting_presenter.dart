import 'package:qwid/src/configs/app_themes/app_images.dart';

class SettingPresenter {
  SettingPresenter({
    required this.icon,
    required this.text,
    required this.isNew
  });

  final String icon;
  final String text;
  final bool isNew;
}

final List<SettingPresenter> settings = [
  SettingPresenter(
    icon: icProfileProfile,
    text: 'My Profile',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileBell,
    text: 'Notification',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileTag,
    text: 'My listings',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileDraft,
    text: 'My drafts',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileSize,
    text: 'Edit my sizes',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileWallet,
    text: 'My wallet',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileMessage,
    text: 'Messages',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileHeart,
    text: 'Favorites',
    isNew: false,
  ),
  SettingPresenter(
    icon: icProfileGiftCard,
    text: 'Gift Cards',
    isNew: false,
  ),
  SettingPresenter(
    icon: icHandHeard,
    text: 'Refer friends & earn',
    isNew: true,
  ),
];