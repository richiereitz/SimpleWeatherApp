//
//  WAOpenWeatherNetworkManager.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherNetworkManager_Blocks.h"

#import <Foundation/Foundation.h>



@class RKObjectManager;
@class RKRoute;
@class NSManagedObject;
@class RKMapping;





@interface WAOpenWeatherNetworkManager : NSObject
	
#pragma mark - objectManager
@property (nonatomic, readonly, nullable) RKObjectManager* objectManager;
	
#pragma mark - singleton
+(nonnull instancetype)sharedInstance;
	
#pragma mark - Enque Requests
-(nullable RKObjectRequestOperation*)enqueue_restkitObjectRequestOperation_with_route:(nonnull RKRoute*)route
																			   object:(nullable NSManagedObject*)object
																		objectMapping:(nonnull RKMapping*)objectMapping
																		   parameters:(nullable NSDictionary*)parameters
																	cancelOldRequests:(BOOL)cancelOldRequests
																			  success:(nullable wa_OpenWeatherNetworkManager_operationSuccessBlock)success
																			  failure:(nullable wa_OpenWeatherNetworkManager_failureBlock)failure;
	
																			  -(nullable RKObjectRequestOperation*)enqueue_restkitObjectRequestOperation_with_route:(nonnull RKRoute*)route
																			   object:(nullable NSManagedObject*)object
																	   objectMappings:(nonnull NSDictionary<id,RKMapping*>*)objectMappings
																		   parameters:(nullable NSDictionary*)parameters
																	cancelOldRequests:(BOOL)cancelOldRequests
																			  success:(nullable wa_OpenWeatherNetworkManager_operationSuccessBlock)success
																			  failure:(nullable wa_OpenWeatherNetworkManager_failureBlock)failure;

@end
