import UIKit
import Flutter
import GoogleMaps
import FBSDKCoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDVxCnJfJAsem75m89aCg8AYeqmElt8XpM")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
