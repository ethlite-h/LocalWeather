//
//  ViewController.m
//  LocalWeather
//
//  Created by ethlite on 3/2/15.
//  Copyright (c) 2015 Pet Lion. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kRequestURL @"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&%@"
#define kRequestURLMetricParameter @"units=metric"
#define kRequestURLImperialParameter @"units=imperial"

@import CoreLocation;
#import "WeatherViewController.h"
#import "WeatherData.h"
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) NSURL *requestURL;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D locationCoords;
@end

@implementation ViewController

// start the call to OpenWeatherMap
- (IBAction)checkWeather:(id)sender
{
    NSString *unitParameter = self.metricsSwitch.on ? kRequestURLMetricParameter : kRequestURLImperialParameter;
    NSString *urlString = [NSString stringWithFormat:kRequestURL, self.locationCoords.latitude, self.locationCoords.longitude, unitParameter];
    self.requestURL = [NSURL URLWithString:urlString];

    dispatch_async(kBgQueue, ^{
        if (self.requestURL) {
            NSData* data = [NSData dataWithContentsOfURL:self.requestURL];
            [self performSelectorOnMainThread:@selector(fetchedData:)
                                   withObject:data waitUntilDone:YES];            
        }
    });
}

- (IBAction)updateLocation:(id)sender
{
    [self.locationManager startUpdatingLocation];
}

// called when JSON has been fetched
- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    if (json) {
        WeatherData *weatherData = [[WeatherData alloc] initWithDictionary:json];
        
        WeatherViewController *weatherVC = [[WeatherViewController alloc] init];
        weatherVC.weatherData = weatherData;
        weatherData.isMetric = self.metricsSwitch.on;
        UINavigationController *navWrapper = [[UINavigationController alloc] initWithRootViewController:weatherVC];
        
        [self presentViewController:navWrapper animated: YES completion: nil];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    if (locations.count) {
        CLLocation *location = locations[0];
        self.locationCoords = location.coordinate;
        
        self.checkWeatherButton.enabled = YES;
        
        self.longitudeLabel.text = [NSString stringWithFormat:@"%f", self.locationCoords.longitude];
        self.lattitudeLabel.text = [NSString stringWithFormat:@"%f", self.locationCoords.latitude];
        
        [manager stopUpdatingLocation];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.checkWeatherButton.enabled = NO;       // re-enable this when we have the location

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
