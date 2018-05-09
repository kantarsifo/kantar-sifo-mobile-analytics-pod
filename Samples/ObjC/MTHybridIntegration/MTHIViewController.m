//
//  MTHIViewController.m
//  TSMobileAnalyticsIntegration
//
//  Copyright (c) 2016 TNS Sifo AB. All rights reserved.
//

#import "MTHIViewController.h"
#import <TSMobileAnalytics/TSMobileAnalytics.h>

@interface MTHIViewController ()

// -- Interface
@property (nonatomic, readwrite, retain) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

// -- Model
@property (atomic, readwrite, retain) NSArray *urlArray;

@end

@implementation MTHIViewController

@synthesize tableView = _tableView;
@synthesize webView = _webView;
@synthesize urlArray = _urlArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.urlArray = [NSArray arrayWithObjects:@"https://google.com/", @"http://expressen.se/", @"https://mobil.dn.se/", nil];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.urlArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"urlCell"];

    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"urlCell"];
    }

    cell.textLabel.text = [self.urlArray objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *urlString = [self.urlArray objectAtIndex:indexPath.row];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];

    [self.webView loadRequest:urlRequest];
}

@end
