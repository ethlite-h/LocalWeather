//
//  ViewController.h
//  LocalWeather
//
//  Created by ethlite on 3/2/15.
//  Copyright (c) 2015 Pet Lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *checkWeatherButton;
@property (nonatomic, strong) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, strong) IBOutlet UILabel *lattitudeLabel;
@property (nonatomic, strong) IBOutlet UISwitch *metricsSwitch;

- (IBAction)checkWeather:(id)sender;
- (IBAction)updateLocation:(id)sender;

@end

