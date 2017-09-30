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

#import <ResplendentUtilities/RUConditionalReturn.h>
#import <ResplendentUtilities/UIView+RUUtility.h>





static void* kWAWeatherDisplayViewController_KVOContext = &kWAWeatherDisplayViewController_KVOContext;





@interface WAWeatherDisplayViewController () <UITextFieldDelegate>
	
#pragma mark - searchTextField
@property (nonatomic, readonly, strong, nullable) UITextField* searchTextField;
-(CGRect)searchTextField_frame;

#pragma mark - searchCityRequest_attempt
-(void)searchCityRequest_attempt_with_text:(nullable NSString*)text;
-(void)searchCityRequest_attempt_handleSuccess_with_city:(WAOpenWeatherCity*)city;
-(void)searchCityRequest_attempt_handleFailure;

#pragma mark - openWeatherCity
@property (nonatomic, strong, nullable) WAOpenWeatherCity* openWeatherCity;
-(void)openWeatherCity_setKVORegistered:(BOOL)registered;
	
#pragma mark - tableView
@property (nonatomic, readonly, strong, nullable) UITableView* tableView;
-(CGRect)tableView_frame;

#pragma mark - navigationItem
-(nullable NSString*)navigationItem_text_appropriate;
-(void)navigationItem_text_update;

@end





@implementation WAWeatherDisplayViewController

#pragma mark - dealloc
-(void)dealloc
{
	[self openWeatherCity_setKVORegistered:NO];
}

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];
	
	[self navigationItem_text_update];
	
	_searchTextField = [UITextField new];
	[self.searchTextField setBackgroundColor:[UIColor orangeColor]];
	[self.searchTextField setTextAlignment:NSTextAlignmentCenter];
	[self.searchTextField setReturnKeyType:UIReturnKeySearch];
	[self.searchTextField setDelegate:self];
	[self.view addSubview:self.searchTextField];
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	[self.tableView setBackgroundColor:[UIColor blackColor]];
	[self.view addSubview:self.tableView];
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
					NSLog(@"weather");
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO base]])
				{
					NSLog(@"base");
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO main]])
				{
					NSLog(@"main");
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO wind]])
				{
					NSLog(@"wind");
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO rain]])
				{
					NSLog(@"rain");
				}
				else if ([keyPath isEqualToString:[WAOpenWeatherCity_PropertiesForKVO clouds]])
				{
					NSLog(@"clouds");
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
	UIAlertController* const alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Something went wrong. Please try our search again" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:okayAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}
	
#pragma mark - navigationItem
-(nullable NSString*)navigationItem_text_appropriate
{
	WAOpenWeatherCity* const city = self.openWeatherCity;
	kRUConditionalReturn_ReturnValue(city == nil, NO, @"Search for a city!");
	kRUConditionalReturn_ReturnValue(city.name == nil, NO, @"Hm, try again");
	
	return city.name;
}
	
-(void)navigationItem_text_update
{
	[self.navigationItem setTitle:[self navigationItem_text_appropriate]];
}

@end
