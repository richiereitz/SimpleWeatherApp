//
//  WAOpenWeatherCity.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
Example WAOpenWeatherCity object fromhttp://openweathermap.org/weather-conditions:
{
    "coord": {
        "lon": -0.13,
        "lat": 51.51
    },
    "weather": [
        {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10n"
        }
    ],
    "base": "cmc stations",
    "main": {
        "temp": 286.164,
        "pressure": 1017.58,
        "humidity": 96,
        "temp_min": 286.164,
        "temp_max": 286.164,
        "sea_level": 1027.69,
        "grnd_level": 1017.58
    },
    "wind": {
        "speed": 3.61,
        "deg": 165.001
    },
    "rain": {
        "3h": 0.185
    },
    "clouds": {
        "all": 80
    },
    "dt": 1446583128,
    "sys": {
        "message": 0.003,
        "country": "GB",
        "sunrise": 1446533902,
        "sunset": 1446568141
    },
    "id": 2643743,
    "name": "London",
    "cod": 200
}
*/





@class WAOpenWeatherCityCoordinate;
@class WAOpenWeatherCityWeather;
@class WAOpenWeatherCityMain;
@class WAOpenWeatherCityWind;
@class WAOpenWeatherRain;
@class WAOpenWeatherClouds;
@class WAOpenWeatherCitySys;





@interface WAOpenWeatherCity : NSObject <WARKModelObjectEntityMapping>

#pragma mark - coordinate
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherCityCoordinate* coord;

#pragma mark - weather
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherCityWeather* weather;

#pragma mark - base
@property (nonatomic, readonly, copy, nullable) NSString* base;

#pragma mark - main
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherCityMain* main;

#pragma mark - wind
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherCityWind* wind;

#pragma mark - rain
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherRain* rain;

#pragma mark - clouds
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherClouds* clouds;

#pragma mark - dt
@property (nonatomic, readonly, copy, nullable) NSNumber* dt;

#pragma mark - sys
@property (nonatomic, readonly, copy, nullable) WAOpenWeatherCitySys* sys;

#pragma mark - identifier
@property (nonatomic, readonly, copy, nullable) NSNumber* identifier;

#pragma mark - name
@property (nonatomic, readonly, copy, nullable) NSString* name;

#pragma mark - cod
@property (nonatomic, readonly, copy, nullable) NSString* cod;

@end





@interface WAOpenWeatherCity_PropertiesForKVO : NSObject

#pragma mark - coordinate
+(nonnull NSString*)coordinate;

#pragma mark - weather
+(nonnull NSString*)weather;

#pragma mark - base
+(nonnull NSString*)base;

#pragma mark - main
+(nonnull NSString*)main;

#pragma mark - wind
+(nonnull NSString*)wind;

#pragma mark - rain
+(nonnull NSString*)rain;

#pragma mark - clouds
+(nonnull NSString*)clouds;

#pragma mark - dt
+(nonnull NSString*)dt;

#pragma mark - sys
+(nonnull NSString*)sys;

#pragma mark - identifier
+(nonnull NSString*)identifier;

#pragma mark - name
+(nonnull NSString*)name;

#pragma mark - cod
+(nonnull NSString*)cod;

@end

