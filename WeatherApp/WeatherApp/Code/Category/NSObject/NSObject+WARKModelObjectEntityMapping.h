//
//  NSObject+WARKModelObjectEntityMapping.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import <Foundation/Foundation.h>





@class RKObjectMapping;





@interface NSObject (WARKModelObjectEntityMapping)

#pragma mark - createEntityMapping
+(nonnull RKObjectMapping*)wa_createObjectMapping;

@end
