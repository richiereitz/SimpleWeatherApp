//
//  WAOpenWeatherRain.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherRain.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherRain

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"3h"			: [WAOpenWeatherRain_PropertiesForKVO degreeOfRain],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherRain_PropertiesForKVO

#pragma mark - degreeOfRain
+(nonnull NSString*)degreeOfRain{return NSStringFromSelector(_cmd);}

@end
