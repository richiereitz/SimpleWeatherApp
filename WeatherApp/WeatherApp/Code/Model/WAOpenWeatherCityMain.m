//
//  WAOpenWeatherCityMain.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherCityMain.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherCityMain

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"temp"			: [WAOpenWeatherCityMain_PropertiesForKVO temp],
	   @"pressure"		: [WAOpenWeatherCityMain_PropertiesForKVO pressure],
	   @"humidity"		: [WAOpenWeatherCityMain_PropertiesForKVO humidity],
	   @"temp_min"		: [WAOpenWeatherCityMain_PropertiesForKVO minimumTemp],
	   @"temp_max"		: [WAOpenWeatherCityMain_PropertiesForKVO maximumTemp],
	   @"sea_level"		: [WAOpenWeatherCityMain_PropertiesForKVO seaLevel],
	   @"grnd_level"	: [WAOpenWeatherCityMain_PropertiesForKVO groundLevel],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherCityMain_PropertiesForKVO

#pragma mark - temp
+(nonnull NSString*)temp{return NSStringFromSelector(_cmd);}

#pragma mark - pressure
+(nonnull NSString*)pressure{return NSStringFromSelector(_cmd);}

#pragma mark - humidity
+(nonnull NSString*)humidity{return NSStringFromSelector(_cmd);}

#pragma mark - minimumTemp
+(nonnull NSString*)minimumTemp{return NSStringFromSelector(_cmd);}

#pragma mark - maximumTemp
+(nonnull NSString*)maximumTemp{return NSStringFromSelector(_cmd);}

#pragma mark - seaLevel
+(nonnull NSString*)seaLevel{return NSStringFromSelector(_cmd);}

#pragma mark - groundLevel
+(nonnull NSString*)groundLevel{return NSStringFromSelector(_cmd);}

@end
