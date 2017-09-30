//
//  WAOpenWeatherCity.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherCity.h"
#import "NSObject+WARKModelObjectEntityMapping.h"
#import "WAOpenWeatherRain.h"
#import "WAOpenWeatherClouds.h"
#import "WAOpenWeatherCitySys.h"
#import "WAOpenWeatherCityMain.h"
#import "WAOpenWeatherCityWind.h"
#import "WAOpenWeatherCityWeather.h"
#import "WAOpenWeatherCityCoordinate.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>
#import <RestKit/RKRelationshipMapping.h>





@implementation WAOpenWeatherCity

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"base"			: [WAOpenWeatherCity_PropertiesForKVO base],
	   @"dt"			: [WAOpenWeatherCity_PropertiesForKVO dt],
	   @"id"			: [WAOpenWeatherCity_PropertiesForKVO identifier],
	   @"name"			: [WAOpenWeatherCity_PropertiesForKVO name],
	   @"cod"			: [WAOpenWeatherCity_PropertiesForKVO cod],
	   }];
	
	RKObjectMapping* const entityMapping_coordinate = [WAOpenWeatherCityCoordinate entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"coord"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO coordinate]
																				withMapping:entityMapping_coordinate]];

	RKObjectMapping* const entityMapping_weather = [WAOpenWeatherCityWeather entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO weather]
																				withMapping:entityMapping_weather]];
	
	RKObjectMapping* const entityMapping_main = [WAOpenWeatherCityMain entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"main"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO main]
																				withMapping:entityMapping_main]];
	
	RKObjectMapping* const entityMapping_wind = [WAOpenWeatherCityWind entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wind"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO wind]
																				withMapping:entityMapping_wind]];
	
	RKObjectMapping* const entityMapping_rain = [WAOpenWeatherRain entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rain"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO rain]
																				withMapping:entityMapping_rain]];
	
	RKObjectMapping* const entityMapping_clouds = [WAOpenWeatherClouds entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"clouds"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO clouds]
																				withMapping:entityMapping_clouds]];
	
	RKObjectMapping* const entityMapping_sys = [WAOpenWeatherCitySys entityMapping];
	[entityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"sys"
																				  toKeyPath:[WAOpenWeatherCity_PropertiesForKVO sys]
																				withMapping:entityMapping_sys]];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherCity_PropertiesForKVO

#pragma mark - coordinate
+(nonnull NSString*)coordinate{return NSStringFromSelector(_cmd);}

#pragma mark - weather
+(nonnull NSString*)weather{return NSStringFromSelector(_cmd);}

#pragma mark - base
+(nonnull NSString*)base{return NSStringFromSelector(_cmd);}

#pragma mark - main
+(nonnull NSString*)main{return NSStringFromSelector(_cmd);}

#pragma mark - wind
+(nonnull NSString*)wind{return NSStringFromSelector(_cmd);}

#pragma mark - rain
+(nonnull NSString*)rain{return NSStringFromSelector(_cmd);}

#pragma mark - clouds
+(nonnull NSString*)clouds{return NSStringFromSelector(_cmd);}

#pragma mark - dt
+(nonnull NSString*)dt{return NSStringFromSelector(_cmd);}

#pragma mark - sys
+(nonnull NSString*)sys{return NSStringFromSelector(_cmd);}

#pragma mark - identifier
+(nonnull NSString*)identifier{return NSStringFromSelector(_cmd);}

#pragma mark - name
+(nonnull NSString*)name{return NSStringFromSelector(_cmd);}

#pragma mark - cod
+(nonnull NSString*)cod{return NSStringFromSelector(_cmd);}

@end
