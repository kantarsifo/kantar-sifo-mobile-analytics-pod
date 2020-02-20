#import <UIKit/UIKit.h>
#import "TSMobileAnalyticsConstants.h"

@interface TSMobileAnalytics : NSObject

@property (nonatomic, readonly) NSString *cpid;
@property (nonatomic, readonly) NSString *applicationName;
@property (nonatomic, readonly) NSString *keychainAccessGroup;
@property (nonatomic) BOOL logPrintsActivated;
@property (nonatomic) BOOL trackPanelistOnly;
@property (nonatomic, readonly) TSMobileAnalyticsProvider analyticsProvider;

/**
 * Designated framework initializer.
 * @param cpid The customer specific CPID provided the customer by TNS Sifo. Cannot be nil nor empty.
 * @param appName The unique application name to identify the app. Cannot be nil nor empty.
 * @param trackPanelist Set this to true if you wish to track a logged in SIFO panelist.
 * @param keychainAccessGroup set this to your keychain property, to share userId across applications with the same bundle seed. 
 * @return The instance of the framework.
 */
+ (TSMobileAnalytics *)createInstanceWithCPID:(NSString *)cpid applicationName:(NSString *)appName trackPanelist:(BOOL)trackPanelist keychainAccessGroup:(NSString *)keychainAccessGroup;

/**
 ** @return shared instance of the framework.
 */
+ (TSMobileAnalytics *)sharedInstance;

/**
 ** Enable logging.
 ** @param logPrintsActivated set this to YES to enable logging.
 */
+ (void)setLogPrintsActivated:(BOOL)logPrintsActivated;

/**
 * Set this to true if you wish to track SIFO panelists only.
 */
+ (void)setTrackPanelistOnly:(BOOL)trackPanelistOnly;

/**
 * Validate your parameters before sending a tag.
 * @return TSInputValidation enum containing info about what parameter is faulty.
 */
+ (int)validateInputParametersWithCategory:(NSString*)category
                        contentID:(NSString*)contentID contentName:(NSString*)contentName;

/**
 * Send a tag.
 * @param categories NSArray with string/s. 
 * @param contentName Optional The contentName for the tag.
 * @param contentId Optional The contentID for the tag.
 * @param completionBlock Optional block to be executed on completion.
 */
+ (void)sendTagWithCategories:(NSArray*)categories contentName:(NSString *)contentName contentID:(NSString *)contentID completion:(void (^)(BOOL success, NSError *error))completionBlock;

/**
 * This method needs to be implemented in your app's appdelegate method with the same name, if you wish to track a panelist.
 * Forward the openURL:-call to the framework.
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end
