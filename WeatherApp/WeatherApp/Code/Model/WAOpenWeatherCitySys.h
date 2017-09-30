//
//  WAOpenWeatherCitySys.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "sys": {
        "message": 0.003,
        "country": "GB",
        "sunrise": 1446533902,
        "sunset": 1446568141
    }
    */





@interface WAOpenWeatherCitySys : NSObject <WARKModelObjectEntityMapping>

#pragma mark - message
@property (nonatomic, readonly, strong, nullable) NSNumber* message;

#pragma mark - country
@property (nonatomic, readonly, strong, nullable) NSString* country;

#pragma mark - sunrise
@property (nonatomic, readonly, strong, nullable) NSNumber* sunrise;

#pragma mark - sunset
@property (nonatomic, readonly, strong, nullable) NSNumber* sunset;

@end





@interface WAOpenWeatherCitySys_PropertiesForKVO : NSObject

#pragma mark - message
+(nonnull NSString*)message;

#pragma mark - country
+(nonnull NSString*)country;

#pragma mark - sunrise
+(nonnull NSString*)sunrise;

#pragma mark - sunset
+(nonnull NSString*)sunset;

@end

