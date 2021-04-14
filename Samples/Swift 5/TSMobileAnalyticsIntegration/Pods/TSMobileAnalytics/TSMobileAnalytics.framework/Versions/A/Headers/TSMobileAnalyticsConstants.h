#import <Foundation/Foundation.h>

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

extern NSString * const sifoBaseURL;
extern NSString * const codigoBaseURL;
extern NSString * const taggingEuidq;
extern NSString * const userIDKey;

extern NSString * const userdefaultsCookieKey;
extern NSString * const userdefaultsSdkVersionKey;
extern NSString * const userdefaultsTrackingStatusKey;
extern NSString * const userdefaultsLastSyncKey;

extern NSString * const secretOptionTrackIdfa;
extern NSString * const secretOptionTrackIdfv;
extern NSString * const secretOptionSyncWithBackendFirst;
extern NSString * const secretOptionUseJsonUrlSchemeSyncFormat;
extern NSString * const secretOptionForceReinitialize;

extern NSString * const kPanelenApp;
extern NSString * const kInternetApp;
extern NSString * const kServiceName;

extern NSString * const kInternetApplicationScheme;

extern NSString * const kExchangeURLSchemeSuffix;

#define isExternalApplication(sourceApplication) [@[kPanelenApp, kInternetApp] containsObject:sourceApplication]
