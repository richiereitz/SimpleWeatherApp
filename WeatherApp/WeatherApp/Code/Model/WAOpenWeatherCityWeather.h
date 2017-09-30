//
//  WAOpenWeatherCityWeather.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "weather": [
        {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10n"
        }
        */





@interface WAOpenWeatherCityWeather : NSObject <WARKModelObjectEntityMapping>

#pragma mark - identifier
@property (nonatomic, readonly, strong, nullable) NSNumber* identifier;

#pragma mark - main
@property (nonatomic, readonly, strong, nullable) NSString* main;

#pragma mark - weatherDescription
@property (nonatomic, readonly, strong, nullable) NSString* weatherDescription;

#pragma mark - icon
@property (nonatomic, readonly, strong, nullable) NSString* icon;

@end





@interface WAOpenWeatherCityWeather_PropertiesForKVO : NSObject

#pragma mark - identifier
+(nonnull NSString*)identifier;

#pragma mark - main
+(nonnull NSString*)main;

#pragma mark - weatherDescription
+(nonnull NSString*)weatherDescription;

#pragma mark - icon
+(nonnull NSString*)icon;

@end
