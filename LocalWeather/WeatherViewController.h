//
//  WeatherViewController.h
//  LocalWeather
//
//  Created by ethlite on 3/2/15.
//  Copyright (c) 2015 Pet Lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherData.h"

@interface WeatherViewController : UITableViewController

@property (strong, nonatomic) WeatherData *weatherData;

@end
