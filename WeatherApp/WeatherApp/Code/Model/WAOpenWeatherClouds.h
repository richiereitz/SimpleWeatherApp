//
//  WAOpenWeatherClouds.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WARKModelObjectEntityMapping.h"

#import <Foundation/Foundation.h>

/*
    "clouds": {
        "all": 80
    }
*/





@interface WAOpenWeatherClouds : NSObject <WARKModelObjectEntityMapping>

#pragma mark - all
@property (nonatomic, readonly, strong, nullable) NSNumber* all;

@end





@interface WAOpenWeatherClouds_PropertiesForKVO : NSObject

#pragma mark - all
+(nonnull NSString*)all;

@end
