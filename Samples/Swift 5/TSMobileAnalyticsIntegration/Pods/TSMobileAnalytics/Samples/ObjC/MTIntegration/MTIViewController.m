
#import "MTIViewController.h"
#import <TSMobileAnalytics/TSMobileAnalytics.h>

@interface MTIViewController ()

@end

@implementation MTIViewController

- (IBAction)sendTag:(id)sender {
    [TSMobileAnalytics sendTagWithCategories:@[@"category-testios"]
                                   contentID:@"123-contentID"
                                  completion:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            // Handle error.
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [TSMobileAnalytics sendTagWithCategories:@[@"category-testios"]
                                   contentID:@"123-contentID"
                                  completion:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            // Handle error.
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

@end
