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
 * @param appName The unique application name to identify the app. Cannot be nil nor empty. Can be anything you like that makes sense.
 * @param trackingType Set to your appropriate tracking type.
 * @param webViewBased Set this to true if the application is primarily based on HTML/JavaScript running in web views
 * @param keychainAccessGroup set this to your keychain property, to share userId across applications with the same bundle seed.
 * @param additionals Set this to send any additional data to sync with panelist app.
 */
+ (void)initializeWithCPID:(nonnull NSString *)cpid
           applicationName:(nonnull NSString *)appName
              trackingType:(TrackingType)trackingType
enableSystemIdentifierTracking:(BOOL)enableSystemIdentifierTracking
            isWebViewBased:(BOOL)webViewBased
       keychainAccessGroup:(nullable NSString *)keychainAccessGroup
               additionals:(nullable NSDictionary <NSString *, NSString *> *)additionals;

+ (void)initializeWithCPID:(nonnull NSString *)cpid
           applicationName:(nonnull NSString *)appName
              trackingType:(TrackingType)trackingType
enableSystemIdentifierTracking:(BOOL)enableSystemIdentifierTracking
            isWebViewBased:(BOOL)webViewBased
       keychainAccessGroup:(nullable NSString *)keychainAccessGroup;

+ (void)initializeWithCPID:(nonnull NSString *)cpid
           applicationName:(nonnull NSString *)appName
              trackingType:(TrackingType)trackingType
enableSystemIdentifierTracking:(BOOL)enableSystemIdentifierTracking
       keychainAccessGroup:(nullable NSString *)keychainAccessGroup;

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
+ (void)sendTagWithCategories:(nonnull NSArray <NSString *> *)categories
                    contentID:(nullable NSString *)contentID
                   completion:(nullable void (^)(BOOL success, NSError * _Nullable error))completionBlock;

/**
 * This method needs to be implemented in your app's appdelegate method with the same name, if you wish to track a panelist.
 * Forward the openURL:-call to the framework.
 */
+ (BOOL)application:(nonnull UIApplication *)application
            openURL:(nonnull NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/**
 * Add webview to be part of the tracking.
 * Webview must be added for framework to be tracked properly.
 * Only add webviews that you actually want to track.
 */
+ (void)addWebview:(nonnull WKWebView *)webview;

/**
 * Remove webview from the tracking.
 * Remove webview when the webview is completly removed from the view hierarchy (not just hidden).
 */
+ (void)removeWebview:(nonnull WKWebView *)webview;

@end
