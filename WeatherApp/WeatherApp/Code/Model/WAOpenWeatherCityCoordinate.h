//
//  WAOpenWeatherCityCoordinate.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "coord": {
        "lon": -0.13,
        "lat": 51.51
    }
*/





@interface WAOpenWeatherCityCoordinate : NSObject <WARKModelObjectEntityMapping>

#pragma mark - longitude
@property (nonatomic, readonly, strong, nullable) NSNumber* longitude;

#pragma mark - latitude
@property (nonatomic, readonly, strong, nullable) NSNumber* latitude;

@end





@interface WAOpenWeatherCityCoordinate_PropertiesForKVO : NSObject

#pragma mark - longitude
+(nonnull NSString*)longitude;

#pragma mark - latitude
+(nonnull NSString*)latitude;

@end
