//
//  WTRForecast.h
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRForecast.h"

@interface WTRForecastCollector : NSObject

extern NSString *const timeOfDayString;

@property (strong, nonatomic) NSDictionary *weatherFullForecast;

@property (strong, nonatomic) NSMutableArray *cuttedForecastArr;
@property (strong, nonatomic) NSArray *allForecasts;

- (instancetype)initWithForecast:(NSDictionary*) weatherDictionary;
- (WTRForecast*)forecastByDayIndex:(NSUInteger) dayIndex;
- (NSUInteger)daysCount;

@end
