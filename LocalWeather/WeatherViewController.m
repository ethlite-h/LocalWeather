//
//  WeatherViewController.m
//  LocalWeather
//
//  Created by ethlite on 3/2/15.
//  Copyright (c) 2015 Pet Lion. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

static NSString *kCellID = @"kCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellID];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissWeatherView)];
    self.modalPresentationStyle = UIModalPresentationPopover;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.weatherData.locationName;
}

- (void)dismissWeatherView
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    NSDictionary *weatherData = [self.weatherData measurements];
    id data;
    
    switch (indexPath.section) {
        case 0:
            data = [self.weatherData weatherDescription];
            break;
        case 1:
            data = weatherData[kWeatherDataHumidityKey];
            break;
        case 2:
            data = weatherData[kWeatherDataPressureKey];
            break;
        case 3:
            data = weatherData[kWeatherDataTemperatureKey];
            break;
        case 4:
            data = weatherData[kWeatherDataMinTemperatureKey];
            break;
        case 5:
            data = weatherData[kWeatherDataMaxTemperatureKey];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = [data description];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    switch (section) {
        case 0:
            title = @"Description";
            break;
        case 1:
            title = @"Humidity (%)";
            break;
        case 2:
            title = @"Pressure (hpa)";
            break;
        case 3:
            title = self.weatherData.isMetric ? @"Temperature (°C)" : @"Temperature (°F)";
            break;
        case 4:
            title = self.weatherData.isMetric ? @"Min Temperature (°C)" : @"Min Temperature (°F)";
            break;
        case 5:
            title = self.weatherData.isMetric ? @"Max Temperature (°C)" : @"Max Temperature (°F)";
            break;
        default:
            break;
    }
    return title;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
