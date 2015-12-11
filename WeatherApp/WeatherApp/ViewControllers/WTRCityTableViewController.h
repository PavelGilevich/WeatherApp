//
//  WTRCityTableViewController.h
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRCityCollector.h"

@interface WTRCityTableViewController : UITableViewController

@property (strong, nonatomic) WTRCityCollector *cityCollector;

@end
