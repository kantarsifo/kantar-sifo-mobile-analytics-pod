# Kantar Sifo Mobile Analytics SDK for iOS
This framework will enable your organisation to do mobile analytics and track user behaviour in your apps. 
It is only usable if your organisations has a mobile analytics account at Kantar Sifo: 

https://www.kantarsifo.se/kontakt. 

It is currently limited to Swedish customers only.

---
This framework is also available as a zip for manual installation, if you don't want to use cocoapods:   
https://github.com/kantarsifo/SifoInternetSDK 

This instruction assumes you have Cocoapods installed and are familiar with it.
Otherwise check instructions here: https://cocoapods.org/

You also need to have the 'Sifo Internet' panelist app installed on your test device. The 'Sifo Internet' app holds your Sifo ID details. Otherwise look here: https://apps.apple.com/se/app/sifo-internet/id1015394138

## Background

This framework tracks a user by making a formatted url call ('SendTag') with a cookie to a backend. Registered users are identified via a Sifo account and a UUID in the keychain (or NSUserDefaults if you don't want cross-app UUID sharing). The backend recognises the user via the cookie and the resource is tracked by the url. There a two types of users: Anonymous users and Orvesto panelists, who has opt-ed in to be tracked and is using a separat panelist app, called 'Sifo Internet'. It's optional to track all users or only panelist users.

This framework will open the 'Sifo Internet' app at first launch, if installed. If the 'Sifo Internet' app is configured correctly, then the 'Sifo Internet' app will in turn open your app almost directly, with a cookie in the app url. This cookie will be stored by the framework. It will also create a UUID in the keychain/NSUserDefaults. This UUID can be shared among your apps using a shared keychain or NSUserDefaults. After a successfull initialisation, the framework is ready to send your tracking tags to the analytics backend. You can track these tags using your tools obtained from Kantar Sifo upon registration.

To make this work, there a few things needed:
1. Allow your app to open the 'Sifo Internet' app in Info.plist
2. Add a shared keychain id to an Entitlements file (Optional)
3. Add the code below to integrate framework
4. Add SendTags according to your tracking needs

## Permissions

What permissions does the Sifo SDK require?

The Sifo SDK is happy with whatever permissions your app uses.

* If your app requests access to IDFA through the App Tracking Transparency framework the Sifo SDK will also get access to IDFA.
* If your app does not request access to IDFA the Sifo SDK will use the IDFV to track panelists.
* You control if the Sifo SDK shall attempt to use system identifiers (IDFA/IDFV) by setting the parameter `enableSystemIdentifierTracking`, see below. If no system identifiers are used, then only Kantar panel id:s will be used.


## Release notes (latest; see `release-notes.txt` for more)

5.1.0
- Optional setting (enableSystemIdentifierTracking) introduced to give app developers control over whether system identifiers can be used or not.
- Bug fixes

5.0.4
- SDK not longer uses AppTrackingTransparency framework.

5.0.3
- App start tag sent for apps.

5.0.2
- SDK now asks for tracking permission on iOS 14 for panelists.
- Added support for multiple webviews.

5.0.1
- Added support for iOS 14.
- Sifo panelists now sync with IDFA and IDFV.
- SDK can now detect faulty integration and warn about it.
- Bug fixes and improvements.

## Integrate - Framework

Minimum iOS deployment target: 9.0

**1. Add library to project**

Cocoapods:
``` Ruby
source 'https://github.com/kantarsifo/kantar-sifo-mobile-analytics-podspec.git'
``` 

``` Ruby
pod 'TSMobileAnalytics'
``` 

Manually:
1. Add MobileAnalytics.framework to your project and target.
2. In Build Phases -> Link Binary With Libraries, add Security.framework.

**2. Initialize the framework**

``` SWIFT
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TSMobileAnalytics.initialize(withCPID: ...,
                                     applicationName: ...,
                                     trackingType: ...,
                                     enableSystemIdentifierTracking: ...,
                                     isWebViewBased: ...,
                                     keychainAccessGroup: ...,
                                     additionals: [
                                         "comscore_client_id": ...
                                     ])
        return true
    }
}
```

* `CPID` - Your Kantar Sifo Analytics id.
* `ApplicationName` - Name of your app, can be anything you like that makes sense.
* `TrackingType` - Either `TrackPanelistsOnly` or `TrackUsersAndPanelists`.
* `enableSystemIdentifierTracking` - Determines if the SDK will attempt to use system identifiers.
  * `false` - This setting is sufficient for the Orvesto Internet measurement, the measurement will use Kantar Sifo panelist ID:s only.
  * `true` - This setting is mandatory if you participate in the MMS measurement. The Sifo SDK will attempt to fetch IDFA and IDFV (the SDK will never activate the Application Tracking Transparency popup, it is the responsibility for your app).
* `IsWebViewBased` - Set this to `true` if the app’s primary interface is displayed in one or many webviews.
* `KeychainAccessGroup` - (Optional) Your app id or a shared app id if you have several apps sharing a keychain and your want to track the user between apps. If you don't need to use Shared Keychain functionality, then set this to `nil`.
* `additionals` `comscore_client_id` - (Mandatory for the MMS measurement) Please contact Kantar Sifo for details (see Contact Information below).

## Integration - Panelist support

The purpose of this integration is to identify the user as a certain panelist. To allow the framework to integrate with the Panelist app you need to follow these additional integration steps.

**1. Add url scheme, query scheme and user tracking usage.**

Update your `info.plist` to include.
Add query scheme:
``` XML
<key>LSApplicationQueriesSchemes</key>
<array>
	<string>se.tns-sifo.internetpanelen</string>
</array>
```

Add url scheme with `<your_bundle_id>.tsmobileanalytics`:
``` XML
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>None</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>my.example.id.tsmobileanalytics</string>
    </array>
  </dict>
</array>
```

**2. Update Scene or App Delegate.**

To have this custom URL scheme picked up by the framework you have to implement the relevant method. If your app has a AppDelegate and a SceneDelegate then you should implement the SceneDelegate version. If your app only has a AppDelegate then implement the AppDelegate version.

SceneDelegate:
``` SWIFT
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
  for ctx in URLContexts {
    TSMobileAnalytics.application(UIApplication.shared, open: ctx.url, options: [:])
  }
}
```

AppDelegate:
``` SWIFT
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
  return TSMobileAnalytics.application(app, open: url, options: options)
}
```

**3. Set webview (hybrid apps only).**

If you app is webview based, you need to tell the framework which webviews to track by adding them:
``` SWIFT
TSMobileAnalytics.addWebview(webView)
```

And stop tracking it, if it's completely removed from the view hierarchy:
``` SWIFT
TSMobileAnalytics.removeWebview(webView)
```

**4. Shared Keychain (optional).**

If you provided a shared keychain access group.
Set `Keychain Sharing` to `ON` in the target Capabilities settings

## Sending tags

To get a good measure of the usage, your application should send a tag every time a new view or page of content is shown to the user. This tag should contain information about what content the user is seeing. For example when the user opens the application and its main view is shown, a tag should be sent. When the user shows a list, an article, a video or some other page in your application, another tag should be sent, and so on.

Streaming content is measured differently from regular content pages. “Stream started” is defined as when the actual content starts playing, after any pre-roll material that may precede it.

You need to use a unique value for “Stream started”, and use that value consistently across the app. We recommend that you synchronize this with the value you use to track “Stream started” on the web. Our recommendations is that you use one of the following values: `play`, `stream` or `webbtv`.

The framework can help you with the whole process of sending them to the server. The only thing it needs from you is for you to tell it when a view has been shown, and what content it has.

To send a tag:
``` SWIFT
TSMobileAnalytics.sendTag(withCategories: ...,
                          contentID: ...) { (success, error) in }
```

* Categories is an array of strings.
* Id is a string with the identifier of the current content.

### Encoding
All strings sent to the Sifo backend are encoded using utf-8. 

## Implementation check

Before the app is submitted to App Store, tests need to be performed according to instructions provided by Kantar Sifo. To validate that SDK collect panelist data properly. Please contact Kantar Sifo.

## Contact information

Please send any questions or feedback to:

[*peter.andersson@kantar.com*](mailto:peter.andersson@kantar.com)
+46 (0)701 842 372

[*info@kantarsifo.com*](mailto:info@kantarsifo.com)
+46 (0)8 507 420 00
