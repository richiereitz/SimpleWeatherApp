//
//  WAOpenWeatherNetworkManager+WAOpenWeatherCityRequests.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherNetworkManager.h"





@interface WAOpenWeatherNetworkManager (WAOpenWeatherCityRequests)

#pragma mark - searchCities
	/**
	 @description Attempts to send a request that returns `WAOpenWeatherCity` instances that match the query.
	 
	 @param query (required) - A string that will be used for the search.
	 @param success (optional) - The block that is called if/when the requests succeeds.
	 @param failure (optional) - The block that is called if/when the requests fails.
	 
	 @return The request operation that was sent, if one was sent, otherwise nil.
	 
	 Resources:
	 http://openweathermap.org/current
	 
	 Example URL:
	 http://api.openweathermap.org/data/2.5/weather?q=London
	 */
-(nullable RKObjectRequestOperation*)searchCities_with_query:(nonnull NSString*)query
													 success:(nullable wa_getOpenWeatherCity_successBlock)success
													 failure:(nullable wa_OpenWeatherNetworkManager_failureBlock)failure;

@end
