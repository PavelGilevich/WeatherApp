//
//  WTRViewController.m
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import "WTRViewController.h"
#import "WTRShortForecastTableViewController.h"
#import "WTRCityTableViewController.h"
#import "WTRCityCollector.h"

@interface WTRViewController ()

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (weak, nonatomic) IBOutlet UIButton *openMapButton;

@property (strong, nonatomic) IBOutlet UITableView *cityTableView;

@property (strong, nonatomic) WTRCityTableViewController *cityVC;
@property (strong, nonatomic) NSMutableData *cityData;
@end

@implementation WTRViewController 

static const NSString *appID = @"35c44cfff432f41df8ac9d9835f44cfe";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cityData = [NSMutableData data];
    [self.searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.cityTextField.delegate = self;
    //[self.cityTextField addTarget:self action:@selector(textFieldTextEdited:) forControlEvents:UIControlEventEditingChanged];
    self.cityVC = [[WTRCityTableViewController alloc]init];
    [self addChildViewController:self.cityVC];
    self.cityTableView.delegate = self.cityVC;
    self.cityTableView.dataSource = self.cityVC;
    self.cityTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchButtonPressed:(id)sender
{
    self.cityData = [NSMutableData data];
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.openweathermap.org/data/2.5/find?q=%@&type=like&appid=35c44cfff432f41df8ac9d9835f44cfe", self.cityTextField.text];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark NSURLConnectionDataDelegate methods


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receive data");
    [self.cityData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finish loading");
    NSDictionary *citiesDictionary = [NSJSONSerialization JSONObjectWithData:self.cityData options:0 error:nil];
    WTRCityCollector *cityCollector = [[WTRCityCollector alloc]initWithDictionary:citiesDictionary];
    self.cityVC.cityCollector = cityCollector;
    [self.cityTableView reloadData];
}
/*
- (void)textFieldTextEdited:(UITextField *)sender
{
    
}
*/
#pragma mark Segue
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSURL *baseURL = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast/city?id=625144&units=metric&appid=35c44cfff432f41df8ac9d9835f44cfe"];
    WTRShortForecastTableViewController *shortForecastVC = [segue destinationViewController];
    shortForecastVC.requestURL = baseURL;
}*/
@end
