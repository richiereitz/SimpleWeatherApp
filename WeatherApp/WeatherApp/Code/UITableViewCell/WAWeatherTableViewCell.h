//
//  WAWeatherTableViewCell.h
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import <UIKit/UIKit.h>




@class WAOpenWeatherCityWeather;





@interface WAWeatherTableViewCell : UITableViewCell
	
#pragma mark - weather
@property (nonatomic, strong, nullable) WAOpenWeatherCityWeather* weather;

@end
