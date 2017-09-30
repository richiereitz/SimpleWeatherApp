//
//  WAOpenWeatherRain.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "rain": {
        "3h": 0.185
    }
    */





@interface WAOpenWeatherRain : NSObject <WARKModelObjectEntityMapping>

#pragma mark - degreeOfRain
@property (nonatomic, readonly, strong, nullable) NSNumber* degreeOfRain;

@end





@interface WAOpenWeatherRain_PropertiesForKVO : NSObject

#pragma mark - degreeOfRain
+(nonnull NSString*)degreeOfRain;

@end
