//
//  WAMainTableViewCell.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAMainTableViewCell.h"
#import "WAOpenWeatherCityMain.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>

#import <RUTextSize/UILabel+RUTextSize.h>





static void* kWAMainTableViewCell_KVOContext = &kWAMainTableViewCell_KVOContext;





@interface WAMainTableViewCell ()
	
#pragma mark - main
-(void)main_setKVORegistered:(BOOL)registered;
	
#pragma mark - temperatureLabel
@property (nonatomic, readonly, strong, nullable) UILabel* temperatureLabel;
-(CGRect)temperatureLabel_frame;
-(void)temperatureLabel_text_update;

#pragma mark - pressureLabel
@property (nonatomic, readonly, strong, nullable) UILabel* pressureLabel;
-(CGRect)pressureLabel_frame;
-(void)pressureLabel_text_update;
	
#pragma mark - humidityLabel
@property (nonatomic, readonly, strong, nullable) UILabel* humidityLabel;
-(CGRect)humidityLabel_frame;
-(void)humidityLabel_text_update;
	
#pragma mark - minimumTemperatureLabel
@property (nonatomic, readonly, strong, nullable) UILabel* minimumTemperatureLabel;
-(CGRect)minimumTemperatureLabel_frame;
-(void)minimumTemperatureLabel_text_update;
	
#pragma mark - maximumTemperatureLabel
@property (nonatomic, readonly, strong, nullable) UILabel* maximumTemperatureLabel;
-(CGRect)maximumTemperatureLabel_frame;
-(void)maximumTemperatureLabel_text_update;
	
@end





@implementation WAMainTableViewCell

#pragma mark - dealloc
-(void)dealloc
	{
		[self main_setKVORegistered:NO];
	}
	
#pragma mark - UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
	{
		if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
		{
			_temperatureLabel = [UILabel new];
			[self.temperatureLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.temperatureLabel];
			
			_pressureLabel = [UILabel new];
			[self.pressureLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.pressureLabel];
			
			_humidityLabel = [UILabel new];
			[self.humidityLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.humidityLabel];
			
			_minimumTemperatureLabel = [UILabel new];
			[self.minimumTemperatureLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.minimumTemperatureLabel];
			
			_maximumTemperatureLabel = [UILabel new];
			[self.maximumTemperatureLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.maximumTemperatureLabel];
		}
		
		return self;
	}
	
#pragma mark - UIView
-(void)layoutSubviews
	{
		[super layoutSubviews];

		[self.temperatureLabel setFrame:[self temperatureLabel_frame]];
		[self.pressureLabel setFrame:[self pressureLabel_frame]];
		[self.humidityLabel setFrame:[self humidityLabel_frame]];
		[self.minimumTemperatureLabel setFrame:[self minimumTemperatureLabel_frame]];
		[self.maximumTemperatureLabel setFrame:[self maximumTemperatureLabel_frame]];
	}
	
#pragma mark - temperatureLabel
-(CGRect)temperatureLabel_frame
	{
		CGSize const size = [self.temperatureLabel ruTextSize];
		return CGRectCeilOrigin((CGRect){
			.size	= size
		});
	}
	
-(void)temperatureLabel_text_update
	{
		[self.temperatureLabel setText:RUStringWithFormat(@"Temperature: %@ degrees", self.main.temp.stringValue)];
		[self setNeedsLayout];
	}
	
#pragma mark - pressureLabel
-(CGRect)pressureLabel_frame
	{
		CGSize const size = [self.pressureLabel ruTextSize];
		return CGRectCeilOrigin((CGRect){
			.origin.y	= CGRectGetMaxY([self temperatureLabel_frame]) +15.0f,
			.size		= size
		});
	}
-(void)pressureLabel_text_update
	{
		[self.pressureLabel setText:RUStringWithFormat(@"Pressure: %@", self.main.pressure.stringValue)];
		[self setNeedsLayout];
	}
	
