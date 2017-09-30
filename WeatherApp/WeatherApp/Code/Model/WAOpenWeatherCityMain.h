//
//  WAOpenWeatherCityMain.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "main": {
        "temp": 286.164,
        "pressure": 1017.58,
        "humidity": 96,
        "temp_min": 286.164,
        "temp_max": 286.164,
        "sea_level": 1027.69,
        "grnd_level": 1017.58
    }
    */





@interface WAOpenWeatherCityMain : NSObject <WARKModelObjectEntityMapping>

#pragma mark - temp
@property (nonatomic, readonly, strong, nullable) NSNumber* temp;

#pragma mark - pressure
@property (nonatomic, readonly, strong, nullable) NSNumber* pressure;

#pragma mark - humidity
@property (nonatomic, readonly, strong, nullable) NSNumber* humidity;

#pragma mark - minimumTemp
@property (nonatomic, readonly, strong, nullable) NSNumber* minimumTemp;

#pragma mark - maximumTemp
@property (nonatomic, readonly, strong, nullable) NSNumber* maximumTemp;

#pragma mark - seaLevel
@property (nonatomic, readonly, strong, nullable) NSNumber* seaLevel;

#pragma mark - groundLevel
@property (nonatomic, readonly, strong, nullable) NSNumber* groundLevel;

@end





@interface WAOpenWeatherCityMain_PropertiesForKVO : NSObject

#pragma mark - temp
+(nonnull NSString*)temp;

#pragma mark - pressure
+(nonnull NSString*)pressure;

#pragma mark - humidity
+(nonnull NSString*)humidity;

#pragma mark - minimumTemp
+(nonnull NSString*)minimumTemp;

#pragma mark - maximumTemp
+(nonnull NSString*)maximumTemp;

#pragma mark - seaLevel
+(nonnull NSString*)seaLevel;

#pragma mark - groundLevel
+(nonnull NSString*)groundLevel;

@end

