//
//  WeatherData.m
//  LocalWeather
//
//  Created by ethlite on 3/2/15.
//  Copyright (c) 2015 Pet Lion. All rights reserved.
//

#define kWeatherDataKey @"main"
#define kWeatherDescriptionKey @"weather"
#define kWeatherDescriptionTextKey @"description"
#define kWeatherLocationKey @"name"
#define kWeatherLocationString @"Weather for %@"

#import "WeatherData.h"

@interface WeatherData ()
@property (strong, nonatomic) NSDictionary *weatherData;
@property (strong, nonatomic) NSDictionary *weatherDescriptionData;
@property (strong, nonatomic) NSString *weatherLocationName;
@end

@implementation WeatherData

- (instancetype)initWithDictionary:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        self.weatherData = json[kWeatherDataKey];
        NSArray *descArray = json[kWeatherDescriptionKey];
        if (descArray.count) {
            self.weatherDescriptionData = descArray[0];
        }
        self.weatherLocationName = json[kWeatherLocationKey];
    }
    return self;
}

- (NSString *)weatherDescription
{
    return self.weatherDescriptionData[kWeatherDescriptionTextKey];
}

- (NSString *)locationName
{
    return [NSString stringWithFormat:kWeatherLocationString, self.weatherLocationName];
}

- (NSDictionary *)measurements
{
    return self.weatherData;
}

@end
