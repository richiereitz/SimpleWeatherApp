//
//  WAOpenWeatherNetworkManager.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAOpenWeatherNetworkManager.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/RUSingleton.h>
#import <ResplendentUtilities/NSMutableDictionary+RUUtil.h>
#import <ResplendentUtilities/RUConstants.h>
#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUDLog.h>

#import <ResplendentRestkit/RKObjectManager+RRKAddDescriptorsIfNotAlreadyAdded.h>
#import <ResplendentRestkit/RKObjectManager+RRKRequests.h>
#import <ResplendentRestkit/RKObjectManager+RRKCreateRequestsFromRoutes.h>

#import <RestKit/RKRoute.h>
#import <RestKit/RKResponseDescriptor.h>





@interface WAOpenWeatherNetworkManager ()

#pragma mark - objectManager
-(void)objectManager_setup;
-(nullable NSURL*)objectManager_baseURL;
	
#pragma mark - Completion Helpers
-(void)handleSuccess:(RKObjectRequestOperation*)operation mappingResult:(RKMappingResult*)mappingResult;
-(BOOL)handleFailure:(RKObjectRequestOperation*)operation error:(NSError*)error;
	
#pragma mark - Logging
-(nonnull NSDictionary*)loggingInfoFromOperation:(nonnull RKObjectRequestOperation*)operation;
-(void)logParameters:(nonnull NSDictionary*)parameters;
	
#pragma mark - requestKeyPath
-(nullable NSString*)requestKeyPath_with_suffix:(nonnull NSString*)keyPathSuffix;
-(nullable NSString*)requestKeyPath_defaultResponse;
	
@end





@implementation WAOpenWeatherNetworkManager

#pragma mark - NSObject
-(id)init
{
	if (self = [super init])
	{
		[self objectManager_setup];
		kRUConditionalReturn_ReturnValueNil(self.objectManager == nil, YES);
	}

	return self;
}

#pragma mark - objectManager
-(void)objectManager_setup
{
	NSURL* const urlAddress = [self objectManager_baseURL];
	kRUConditionalReturn(urlAddress == nil, YES);

	_objectManager = [RKObjectManager managerWithBaseURL:urlAddress];
}

