//
//  WAOpenWeatherCityWind.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "wind": {
        "speed": 3.61,
        "deg": 165.001
    }
    */





@interface WAOpenWeatherCityWind : NSObject <WARKModelObjectEntityMapping>

#pragma mark - speed
@property (nonatomic, readonly, strong, nullable) NSNumber* speed;

#pragma mark - deg
@property (nonatomic, readonly, strong, nullable) NSNumber* deg;

@end





@interface WAOpenWeatherCityWind_PropertiesForKVO : NSObject

#pragma mark - speed
+(nullable NSString*)speed;

#pragma mark - deg
+(nullable NSString*)deg;

@end
