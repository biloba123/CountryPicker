//
//  CPHomeViewController.m
//  CountryPicker
//
//  Created by 吕晴阳 on 2018/9/29.
//  Copyright © 2018 Lv Qingyang. All rights reserved.
//

#import "CPHomeViewController.h"
#import "CPCountryTableViewController.h"
#import "CPCountry.h"
#import "CPIndicatorBar.h"

@interface CPHomeViewController ()
@property(weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation CPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)pickupCountry:(id)sender {
    [CPCountryTableViewController pickWithViewController:self callback:^(CPCountry *country) {
        self.resultLabel.text = [NSString stringWithFormat:@"%@ +%d", country.zh, country.code];;
    }];
}

@end
