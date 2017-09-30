//
//  WALeftoverInformationTableViewCell.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WALeftoverInformationTableViewCell.h"
#import "WAOpenWeatherCityWind.h"
#import "WAOpenWeatherRain.h"
#import "WAOpenWeatherClouds.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/RUConstants.h>

#import <RUTextSize/UILabel+RUTextSize.h>





@interface WALeftoverInformationTableViewCell ()
	
#pragma mark - windLabel
@property (nonatomic, readonly, strong, nullable) UILabel* windLabel;
-(CGRect)windLabel_frame;
-(void)windLabel_text_update;
	
#pragma mark - rainLabel
@property (nonatomic, readonly, strong, nullable) UILabel* rainLabel;
-(CGRect)rainLabel_frame;
-(void)rainLabel_text_update;

#pragma mark - cloudsLabel
@property (nonatomic, readonly, strong, nullable) UILabel* cloudsLabel;
-(CGRect)cloudsLabel_frame;
-(void)cloudsLabel_text_update;
	
@end





@implementation WALeftoverInformationTableViewCell

#pragma mark - UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
	{
		if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
		{
			_windLabel = [UILabel new];
			[self.windLabel setBackgroundColor:[UIColor whiteColor]];
			[self.windLabel setNumberOfLines:0];
			[self.contentView addSubview:self.windLabel];
			
			_rainLabel = [UILabel new];
			[self.rainLabel setNumberOfLines:0];
			[self.rainLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.rainLabel];
			
			_cloudsLabel = [UILabel new];
			[self.cloudsLabel setNumberOfLines:0];
			[self.cloudsLabel setBackgroundColor:[UIColor whiteColor]];
			[self.contentView addSubview:self.cloudsLabel];
		}
		
		return self;
	}
	
#pragma mark - UIView
-(void)layoutSubviews
	{
		[super layoutSubviews];
		
		[self.windLabel setFrame:[self windLabel_frame]];
		[self.rainLabel setFrame:[self rainLabel_frame]];
		[self.cloudsLabel setFrame:[self cloudsLabel_frame]];
	}
#pragma mark - clouds
-(void)setClouds:(nullable WAOpenWeatherClouds *)clouds
	{
		kRUConditionalReturn(self.clouds == clouds, NO);
		
		_clouds = clouds;
		
		//would do this via KVO with more time
		[self cloudsLabel_text_update];
	}
	
#pragma mark - rain
-(void)setRain:(WAOpenWeatherRain *)rain
	{
		kRUConditionalReturn(self.rain == rain, NO);
		
		_rain = rain;
		
		//would do this via KVO with more time
		[self rainLabel_text_update];
	}
	
#pragma mark - wind
-(void)setWind:(WAOpenWeatherCityWind *)wind
	{
		kRUConditionalReturn(self.wind == wind, NO);
		
		_wind = wind;
		
		//would do this via KVO with more time
		[self windLabel_text_update];
	}
	
#pragma mark - windLabel
-(CGRect)windLabel_frame
	{
		CGSize const size = [self.windLabel ruTextSizeConstrainedToWidth:CGRectGetWidth(self.contentView.bounds)];
		
		return CGRectCeilOrigin((CGRect){
			.size	= size
		});
	}
-(void)windLabel_text_update
	{
		[self.windLabel setText:RUStringWithFormat(@"Wind Speed: %@, Wind gust: %@", self.wind.speed.stringValue, self.wind.deg.stringValue)];
		[self setNeedsLayout];
	}
	
#pragma mark - rainLabel
-(CGRect)rainLabel_frame
	{
		CGSize const size = [self.rainLabel ruTextSizeConstrainedToWidth:CGRectGetWidth(self.contentView.bounds)];
		
		return CGRectCeilOrigin((CGRect){
			.origin.y	= CGRectGetMaxY([self windLabel_frame]) + 15.0f,
			.size		= size
		});
	}
-(void)rainLabel_text_update
	{
		[self.rainLabel setText:RUStringWithFormat(@"Whatever 3h means: %@", self.rain.degreeOfRain.stringValue)];
		[self setNeedsLayout];
	}
	
#pragma mark - cloudsLabel
-(CGRect)cloudsLabel_frame
	{
		CGSize const size = [self.cloudsLabel ruTextSizeConstrainedToWidth:CGRectGetWidth(self.contentView.bounds)];
		
		return CGRectCeilOrigin((CGRect){
			.origin.y		= CGRectGetMaxY([self rainLabel_frame]) + 15.0f,
			.size		= size
		});
	}
-(void)cloudsLabel_text_update
	{
		[self.cloudsLabel setText:RUStringWithFormat(@"whatever the measure of a clouds is: %@", self.clouds.all)];
		[self setNeedsLayout];
	}

@end
