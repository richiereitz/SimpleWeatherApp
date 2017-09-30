//
//  WAWeatherDisplayViewController.m
//  WeatherApp
//
//  Created by Richard Reitzfeld on 9/30/17.
//  Copyright © 2017 Richard Reitzfeld. All rights reserved.
//

#import "WAWeatherDisplayViewController.h"
#import "WAOpenWeatherCity.h"
#import "WAOpenWeatherNetworkManager+WAOpenWeatherCityRequests.h"
#import "WAWeatherTableViewCell.h"
#import "WAMainTableViewCell.h"
#import "WALeftoverInformationTableViewCell.h"

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>
#import <ResplendentUtilities/NSString+RUMacros.h>

#import <RTSMTableSectionManager/RTSMTableSectionManager.h>





static void* kWAWeatherDisplayViewController_KVOContext = &kWAWeatherDisplayViewController_KVOContext;





//Would have a more expansive range of cell types to make UI for each given more time
typedef NS_ENUM(NSInteger, WAWeatherDisplayViewController_TableSection_type) {
	WAWeatherDisplayViewController_TableSection_type_none,
	
	WAWeatherDisplayViewController_TableSection_type_weather,
	WAWeatherDisplayViewController_TableSection_type_main,
	WAWeatherDisplayViewController_TableSection_type_leftoverInformation,
	
	WAWeatherDisplayViewController_TableSection_type__first	= WAWeatherDisplayViewController_TableSection_type_weather,
	WAWeatherDisplayViewController_TableSection_type__last		= WAWeatherDisplayViewController_TableSection_type_leftoverInformation,
};





kRUDefineNSStringConstant(kSavedCitySearchStringIdentifier);






@interface WAWeatherDisplayViewController () <UITextFieldDelegate, RTSMTableSectionManager_SectionDelegate, UITableViewDelegate, UITableViewDataSource>
	
#pragma mark - searchTextField
@property (nonatomic, readonly, strong, nullable) UITextField* searchTextField;
-(CGRect)searchTextField_frame;
	
#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;
	
#pragma mark - tableSectionManager
@property (nonatomic, readonly, strong, nullable) RTSMTableSectionManager* tableSectionManager;
	
#pragma mark - weatherTableViewCell
-(nullable WAWeatherTableViewCell*)weatherTableViewCell;
	
#pragma mark - mainTableViewCell
-(nullable WAMainTableViewCell*)mainTableViewCell;
	
#pragma mark - leftoverInfoTableViewCell
-(nullable WALeftoverInformationTableViewCell*)leftoverInfoTableViewCell;

#pragma mark - searchCityRequest_attempt
-(void)searchCityRequest_attempt_with_text:(nullable NSString*)text;
-(void)searchCityRequest_attempt_handleSuccess_with_city:(WAOpenWeatherCity*)city;
-(void)searchCityRequest_attempt_handleFailure;

#pragma mark - openWeatherCity
@property (nonatomic, strong, nullable) WAOpenWeatherCity* openWeatherCity;
-(void)openWeatherCity_setKVORegistered:(BOOL)registered;

#pragma mark - navigationItem
-(nullable NSString*)navigationItem_text_appropriate;
-(void)navigationItem_text_update;

@end





@implementation WAWeatherDisplayViewController

