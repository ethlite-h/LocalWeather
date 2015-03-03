//
//  WeatherData.h
//  LocalWeather
//
//  Created by ethlite on 3/2/15.
//  Copyright (c) 2015 Pet Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWeatherDataHumidityKey @"humidity"
#define kWeatherDataPressureKey @"pressure"
#define kWeatherDataTemperatureKey @"temp"
#define kWeatherDataMaxTemperatureKey @"temp_max"
#define kWeatherDataMinTemperatureKey @"temp_min"

@interface WeatherData : NSObject

@property (assign, nonatomic) BOOL isMetric;

- (instancetype)initWithDictionary:(NSDictionary *)json;
- (NSString *)weatherDescription;
- (NSString *)locationName;
- (NSDictionary *)measurements;

@end
