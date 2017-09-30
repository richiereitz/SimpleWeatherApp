//
//  RKRoute+WAOpenWeatherNetworkManagerRouting.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import <RestKit/RestKit.h>

#import <ResplendentUtilities/RUEnumIsInRangeSynthesization.h>





typedef NS_ENUM(NSInteger, RKRoute_WAOpenWeatherRouting__routeType) {
	
	RKRoute_WAOpenWeatherRouting__routeType_getCityByName,

	RKRoute_WAOpenWeatherRouting__routeType__first	= RKRoute_WAOpenWeatherRouting__routeType_getCityByName,
	RKRoute_WAOpenWeatherRouting__routeType__last	= RKRoute_WAOpenWeatherRouting__routeType_getCityByName,
};

static inline RUEnumIsInRangeSynthesization_autoFirstLast(RKRoute_WAOpenWeatherRouting__routeType);





@interface RKRoute (WAOpenWeatherNetworkManagerRouting)

+(nullable instancetype)wa_OpenWeatherRoute_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType;
+(nullable NSArray<NSString*>*)wa_OpenWeatherRoutePathPatternComponents_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType;
+(nullable NSString*)wa_OpenWeatherRouteName_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType;
+(nullable NSString*)wa_OpenWeatherRoutePathPattern_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType;
+(RKRequestMethod)wa_OpenWeatherRouteRequestMethod_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType;
+(nullable Class)wa_OpenWeatherRouteClass_with_type:(RKRoute_WAOpenWeatherRouting__routeType)routeType;

@end
