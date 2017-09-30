//
//  WAOpenWeatherCitySys.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherCitySys.h"
#import "NSObject+WARKModelObjectEntityMapping.h"

#import <RestKit/RKObjectMapping.h>





@implementation WAOpenWeatherCitySys

#pragma mark - WARKModelObjectEntityMapping
+(nonnull RKObjectMapping*)entityMapping
{
	RKObjectMapping* const entityMapping = [self wa_createObjectMapping];
	
	[entityMapping addAttributeMappingsFromDictionary:
	 @{
	   @"message"		: [WAOpenWeatherCitySys_PropertiesForKVO message],
	   @"country"		: [WAOpenWeatherCitySys_PropertiesForKVO country],
	   @"sunrise"		: [WAOpenWeatherCitySys_PropertiesForKVO sunrise],
	   @"sunset"		: [WAOpenWeatherCitySys_PropertiesForKVO sunset],
	   }];
	
	return entityMapping;
}

@end





@implementation WAOpenWeatherCitySys_PropertiesForKVO

#pragma mark - message
+(nonnull NSString*)message{return NSStringFromSelector(_cmd);}

#pragma mark - country
+(nonnull NSString*)country{return NSStringFromSelector(_cmd);}

#pragma mark - sunrise
+(nonnull NSString*)sunrise{return NSStringFromSelector(_cmd);}

#pragma mark - sunset
+(nonnull NSString*)sunset{return NSStringFromSelector(_cmd);}

@end