#pragma mark - dealloc
-(void)dealloc
{
	[self openWeatherCity_setKVORegistered:NO];
	[self.tableView setDelegate:nil];
	[self.tableView setDataSource:nil];
}

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self navigationItem_text_update];
	
	_searchTextField = [UITextField new];
	[self.searchTextField setBackgroundColor:[UIColor lightGrayColor]];
	[self.searchTextField setTextAlignment:NSTextAlignmentCenter];
	[self.searchTextField setReturnKeyType:UIReturnKeySearch];
	[self.searchTextField setDelegate:self];
	[self.searchTextField setPlaceholder:@"Search for a city"];
	[self.view addSubview:self.searchTextField];
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setBackgroundColor:[UIColor blackColor]];
	[self.tableView setDelegate:self];
	[self.tableView setDataSource:self];
	[self.view addSubview:self.tableView];
	
	_tableSectionManager = [[RTSMTableSectionManager alloc]initWithFirstSection:WAWeatherDisplayViewController_TableSection_type__first
																	lastSection:WAWeatherDisplayViewController_TableSection_type__last];
	[self.tableSectionManager setSectionDelegate:self];
	
	//would like to, rather than save the string and make the request on load, save the custom object to a file using NSKeyedArchiver
	NSString* const lastSearchString = [[NSUserDefaults standardUserDefaults] objectForKey:kSavedCitySearchStringIdentifier];
	if (lastSearchString.length > 0)
	{
		[self searchCityRequest_attempt_with_text:lastSearchString];
	}
	else
	{
		[self.searchTextField becomeFirstResponder];
	}
}
	
-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	[self.searchTextField setFrame:[self searchTextField_frame]];
	[self.tableView setFrame:[self tableView_frame]];
}
	
#pragma mark - searchTextField
-(CGRect)searchTextField_frame
{
	return CGRectCeilOrigin((CGRect){
		.origin.y	 	= CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]),
		.size.width		= CGRectGetWidth(self.view.bounds),
		.size.height	= 50.0f,
	});
}

#pragma mark - tableView
-(CGRect)tableView_frame
{
	return UIEdgeInsetsInsetRect(self.view.bounds, (UIEdgeInsets){
		.top = CGRectGetMaxY([self searchTextField_frame])
	});
}
	
#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.tableSectionManager.numberOfSectionsAvailable;
}
	
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}
	
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	WAWeatherDisplayViewController_TableSection_type const sectionType = [self.tableSectionManager sectionForIndexPathSection:indexPath.section];
	
	switch (sectionType)
	{
		case WAWeatherDisplayViewController_TableSection_type_none:
		break;
		
		case WAWeatherDisplayViewController_TableSection_type_weather:
		return [self weatherTableViewCell];
		break;
		
		case WAWeatherDisplayViewController_TableSection_type_main:
		return [self mainTableViewCell];
		break;
		
		case WAWeatherDisplayViewController_TableSection_type_leftoverInformation:
		return [self leftoverInfoTableViewCell];
		break;
	}
	
	NSAssert(false, @"unhandled section type %li",(long)sectionType);
	return [UITableViewCell new];
}
	
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//Would make these cells self-sizing based on content given more time
	
	WAWeatherDisplayViewController_TableSection_type const sectionType = [self.tableSectionManager sectionForIndexPathSection:indexPath.section];
	switch (sectionType)
	{
		case WAWeatherDisplayViewController_TableSection_type_none:
			break;
		
		case WAWeatherDisplayViewController_TableSection_type_weather:
			return 70.0f;
			break;
		
		case WAWeatherDisplayViewController_TableSection_type_main:
			return 200.0f;
			break;
		
		case WAWeatherDisplayViewController_TableSection_type_leftoverInformation:
			return 200.0f;
			break;
	}
	
	NSAssert(false, @"unhandled section type %li",(long)sectionType);
	return 0.0f;
}
	
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
	{
		WAWeatherDisplayViewController_TableSection_type const sectionType = [self.tableSectionManager sectionForIndexPathSection:section];
		switch (sectionType)
		{
			case WAWeatherDisplayViewController_TableSection_type_none:
			break;
			
			case WAWeatherDisplayViewController_TableSection_type_weather:
			case WAWeatherDisplayViewController_TableSection_type_main:
			return 10.0f;
			break;
			
			case WAWeatherDisplayViewController_TableSection_type_leftoverInformation:
			return 0.0f;
			break;
		}
		
		NSAssert(false, @"unhandled section type %li",(long)sectionType);
		return 0.0f;
	}
	
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
	{
		UIView* const footer = [UIView new];
		[footer setBackgroundColor:[UIColor clearColor]];
		return footer;
	}

