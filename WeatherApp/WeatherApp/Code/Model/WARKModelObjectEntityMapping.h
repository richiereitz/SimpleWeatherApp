//
//  WARKModelObjectEntityMapping.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import <Foundation/Foundation.h>





@class RKObjectMapping;





@protocol WARKModelObjectEntityMapping <NSObject>

+(nonnull RKObjectMapping*)entityMapping;

@end
