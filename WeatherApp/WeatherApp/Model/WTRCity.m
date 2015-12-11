//
//  WTRCity.m
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import "WTRCity.h"

@implementation WTRCity

- (instancetype)initWithName:(NSString*)name countryCode:(NSString*)code cityId:(NSInteger)cityId
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.countyCode = code;
        self.cityId = cityId;
    }
    return self;
}
@end
