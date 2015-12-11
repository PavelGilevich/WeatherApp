//
//  WTRCity.h
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTRCity : NSObject

@property NSInteger cityId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *countyCode;

- (instancetype)initWithName:(NSString*)name countryCode:(NSString*)code cityId:(NSInteger)cityId;
@end
