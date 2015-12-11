//
//  WTRForecast.m
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import "WTRForecastCollector.h"


@implementation WTRForecastCollector

- (instancetype)initWithForecast:(NSDictionary*)weatherDictionary
{
    self = [super init];
    if (self)
    {
        self.weatherFullForecast = weatherDictionary;
        self.cuttedForecastArr = [NSMutableArray array];
        NSMutableArray *tempForecasts = [NSMutableArray array];
        NSArray *forecastArray = self.weatherFullForecast[@"list"];
        for (NSDictionary *forecastObject in forecastArray)
        {
            WTRForecast *forecast = [[WTRForecast alloc]init];
            NSDictionary *mainDict = forecastObject[@"main"];
            forecast.temperature = [(NSNumber*)mainDict[@"temp"]floatValue];
            forecast.pressure = [(NSNumber*)mainDict[@"pressure"]floatValue];
            forecast.humidity = [(NSNumber*)mainDict[@"humidity"]floatValue];
           
            NSDictionary *windDict = forecastObject[@"wind"];
            forecast.windSpeed = [(NSNumber*)windDict[@"speed"]floatValue];
            forecast.windDegree = [(NSNumber*)windDict[@"deg"]floatValue];
            
            NSDictionary *weatherDict = [forecastObject[@"weather"] objectAtIndex:0];
            forecast.mainWeather = weatherDict[@"main"];
            forecast.detailWeather = weatherDict[@"description"];
            forecast.icon = weatherDict[@"icon"];
            
            NSString *dateString = forecastObject[@"dt_txt"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            forecast.date = [dateFormatter dateFromString:dateString];

            [tempForecasts addObject:forecast];
            
            if ([(NSString*)forecastObject[@"dt_txt"] rangeOfString:@"12:00:00"].location == NSNotFound)
            {
                continue;
            }
            else
            {
                [self.cuttedForecastArr addObject:forecast];
            }
        }
    }
    return self;
}

- (WTRForecast*)forecastByDayIndex:(NSUInteger)dayIndex
{
    return self.cuttedForecastArr[dayIndex];
}

- (NSUInteger)daysCount
{
    return self.cuttedForecastArr.count;
}
@end
