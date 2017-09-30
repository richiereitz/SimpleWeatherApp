//
//  RKRoute+WAOpenWeatherNetworkManagerRouting.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "RKRoute+WAOpenWeatherNetworkManagerRouting.h"

#import <ResplendentRestkit/RKRoute+RRKRouting.h>

#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/NSArray+RUComponents.h>
#import <ResplendentUtilities/RUConditionalReturn.h>

#import <RestKit/RestKit.h>





@implementation RKRoute (WAOpenWeatherNetworkManagerRouting)

+(nullable instancetype)wa_OpenWeatherRoute_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType
{
	kRUConditionalReturn_ReturnValueNil(RKRoute_WAOpenWeatherRouting__routeType__isInRange(routeType) == false, YES);

	return [self rrk_RouteWithName:[self wa_OpenWeatherRouteName_with_type:routeType]
					   pathPattern:[self wa_OpenWeatherRoutePathPattern_with_type:routeType]
					 requestMethod:[self wa_OpenWeatherRouteRequestMethod_with_type:routeType]
					   objectClass:[self wa_OpenWeatherRouteClass_with_type:routeType]];
}

+(nullable NSArray<NSString*>*)wa_OpenWeatherRoutePathPatternComponents_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType
{
	kRUConditionalReturn_ReturnValueNil(RKRoute_WAOpenWeatherRouting__routeType__isInRange(routeType) == false, YES);

	switch (routeType)
	{
		case RKRoute_WAOpenWeatherRouting__routeType_getCityByName:
			return @[];
			break;
	}

	NSAssert(false, @"unhandled");
	return nil;
}

+(nullable NSString*)wa_OpenWeatherRouteName_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType
{
	kRUConditionalReturn_ReturnValueNil(RKRoute_WAOpenWeatherRouting__routeType__isInRange(routeType) == false, YES);

	return RUStringWithFormat(@"%@_%li",[[self wa_OpenWeatherRoutePathPatternComponents_with_type:routeType]componentsJoinedByString:@"_"],(long)routeType);
}

+(nullable NSString*)wa_OpenWeatherRoutePathPattern_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType
{
	kRUConditionalReturn_ReturnValueNil(RKRoute_WAOpenWeatherRouting__routeType__isInRange(routeType) == false, YES);

	return [[self wa_OpenWeatherRoutePathPatternComponents_with_type:routeType]ru_stringFromPathComponents];
}

+(RKRequestMethod)wa_OpenWeatherRouteRequestMethod_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType
{
	kRUConditionalReturn_ReturnValue(RKRoute_WAOpenWeatherRouting__routeType__isInRange(routeType) == false, YES, RKRequestMethodGET);

	switch (routeType)
	{
		case RKRoute_WAOpenWeatherRouting__routeType_getCityByName:
			return RKRequestMethodGET;
			break;
	}

	NSAssert(false, @"unhandled");
	return RKRequestMethodGET;
}

+(nullable Class)wa_OpenWeatherRouteClass_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType
{
	kRUConditionalReturn_ReturnValueNil(RKRoute_WAOpenWeatherRouting__routeType__isInRange(routeType) == false, YES);

	switch (routeType)
	{
		case RKRoute_WAOpenWeatherRouting__routeType_getCityByName:
			return nil;
			break;
	}

	NSAssert(false, @"unhandled");
	return nil;
}

@end