#pragma mark - RTSMTableSectionManager_SectionDelegate
-(BOOL)tableSectionManager:(RTSMTableSectionManager*)tableSectionManager sectionIsAvailable:(NSInteger)section
{
		return YES;
}
	
#pragma mark - weatherTableViewCell
-(nullable WAWeatherTableViewCell*)weatherTableViewCell
	{
		kRUDefineNSStringConstant(kWAWeatherDisplayViewController_cellIdentifier_WAWeatherTableViewCell);
		
		WAWeatherTableViewCell* weatherCell = [self.tableView dequeueReusableCellWithIdentifier:kWAWeatherDisplayViewController_cellIdentifier_WAWeatherTableViewCell];
		if (weatherCell == nil)
		{
			weatherCell = [[WAWeatherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWAWeatherDisplayViewController_cellIdentifier_WAWeatherTableViewCell];
		}
		
		//I don't like doing this but doing so for speed so I don't have to handle potentially multiple weather objects, as the data is sent in an array
		if (self.openWeatherCity.weather.count > 0)
		{
			[weatherCell setWeather:self.openWeatherCity.weather[0]];
		}
		[weatherCell setBackgroundColor:[UIColor blueColor]];
		return weatherCell;
	}
	
#pragma mark - mainTableViewCell
-(nullable WAMainTableViewCell*)mainTableViewCell
	{
		kRUDefineNSStringConstant(kWAWeatherDisplayViewController_cellIdentifier_WAMainTableViewCell);
		
		WAMainTableViewCell* mainTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:kWAWeatherDisplayViewController_cellIdentifier_WAMainTableViewCell];
		if (mainTableViewCell == nil)
		{
			mainTableViewCell = [[WAMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWAWeatherDisplayViewController_cellIdentifier_WAMainTableViewCell];
		}
		
		[mainTableViewCell setMain:self.openWeatherCity.main];
		[mainTableViewCell setBackgroundColor:[UIColor greenColor]];
		return mainTableViewCell;
	}
	
#pragma mark - leftoverInfoTableViewCell
-(nullable WALeftoverInformationTableViewCell*)leftoverInfoTableViewCell
	{
		kRUDefineNSStringConstant(kWAWeatherDisplayViewController_cellIdentifier_WALeftoverInformationTableViewCell);
		
		WALeftoverInformationTableViewCell* leftoverInfoTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:kWAWeatherDisplayViewController_cellIdentifier_WALeftoverInformationTableViewCell];
		if (leftoverInfoTableViewCell == nil)
		{
			leftoverInfoTableViewCell = [[WALeftoverInformationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWAWeatherDisplayViewController_cellIdentifier_WALeftoverInformationTableViewCell];
		}
		
		[leftoverInfoTableViewCell setRain:self.openWeatherCity.rain];
		[leftoverInfoTableViewCell setClouds:self.openWeatherCity.clouds];
		[leftoverInfoTableViewCell setWind:self.openWeatherCity.wind];
		[leftoverInfoTableViewCell setBackgroundColor:[UIColor grayColor]];
		return leftoverInfoTableViewCell;
	}
	
#pragma mark - openWeatherCity
-(void)setOpenWeatherCity:(nullable WAOpenWeatherCity *)openWeatherCity
{
	kRUConditionalReturn(self.openWeatherCity == openWeatherCity, NO);
	
	[self openWeatherCity_setKVORegistered:NO];
	
	_openWeatherCity = openWeatherCity;
	
	[self openWeatherCity_setKVORegistered:YES];
}
-(void)openWeatherCity_setKVORegistered:(BOOL)registered
{
	typeof(self.openWeatherCity) const openWeatherCity = self.openWeatherCity;
	kRUConditionalReturn(openWeatherCity == nil, NO);
	
	NSMutableArray<NSString*>* const propertiesToObserve = [NSMutableArray<NSString*> array];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO coordinate]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO weather]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO base]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO main]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO wind]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO rain]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO clouds]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO dt]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO sys]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO identifier]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO name]];
	[propertiesToObserve addObject:[WAOpenWeatherCity_PropertiesForKVO cod]];
	
	[propertiesToObserve enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyToObserve, NSUInteger idx, BOOL * _Nonnull stop) {
		if (registered)
		{
			[openWeatherCity addObserver:self
						forKeyPath:propertyToObserve
						   options:NSKeyValueObservingOptionInitial
						   context:&kWAWeatherDisplayViewController_KVOContext];
		}
		else
		{
			[openWeatherCity removeObserver:self
						   forKeyPath:propertyToObserve
							  context:&kWAWeatherDisplayViewController_KVOContext];
		}
	}];
}
	
