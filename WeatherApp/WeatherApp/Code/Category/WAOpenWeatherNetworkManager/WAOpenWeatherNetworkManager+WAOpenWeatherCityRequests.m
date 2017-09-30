//
//  WAOpenWeatherNetworkManager+WAOpenWeatherCityRequests.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherNetworkManager+WAOpenWeatherCityRequests.h"
#import "RKRoute+WAOpenWeatherNetworkManagerRouting.h"
#import "WAOpenWeatherCity.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/NSMutableDictionary+RUUtil.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>





@implementation WAOpenWeatherNetworkManager (WAOpenWeatherCityRequests)
	
#pragma mark - searchCities
-(nullable RKObjectRequestOperation*)searchCities_with_query:(nonnull NSString*)query
													 success:(nullable wa_getOpenWeatherCity_successBlock)success
													 failure:(nullable wa_OpenWeatherNetworkManager_failureBlock)failure
{
	kRUConditionalReturn_ReturnValueNil(query == nil, YES);
	
	RKRoute* const route = [RKRoute wa_OpenWeatherRoute_with_type:RKRoute_WAOpenWeatherRouting__routeType_getCityByName];
	
	RKObjectMapping* const entityMapping_city = [WAOpenWeatherCity entityMapping];
	
	NSMutableDictionary<NSString*,NSString*>* const parameters = [NSMutableDictionary<NSString*,NSString*> dictionary];

	[parameters setObjectOrRemoveIfNil:query forKey:@"q"];
	[parameters setObjectOrRemoveIfNil:@"imperial" forKey:@"units"];
	NSString* const api_key = @"371a93852469ab86c77781b87872bbe4";
	[parameters setObjectOrRemoveIfNil:api_key forKey:@"APPID"];
	
	return [self enqueue_restkitObjectRequestOperation_with_route:route
														   object:nil
												   objectMapping:entityMapping_city
													   parameters:[NSDictionary dictionaryWithDictionary:parameters]
												cancelOldRequests:YES
														  success:wa_rkGeneralOperationSuccessBlock_with_WAOpenWeatherCity_block_to_generalSuccessBlock(success)
														  failure:failure];
}

@end
