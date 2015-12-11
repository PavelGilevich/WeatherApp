//
//  WTRShortForecastTableViewController.m
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import "WTRShortForecastTableViewController.h"
#import "WTRForecastCollector.h"
#import "ShortForecastTableViewCell.h"
#import "WTRForecast.h"

@interface WTRShortForecastTableViewController ()

@property (nonatomic, strong) NSMutableData *weatherData;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) WTRForecastCollector *forecastCollector;

@end

@implementation WTRShortForecastTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.city.name;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.weatherData = [NSMutableData data];
    self.spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(160, 240);
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/city?id=%i&units=metric&appid=35c44cfff432f41df8ac9d9835f44cfe", self.city.cityId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    [connection start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NSURLConnectionDataDelegate methods


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receive data");
    [self.weatherData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finish loading");
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:self.weatherData options:0 error:nil];
    self.forecastCollector = [[WTRForecastCollector alloc]initWithForecast:weatherDictionary];
    [self.spinner stopAnimating];
    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Connection error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadImageByName:(NSString*)imageName atCellIndexPath:(NSIndexPath*)indexPath
{
    NSString *urlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",imageName];
    NSURL *imageURL = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [(ShortForecastTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath]weatherImageView].image = image;
        });
        
    });
    
    
}

- (NSString *)formatDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
   // [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   // NSDate *date = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"MMM dd"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.forecastCollector daysCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShortForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShortForecastCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShortForecastTableViewCell" owner:self options:nil];
        cell = nib[0];
    }
    WTRForecast *dayForecast = [self.forecastCollector forecastByDayIndex:indexPath.row];
    cell.mainWeatherLabel.text = dayForecast.mainWeather;
    cell.descriptionLabel.text = dayForecast.detailWeather;
    [self loadImageByName:dayForecast.icon atCellIndexPath:indexPath];
    cell.dateLabel.text = [self formatDate:dayForecast.date];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