#pragma mark - KVO
-(void)observeValueForKeyPath:(nullable NSString*)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id>*)change context:(nullable void*)context
{
	if (context == kWAWeatherDisplayViewController_KVOContext)
	{
		if (object == self.openWeatherCity)
		{
			if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO coordinate]])
			{
				NSLog(@"Coordinate");
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO weather]])
			{
				[self.tableView reloadData];
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO base]])
			{
				NSLog(@"base");
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO main]])
			{
				[self.tableView reloadData];
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO wind]])
			{
				[self.tableView reloadData];
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO rain]])
			{
				[self.tableView reloadData];
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO clouds]])
			{
				[self.tableView reloadData];
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO dt]])
			{
				NSLog(@"dt");
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO sys]])
			{
				NSLog(@"sys");
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO identifier]])
			{
				NSLog(@"identifier");
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO name]])
			{
				[self navigationItem_text_update];
			}
			else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO cod]])
			{
				NSLog(@"cod");
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
	
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self searchCityRequest_attempt_with_text:textField.text];
	
	if (textField.text > 0)
	{
		//would like to, rather than save the string and make the request on load, save the custom object to a file using NSKeyedArchiver
		[[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kSavedCitySearchStringIdentifier];
	}

	return !textField.resignFirstResponder;
}

#pragma mark - searchCityRequest_attempt
-(void)searchCityRequest_attempt_with_text:(nullable NSString*)text
{
	kRUConditionalReturn(text.length < 1, NO);
	
	__weak typeof(self) const self_weak = self;
	
	[[WAOpenWeatherNetworkManager sharedInstance] searchCities_with_query:text
																  success:^(RKObjectRequestOperation * _Nonnull operation, WAOpenWeatherCity * _Nullable openWeatherCity)
	{
		[self_weak searchCityRequest_attempt_handleSuccess_with_city:openWeatherCity];
	}
																  failure:^(RKObjectRequestOperation * _Nonnull operation, NSError * _Nonnull error, BOOL handledError)
	{
		[self_weak searchCityRequest_attempt_handleFailure];
	}];
}

-(void)searchCityRequest_attempt_handleSuccess_with_city:(WAOpenWeatherCity*)city
{
	kRUConditionalReturn(city == nil, NO);
	[self setOpenWeatherCity:city];
}

-(void)searchCityRequest_attempt_handleFailure
{
	UIAlertController* const alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Something went wrong. Please try your search again" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:okayAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}
	
#pragma mark - navigationItem
-(nullable NSString*)navigationItem_text_appropriate
{
	WAOpenWeatherCity* const city = self.openWeatherCity;
	kRUConditionalReturn_ReturnValue(city == nil, NO, @"Weather App");
	kRUConditionalReturn_ReturnValue(city.name == nil, NO, @"Hm, try again");
	
	return city.name;
}
	
-(void)navigationItem_text_update
{
	[self.navigationItem setTitle:[self navigationItem_text_appropriate]];
}

@end
