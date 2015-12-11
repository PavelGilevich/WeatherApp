//
//  WTRCityCollector.h
//  WeatherApp
//
//  Created by System Administrator on 10.12.15.
//  Copyright (c) 2015 Pavel Gilevich. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WTRCityCollector : NSObject

@property (strong, nonatomic) NSArray *citiesArray;

- (instancetype)initWithCities:(NSArray*)citiesArr;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