-(nullable NSURL*)objectManager_baseURL
{
	return [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather"];
}

#pragma mark - Singleton
RUSingletonUtil_Synthesize_Singleton_Implementation_SharedInstance

#pragma mark - Enque Requests
-(nullable RKObjectRequestOperation*)enqueue_restkitObjectRequestOperation_with_route:(nonnull RKRoute*)route
																			   object:(nullable NSManagedObject*)object
																		objectMapping:(nonnull RKMapping*)objectMapping
																		   parameters:(nullable NSDictionary*)parameters
																	cancelOldRequests:(BOOL)cancelOldRequests
																			  success:(nullable wa_OpenWeatherNetworkManager_operationSuccessBlock)success
																			  failure:(nullable wa_OpenWeatherNetworkManager_failureBlock)failure
{
	kRUConditionalReturn_ReturnValueNil(objectMapping == nil, YES);

	return [self enqueue_restkitObjectRequestOperation_with_route:route
														   object:object
												   objectMappings:@{ [NSNull null] : objectMapping }
													   parameters:parameters
												cancelOldRequests:cancelOldRequests
														  success:success
														  failure:failure];
}

-(nullable RKObjectRequestOperation*)enqueue_restkitObjectRequestOperation_with_route:(nonnull RKRoute*)route
																			   object:(nullable NSManagedObject*)object
																	   objectMappings:(nonnull NSDictionary<id,RKMapping*>*)objectMappings
																		   parameters:(nullable NSDictionary*)parameters
																	cancelOldRequests:(BOOL)cancelOldRequests
																			  success:(nullable wa_OpenWeatherNetworkManager_operationSuccessBlock)success
																			  failure:(nullable wa_OpenWeatherNetworkManager_failureBlock)failure
{
	kRUConditionalReturn_ReturnValueNil(route == nil, YES);

	[self logParameters:parameters];

	//Object Manager
	RKObjectManager* const objectManager = self.objectManager;

	//Response Descriptor
	[objectMappings enumerateKeysAndObjectsUsingBlock:^(id keyPathOrNull, RKMapping* objectMapping, BOOL *stop) {

		NSString* const finalKeyPath = [self requestKeyPath_with_suffix:keyPathOrNull];

		[objectManager rrk_addResponseDescriptorIfDoesNotAlreadyExist:[RKResponseDescriptor responseDescriptorWithMapping:objectMapping
																												   method:route.method
																											  pathPattern:route.pathPattern
																												  keyPath:finalKeyPath
																											  statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];

	}];

	__weak typeof(self) const self_weak = self;
	return
	[objectManager rrk_enqueueRestkitManagedObjectRequestOperationForRoute:route
																	object:object
																parameters:parameters
														 cancelOldRequests:cancelOldRequests
													  managedObjectContext:nil
																   success:
	 ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

		 [self_weak handleSuccess:operation mappingResult:mappingResult];

		 if (success)
		 {
			 success(operation,mappingResult);
		 }

	 } failure:^(RKObjectRequestOperation *operation, NSError *error) {

		 BOOL handled = [self_weak handleFailure:operation error:error];

		 if (failure)
		 {
			 failure(operation,error,handled);
		 }

	 }];
}

#pragma mark - Completion Helpers
-(void)handleSuccess:(RKObjectRequestOperation*)operation mappingResult:(RKMappingResult*)mappingResult
{
	RUDLog(@"loggingInfoFromOperation: %@",[self loggingInfoFromOperation:operation]);

	RUDLog(@"mappingResult: %@",mappingResult);
}

-(BOOL)handleFailure:(RKObjectRequestOperation*)operation error:(NSError*)error
{
	RUDLog(@"loggingInfoFromOperation: %@",[self loggingInfoFromOperation:operation]);

	RUDLog(@"error: %@",error);

	kRUConditionalReturn_ReturnValueFalse(operation.isCancelled, NO);

	BOOL handled = false;

	return handled;
}

#pragma mark - Logging
-(nonnull NSDictionary*)loggingInfoFromOperation:(nonnull RKObjectRequestOperation*)operation
{
	kRUConditionalReturn_ReturnValueNil(operation == nil, YES);

	NSMutableDictionary* loggingInfo = [NSMutableDictionary dictionary];
	[loggingInfo setObjectOrRemoveIfNil:operation.description
								 forKey:@"operation"];
	[loggingInfo setObjectOrRemoveIfNil:operation.HTTPRequestOperation.description
								 forKey:@"operation.HTTPRequestOperation"];
	[loggingInfo setObjectOrRemoveIfNil:operation.HTTPRequestOperation.request.allHTTPHeaderFields.description
								 forKey:@"operation.HTTPRequestOperation.request.allHTTPHeaderFields"];
	[loggingInfo setObjectOrRemoveIfNil:operation.HTTPRequestOperation.responseString.description
								 forKey:@"operation.HTTPRequestOperation.responseString"];

	return [loggingInfo copy];
}

-(void)logParameters:(nonnull NSDictionary*)parameters;
{
	RUDLog(@"params: %@",parameters);
}

#pragma mark - requestKeyPath
-(nullable NSString*)requestKeyPath_with_suffix:(nonnull NSString*)keyPathSuffix
{
	NSMutableString* const finalKeyPath = [NSMutableString string];

	NSString* const keyPath_defaultResponse = [self requestKeyPath_defaultResponse];
	if (keyPath_defaultResponse.length)
	{
		[finalKeyPath appendString:keyPath_defaultResponse];
	}

	if (kRUStringOrNil(keyPathSuffix))
	{
		if (finalKeyPath.length)
		{
			[finalKeyPath appendString:@"."];
		}

		[finalKeyPath appendString:keyPathSuffix];
	}
	else
	{
		NSAssert(kRUClassOrNil(keyPathSuffix, NSNull) != nil, @"if not a string, should be null.");
	}

	return finalKeyPath;
}

-(nullable NSString*)requestKeyPath_defaultResponse
{
	return nil;
}

@end
