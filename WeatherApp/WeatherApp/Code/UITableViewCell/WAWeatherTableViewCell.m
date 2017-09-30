//
//  WAWeatherTableViewCell.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAWeatherTableViewCell.h"
#import "WAOpenWeatherCityWeather.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>

#import <RUTextSize/UILabel+RUTextSize.h>

#import <SDWebImage/UIImageView+WebCache.h>





static void* kWAWeatherTableViewCell_KVOContext = &kWAWeatherTableViewCell_KVOContext;





@interface WAWeatherTableViewCell ()
	
#pragma mark - iconImageView
@property (nonatomic, readonly, strong, nullable) UIImageView* iconImageView;
-(CGRect)iconImageView_frame;
-(void)iconImageView_image_update;
-(nullable NSString*)iconImageView_urlString_appropriate;
	
#pragma mark - mainLabel
@property (nonatomic, readonly, strong, nullable) UILabel* mainLabel;
-(CGRect)mainLabel_frame;
-(void)mainLabel_text_update;
	
#pragma mark - descriptionLabel
@property (nonatomic, readonly, strong, nullable) UILabel* descriptionLabel;
-(CGRect)descriptionLabel_frame;
-(void)descriptionLabel_text_update;
	
	
#pragma mark - weather
-(void)weather_setKVORegistered:(BOOL)registered;

@end





@implementation WAWeatherTableViewCell
	
#pragma mark - dealloc
-(void)dealloc
{
	[self weather_setKVORegistered:NO];
}

#pragma mark - UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		_iconImageView = [UIImageView new];
		[self.iconImageView setBackgroundColor:[UIColor clearColor]];
		[self.contentView addSubview:self.iconImageView];
		
		_mainLabel = [UILabel new];
		[self.mainLabel setBackgroundColor:[UIColor whiteColor]];
		[self.contentView addSubview:self.mainLabel];
		
		_descriptionLabel = [UILabel new];
		[self.descriptionLabel setBackgroundColor:[UIColor whiteColor]];
		[self.contentView addSubview:self.descriptionLabel];
	}
	
	return self;
}
	
#pragma mark - UIView
-(void)layoutSubviews
	{
		[super layoutSubviews];
		
		[self.iconImageView setFrame:[self iconImageView_frame]];
		[self.mainLabel setFrame:[self mainLabel_frame]];
		[self.descriptionLabel setFrame:[self descriptionLabel_frame]];
	}
	
#pragma mark - weather
-(void)setWeather:(nullable WAOpenWeatherCityWeather*)weather
{
	kRUConditionalReturn(self.weather == weather, NO);
	
	[self weather_setKVORegistered:NO];
	
	_weather = weather;
	
	[self weather_setKVORegistered:YES];
}
	
-(void)weather_setKVORegistered:(BOOL)registered
{
	typeof(self.weather) const weather = self.weather;
	kRUConditionalReturn(weather == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[WAOpenWeatherCityWeather_PropertiesForKVO main]];
	[propertiesToObserve addObject:[WAOpenWeatherCityWeather_PropertiesForKVO weatherDescription]];
	[propertiesToObserve addObject:[WAOpenWeatherCityWeather_PropertiesForKVO icon]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[weather addObserver:self
							  forKeyPath:propertyToObserve
								 options:NSKeyValueObservingOptionInitial
								 context:&kWAWeatherTableViewCell_KVOContext];
		}
		else
		{
			[weather removeObserver:self
								 forKeyPath:propertyToObserve
									context:&kWAWeatherTableViewCell_KVOContext];
		}
	}];
}
	
#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id>*)change context:(nullable void*)context
	{
		if (context == kWAWeatherTableViewCell_KVOContext)
		{
			if (object == self.weather)
			{
				if ([keyPath isEqualToString:[WAOpenWeatherCityWeather_PropertiesForKVO weatherDescription]])
				{
					[self descriptionLabel_text_update];
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCityWeather_PropertiesForKVO main]])
				{
					[self mainLabel_text_update];
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCityWeather_PropertiesForKVO icon]])
				{
					[self iconImageView_image_update];
				}
				else
				{
					NSAssert(false, @"unhandled keyPath %@",keyPath);
				}
			}
			else
			{
				NSAssert(false, @"unhandled object %@",object);
			}
		}
		else
		{
			[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
		}
	}
	
#pragma mark - iconImageView
-(CGRect)iconImageView_frame
	{
		//Would like to make this size more exact had I more time
		CGFloat const dimension = 50.0f;
		
		return CGRectCeilOrigin((CGRect){
			.origin.y		= 10.0f,
			.size.width		= dimension,
			.size.height	= dimension,
		});
	}
	
-(void)iconImageView_image_update
	{
		[self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[self iconImageView_urlString_appropriate]]];
		[self setNeedsLayout];
	}
	
-(nullable NSString*)iconImageView_urlString_appropriate
	{
		WAOpenWeatherCityWeather* const weather = self.weather;
		kRUConditionalReturn_ReturnValueNil(weather == nil, NO);
		
		NSString* const iconString = weather.icon;
		kRUConditionalReturn_ReturnValueNil(iconString == nil || iconString.length < 1, NO);
		
		return RUStringWithFormat(@"https://openweathermap.org/img/w/%@.png", iconString);
	}
	
#pragma mark - mainLabel
-(CGRect)mainLabel_frame
	{
		CGSize const size = [self.mainLabel ruTextSize];
		
		return CGRectCeilOrigin((CGRect){
			.origin.x		= CGRectGetMaxX([self iconImageView_frame]) + 5.0f,
			.origin.y		= 10.0f,
			.size		= size
		});
	}
	
-(void)mainLabel_text_update
	{
		[self.mainLabel setText:self.weather.main];
		[self setNeedsLayout];
	}
	
#pragma mark - descriptionLabel
-(CGRect)descriptionLabel_frame
	{
		CGSize const size = [self.descriptionLabel ruTextSize];
		
		return CGRectCeilOrigin((CGRect){
			.origin.x		= CGRectGetMinX([self mainLabel_frame]),
			.origin.y		= CGRectGetMaxY([self mainLabel_frame]) + 5.0f,
			.size		= size
		});
	}
-(void)descriptionLabel_text_update
	{
		[self.descriptionLabel setText:self.weather.weatherDescription];
		[self setNeedsLayout];
	}

@end
