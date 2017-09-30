//
//  WAOpenWeatherCityWind.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherCityWind.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherCityWind

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"speed"			: [WAOpenWeatherCityWind_PropertiesForKVO speed],
	   @"deg"		: [WAOpenWeatherCityWind_PropertiesForKVO deg],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherCityWind_PropertiesForKVO : NSObject

#pragma mark - speed
+(nullable NSString*)speed{return NSStringFromSelector(_cmd);}

#pragma mark - deg
+(nullable NSString*)deg{return NSStringFromSelector(_cmd);}

@end
