//
//  WTRForecast.h
//  WeatherApp
//
//  Created by System Administrator on 11.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRForecast : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *mainWeather;
@property (strong, nonatomic) NSString *detailWeather;
@property (strong, nonatomic) NSString *icon;
@property CGFloat humidity;
@property NSInteger pressure;
@property CGFloat windSpeed;
@property CGFloat windDegree;
@property CGFloat temperature;

@end
