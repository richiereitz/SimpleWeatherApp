//
//  WABlockConversionSynthesis.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#ifndef WABlockConversionSynthesis_h
#define WABlockConversionSynthesis_h

#import <Foundation/Foundation.h>

#import <ResplendentUtilities/RUClassOrNilUtil.h>
#import <ResplendentUtilities/RUConditionalReturn.h>

#import <ResplendentRestkit/RRKBlocks.h>

#import <RestKit/RKMappingResult.h>





@class RKMapperOperation;
@class RKMappingResult;




#pragma mark - Success
#define wa_rkOperationSuccessBlock rrk_rkOperationAndMappingResultBlock

#pragma mark - Error
typedef void(^wa_rkOperationAndErrorAndHandledErrorBlock) (RKObjectRequestOperation* _Nonnull operation, NSError* _Nonnull error, BOOL handledError);

#define wa_rkGeneralOperationSuccessBlock_withObject_convert_to_wa_rkOperationSuccessBlock(blockType, objectClass) \
static inline _Nullable wa_rkOperationSuccessBlock wa_rkGeneralOperationSuccessBlock_with_##objectClass##_block_to_generalSuccessBlock(blockType _Nullable generalOperationSuccessBlock){ \
	kRUConditionalReturn_ReturnValueNil(generalOperationSuccessBlock == nil, NO); \
 \
	return ^(RKObjectRequestOperation* _Nonnull operation, RKMappingResult* _Nonnull mappingResult){ \
		if (generalOperationSuccessBlock) \
		{ \
			id const firstObject = mappingResult.firstObject; \
			objectClass* const firstObject_ofObjectClass = kRUClassOrNil(firstObject, objectClass); \
			NSCAssert((firstObject == nil) == \
					  (firstObject_ofObjectClass == nil), @"firstObject %@ should have been a string",firstObject); \
			generalOperationSuccessBlock(operation,firstObject_ofObjectClass); \
		} \
	}; \
} \

#define wa_rkGeneralOperationSuccessBlock_withObjects_convert_to_wa_rkOperationSuccessBlock(blockType, objectClass) \
static inline _Nullable wa_rkOperationSuccessBlock wa_rkGeneralOperationSuccessBlock_with_##objectClass##Array_block_to_generalSuccessBlock(blockType _Nullable generalOperationSuccessBlock){ \
	kRUConditionalReturn_ReturnValueNil(generalOperationSuccessBlock == nil, NO); \
 \
	return ^(RKObjectRequestOperation* _Nonnull operation, RKMappingResult* _Nonnull mappingResult){ \
		if (generalOperationSuccessBlock) \
		{ \
			generalOperationSuccessBlock(operation, mappingResult.array); \
		} \
	}; \
} \





#endif /* WABlockConversionSynthesis_h */
