//
//  WAOpenWeatherCityWeather.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherCityWeather.h"

#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherCityWeather

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"id"			: [WAOpenWeatherCityWeather_PropertiesForKVO identifier],
	   @"main"			: [WAOpenWeatherCityWeather_PropertiesForKVO main],
	   @"description"	: [WAOpenWeatherCityWeather_PropertiesForKVO weatherDescription],
	   @"icon"			: [WAOpenWeatherCityWeather_PropertiesForKVO icon],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherCityWeather_PropertiesForKVO : NSObject

#pragma mark - identifier
+(nonnull NSString*)identifier{return NSStringFromSelector(_cmd);}

#pragma mark - main
+(nonnull NSString*)main{return NSStringFromSelector(_cmd);}

#pragma mark - weatherDescription
+(nonnull NSString*)weatherDescription{return NSStringFromSelector(_cmd);}

#pragma mark - icon
+(nonnull NSString*)icon{return NSStringFromSelector(_cmd);}

@end
