//
//  WALeftoverInformationTableViewCell.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import <UIKit/UIKit.h>





@class WAOpenWeatherClouds;
@class WAOpenWeatherRain;
@class WAOpenWeatherCityWind;





@interface WALeftoverInformationTableViewCell : UITableViewCell
	
#pragma mark - clouds
@property (nonatomic, strong, nullable) WAOpenWeatherClouds* clouds;
	
#pragma mark - rain
@property (nonatomic, strong, nullable) WAOpenWeatherRain* rain;

#pragma mark - wind
@property (nonatomic, strong, nullable) WAOpenWeatherCityWind* wind;

@end
