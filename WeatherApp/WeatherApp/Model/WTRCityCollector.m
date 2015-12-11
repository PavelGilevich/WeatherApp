//
//  WTRCityCollector.m
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import "WTRCityCollector.h"
#import "WTRCity.h"

@implementation WTRCityCollector

- (instancetype)initWithCities:(NSArray*)citiesArr
{
    self = [super init];
    if (self)
    {
        self.citiesArray = citiesArr;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *listArr = dictionary[@"list"];
        for (NSDictionary *cityObj in listArr)
        {
            WTRCity *city = [[WTRCity alloc]init];
            city.name = cityObj[@"name"];
            city.cityId = [(NSNumber*)cityObj[@"id"] integerValue];
            city.countyCode = [cityObj[@"sys"] objectForKey:@"country"];
            [tempArray addObject:city];
        }
        self.citiesArray = [NSArray arrayWithArray:tempArray];
    }
    return self;
}

- (WTRCity*)cityByIndex:(NSUInteger)index
{
    return self.citiesArray[index];
}
@end
