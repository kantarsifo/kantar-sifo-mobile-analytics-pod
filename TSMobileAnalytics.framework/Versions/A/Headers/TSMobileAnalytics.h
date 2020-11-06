#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSUInteger, TrackingType) {
    TrackUsersAndPanelists,
    TrackPanelistsOnly
};

@interface TSMobileAnalytics : NSObject
/**
 * Designated framework initializer.
 * @param cpid The customer specific CPID provided the customer by TNS Sifo. Cannot be nil nor empty.
 * @param appName The unique application name to identify the app. Cannot be nil nor empty.
 * @param trackingType Set to your appropriate tracking type.
 * @param webViewBased Set this to true if the application is primarily based on HTML/JavaScript running in web views
 * @param keychainAccessGroup set this to your keychain property, to share userId across applications with the same bundle seed.
 * @param additionals Set this to send any additional data to sync with panelist app.
 */
+ (void)initializeWithCPID:(NSString *)cpid
           applicationName:(NSString *)appName
              trackingType:(TrackingType)trackingType
            isWebViewBased:(BOOL)webViewBased
       keychainAccessGroup:(NSString *)keychainAccessGroup
               additionals:(NSDictionary <NSString *, NSString *> *)additionals;

+ (void)initializeWithCPID:(NSString *)cpid
           applicationName:(NSString *)appName
              trackingType:(TrackingType)trackingType
            isWebViewBased:(BOOL)webViewBased
       keychainAccessGroup:(NSString *)keychainAccessGroup;

+ (void)initializeWithCPID:(NSString *)cpid
           applicationName:(NSString *)appName
              trackingType:(TrackingType)trackingType
       keychainAccessGroup:(NSString *)keychainAccessGroup;

/**
 ** Enable logging.
 ** @param logPrintsActivated set this to YES to enable logging.
 */
+ (void)setLogPrintsActivated:(BOOL)logPrintsActivated;

/**
 * Send a tag.
 * @param categories NSArray with string/s. 
 * @param contentID Optional The contentID for the tag.
 * @param completionBlock Optional block to be executed on completion.
 */
+ (void)sendTagWithCategories:(NSArray <NSString *> *)categories
                    contentID:(NSString *)contentID
                   completion:(void (^)(BOOL success, NSError *error))completionBlock;

/**
 * This method needs to be implemented in your app's appdelegate method with the same name, if you wish to track a panelist.
 * Forward the openURL:-call to the framework.
 */
+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/**
 * Set main webview for webbased app.
 * Must be set for framework to work properly with hybrid apps.
 * If native app, don't use this.
 */
+ (void)setWebView:(WKWebView *)webview;

@end
