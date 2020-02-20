#import <Foundation/Foundation.h>

typedef enum {
    TSMobileAnalyticsProviderCodigo
} TSMobileAnalyticsProvider;

typedef enum {
    TSInputSuccess,
    TSInputCategoryNil,
    TSInputCategoryTooLong,
    TSInputContentIdTooLong,
    TSInputContentNameTooLong,
    TSInputPanelistIdMissing
} TSInputValidation;

extern int const cpidMaxLengthCodigo;

extern int const appNameMaxLength;
extern int const categoryMaxLength;
extern int const extraMaxLength;
extern int const contentMaxLength;
extern NSString * const prefixIpad;
extern NSString * const prefixIphone;

extern NSString * const codigoBaseURL;
extern NSString * const taggingEuidq;
extern NSString * const userIDKey;
extern NSString * const userdefaultsCookieKey;

extern NSString * const kPanelenApp;
extern NSString * const kInternetApp;
extern NSString * const kServiceName;

extern NSString * const kInternetApplicationScheme;
extern NSString * const kLegacyApplicationScheme;

#define isExternalApplication(sourceApplication) [@[kPanelenApp, kInternetApp] containsObject:sourceApplication]