#pragma mark - humidityLabel
-(CGRect)humidityLabel_frame
	{
		CGSize const size = [self.humidityLabel ruTextSize];
		return CGRectCeilOrigin((CGRect){
			.origin.y	= CGRectGetMaxY([self pressureLabel_frame]) +15.0f,
			.size		= size
		});
		
	}
-(void)humidityLabel_text_update
	{
		[self.humidityLabel setText:RUStringWithFormat(@"Humidity: %@", self.main.humidity.stringValue)];
		[self setNeedsLayout];
	}
	
#pragma mark - minimumTemperatureLabel
-(CGRect)minimumTemperatureLabel_frame
	{
		CGSize const size = [self.minimumTemperatureLabel ruTextSize];
		return CGRectCeilOrigin((CGRect){
			.origin.y	= CGRectGetMaxY([self humidityLabel_frame]) +15.0f,
			.size		= size
		});
	}
-(void)minimumTemperatureLabel_text_update
	{
		[self.minimumTemperatureLabel setText:RUStringWithFormat(@"Low: %@ degrees", self.main.minimumTemp.stringValue)];
		[self setNeedsLayout];
	}
	
#pragma mark - maximumTemperatureLabel
-(CGRect)maximumTemperatureLabel_frame
	{
		CGSize const size = [self.maximumTemperatureLabel ruTextSize];
		return CGRectCeilOrigin((CGRect){
			.origin.y	= CGRectGetMaxY([self minimumTemperatureLabel_frame]) +15.0f,
			.size		= size
		});
	}
-(void)maximumTemperatureLabel_text_update
	{
		[self.maximumTemperatureLabel setText:RUStringWithFormat(@"High: %@ degrees", self.main.maximumTemp.stringValue)];
		[self setNeedsLayout];
	}

#pragma mark - weather
-(void)setMain:(nullable WAOpenWeatherCityMain*)main
	{
		kRUConditionalReturn(self.main == main, NO);
		
		[self main_setKVORegistered:NO];
		
		_main = main;
		
		[self main_setKVORegistered:YES];
	}
	
-(void)main_setKVORegistered:(BOOL)registered
	{
		typeof(self.main) const main = self.main;
		kRUConditionalReturn(main == nil, NO);
		
		NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
		[propertiesToObserve addObject:[WAOpenWeatherCityMain_PropertiesForKVO temp]];
		[propertiesToObserve addObject:[WAOpenWeatherCityMain_PropertiesForKVO pressure]];
		[propertiesToObserve addObject:[WAOpenWeatherCityMain_PropertiesForKVO humidity]];
		[propertiesToObserve addObject:[WAOpenWeatherCityMain_PropertiesForKVO maximumTemp]];
		[propertiesToObserve addObject:[WAOpenWeatherCityMain_PropertiesForKVO minimumTemp]];
		
		[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
			if (registered)
			{
				[main addObserver:self
						  forKeyPath:propertyToObserve
							 options:NSKeyValueObservingOptionInitial
							 context:&kWAMainTableViewCell_KVOContext];
			}
			else
			{
				[main removeObserver:self
							 forKeyPath:propertyToObserve
								context:&kWAMainTableViewCell_KVOContext];
			}
		}];
	}
	
#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id>*)change context:(nullable void*)context
	{
		if (context == kWAMainTableViewCell_KVOContext)
		{
			if (object == self.main)
			{
				if ([keyPath isEqualToString:[WAOpenWeatherCityMain_PropertiesForKVO temp]])
				{
					[self temperatureLabel_text_update];
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCityMain_PropertiesForKVO pressure]])
				{
					[self pressureLabel_text_update];
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCityMain_PropertiesForKVO humidity]])
				{
					[self humidityLabel_text_update];
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCityMain_PropertiesForKVO minimumTemp]])
				{
					[self minimumTemperatureLabel_text_update];
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCityMain_PropertiesForKVO maximumTemp]])
				{
					[self maximumTemperatureLabel_text_update];
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

@end
