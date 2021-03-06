//
//  WAOpenWeatherNetworkManager_Blocks.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#ifndef WAOpenWeatherNetworkManager_Blocks_h
#define WAOpenWeatherNetworkManager_Blocks_h

#import "WABlockConversionSynthesis.h"
#import "WAOpenWeatherCity.h"

#import <Foundation/Foundation.h>

#import <ResplendentRestkit/RRKBlocks.h>





@class RKObjectRequestOperation;





#define wa_OpenWeatherNetworkManager_operationSuccessBlock rrk_rkOperationAndMappingResultBlock

#pragma mark - Error
typedef void(^wa_OpenWeatherNetworkManager_failureBlock) (RKObjectRequestOperation* _Nonnull operation, NSError* _Nonnull error, BOOL handledError);

#pragma mark - Weather Search Results
typedef void(^wa_getOpenWeatherCity_successBlock)(RKObjectRequestOperation* _Nonnull operation, WAOpenWeatherCity* _Nullable openWeatherCity);
wa_rkGeneralOperationSuccessBlock_withObject_convert_to_wa_rkOperationSuccessBlock(wa_getOpenWeatherCity_successBlock, WAOpenWeatherCity)


#endif /* WAOpenWeatherNetworkManager_Blocks_h */
