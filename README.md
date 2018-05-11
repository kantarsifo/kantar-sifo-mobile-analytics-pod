Kantar Sifo Mobile Analytics SDK for iOS
---
This framework will enable your organisation to do mobile analytics and track user behaviour in your apps. 
It is only usable if your organisations has a mobile analytics account at Kantar Sifo: 

https://www.kantarsifo.se/kontakt. 

It is currently limited to Swedish customers only.

---
This framework is also available as a zip for manual installation, if you don't want to use cocoapods:   
https://github.com/kantarsifo/SifoInternetSDK 

This instruction assumes you have Cocoapods installed and are familiar with it.
Otherwise check instructions here: https://cocoapods.org/

You also need to have the 'Sifo Internet' panelist app installed on your test device. The 'Sifo Internet' app holds your Sifo ID details. Otherwise look here: https://itunes.apple.com/se/app/sifo-internet/id1015394138?mt=8

**Background:**
---
This framework tracks a user by making a formatted url call ('SendTag') with a cookie to a backend. The user is identified via a Sifo account and a UUID in the keychain. The backend recognises the user via the cookie and the resource is tracked by the url. 

This framework will open the 'Sifo Internet' app at first launch, if installed. If the 'Sifo Internet' app is configured correctly, then the 'Sifo Internet' app will in turn open your app almost directly, with a cookie in the app url. This cookie will be stored by the framework. It will also create a UUID in the keychain. This UUID can be shared among your apps using a shared keychain. After a successfull initialisation, the framework is ready to send your tracking tags to the analytics backend. You can track these tags using your tools obtained from Kantar Sifo upon registration.

The framework will refresh the cookie by repeating the open the 'Sifo Internet' app procedure every third month.

To make this work, there a few things needed:
1. Allow your app to open the 'Sifo Internet' app in Info.plist
2. Add a shared keychain id to an Entitlements file
3. Add the code below to the AppDelegate
4. Add SendTags according to your tracking needs

**Implementation instructions:**
---
Code instruction below is in **Swift** only to keep this instruction short.  **Objective-C** examples are available in the Documentation folder 

Add this to your Podfile:
``` SWIFT
source 'https://github.com/kantarsifo/kantar-sifo-mobile-analytics-podspec.git'
pod 'TSMobileAnalytics' 
```
and then run `pod install`

Add this to AppDelegate:
``` SWIFT
import TSMobileAnalytics
```
in `func application ... didFinishLaunchingWithOptions...` add this:
``` SWIFT
    TSMobileAnalytics.createInstance(withCPID: "CPID", applicationName: "APPURL", 
        trackPanelist: true, keychainAccessGroup: "KEYCHAINACCESSGROUP")
    TSMobileAnalytics.setLogPrintsActivated(false) //true will print to the debug log
```
This will initate the TSMobileAnalytics and start the 'Sifo Internet' app. Replace the variables above.

**CPID** : Your Kantar Sifo Analytics id  
**APPURL** : Your app CFBundleURLSchemes, like 'twitter' or 'com.xxx.myapp'   
**KEYCHAINACCESSGROUP** : Your app id or a shared app id if you have several apps sharing keychain and your want to track the user between apps  


In order to save the cookie from the 'Sifo Internet' app, this function is needed in the AppDelegate: 
``` SWIFT
    func application(_ app: UIApplication, open url: URL, 
        options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return TSMobileAnalytics.sharedInstance().application(app, open: url, options: options)
    }
```

With this, code is complete. Now follows setup to make inter-app communcation possible

----
Set `Keychain Sharing` to `ON` in the target Capabilities settings
This corresponds to the **KEYCHAINACCESSGROUP** above

Change this line in the `.entitlements` file if you need something else than the default:
``` XML
	<array>
		<string>$(AppIdentifierPrefix)com.xxx.myapp_or_shared_keychain</string>
	</array>
```

To allow your app to open the 'Sifo Internet' app, add this to Info.plist
``` XML
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>se.tns-sifo.'Sifo Internet'</string>
		<string>se.tns-sifo.sifopanelen</string>
	</array>
```

To enable the 'Sifo Internet' app to open your app, add this to Info.plist
`com.xxx.myappscheme` corresponds to the **APPURL** above
``` XML
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLName</key>
			<string>com.xxx.myapp</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>com.xxx.myappscheme</string>
			</array>
		</dict>
	</array>
```

Now all setup is complete!

----
The only thing left to do is to create **SendTag** tracking calls formatted according to the documentation.

**Example:**
``` SWIFT
        TSMobileAnalytics.sendTag(withCategories: ["MyCategory"], contentName: "", 
        contentID: "myContentID") { (success, error) in
            if let tError = error {
                // Handle error.
                print("Error: \(tError.localizedDescription)")
            }
        }
```

**Please read the documentation for more detailed instructions**

----

