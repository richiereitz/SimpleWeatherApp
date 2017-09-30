//
//  WAOpenWeatherCityCoordinate.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherCityCoordinate.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherCityCoordinate

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"lon"			: [WAOpenWeatherCityCoordinate_PropertiesForKVO longitude],
	    @"lat"			: [WAOpenWeatherCityCoordinate_PropertiesForKVO latitude],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherCityCoordinate_PropertiesForKVO

#pragma mark - longitude
+(nonnull NSString*)longitude{return NSStringFromSelector(_cmd);}

#pragma mark - latitude
+(nonnull NSString*)latitude{return NSStringFromSelector(_cmd);}

@end
