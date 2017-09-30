//
//  WAOpenWeatherClouds.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherClouds.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherClouds

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"all"			: [WAOpenWeatherClouds_PropertiesForKVO all],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherClouds_PropertiesForKVO

#pragma mark - all
+(nonnull NSString*)all{return NSStringFromSelector(_cmd);}

@end
