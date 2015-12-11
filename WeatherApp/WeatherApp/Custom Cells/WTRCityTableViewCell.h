//
//  WTRCityTableViewCell.h
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTRCityTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (nonatomic, weak) IBOutlet UILabel *countryCodeLabel;

@end
