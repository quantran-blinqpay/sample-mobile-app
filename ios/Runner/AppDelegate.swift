import UIKit
import Flutter
import Braintree

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    BTAppContextSwitcher.setReturnURLScheme("nz.co.designerwardrobe.DesignerWardrobe.payments")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    if url.scheme == "nz.co.designerwardrobe.DesignerWardrobe.payments" {
      return BTAppContextSwitcher.handleOpenURL(url)
    }
    return super.application(app, open: url, options:  options);
  }
}
