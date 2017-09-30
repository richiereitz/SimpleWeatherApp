//
//  NSObject+WARKModelObjectEntityMapping.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "NSObject+WARKModelObjectEntityMapping.h"

#import <Restkit/RKObjectMapping.h>





@implementation NSObject (WARKModelObjectEntityMapping)

#pragma mark - general
+(nonnull RKObjectMapping*)wa_createObjectMapping
{
	return [RKObjectMapping mappingForClass:[self class]];
}

@end
