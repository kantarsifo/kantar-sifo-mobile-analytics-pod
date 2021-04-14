//
//  TSMobileTaggingIntegrationTests.m
//  TSMobileTaggingIntegrationTests
//
//  Created by Johanna Sinkkonen on 07/04/16.
//
//

#import <XCTest/XCTest.h>
#import <TSMobileAnalytics/TSMobileAnalytics.h>

@interface TSMobileAnalyticsIntegrationTests : XCTestCase

@end

@implementation TSMobileAnalyticsIntegrationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSendTag {
    XCTestExpectation *expectation = [self expectationWithDescription:@"success"];
    [TSMobileAnalytics sendTagWithCategories:@[@"aCategory"] contentName:@"someContentName" contentID:@"someContentId" completion:^(BOOL success, NSError *error) {
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertNil(error);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
