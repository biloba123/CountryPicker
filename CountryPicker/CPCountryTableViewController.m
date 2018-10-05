//
//  CPCountryTableViewController.m
//  CountryPicker
//
//  Created by 吕晴阳 on 2018/9/30.
//  Copyright © 2018 Lv Qingyang. All rights reserved.
//

#import "CPCountryTableViewController.h"
#import "MJExtension.h"
#import "CPCountry.h"
#import "CPIndicatorBar.h"

#define ResourceBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]]

@interface CPCountryTableViewController () <UITableViewDataSource, UITableViewDelegate, CPIndicatorBarDelegate>
@property(weak, nonatomic) IBOutlet UITableView *countryTable;
@property(copy, nonatomic) NSArray *countries;
@property(copy, nonatomic) NSArray<NSString *> *titles;
@property(copy, nonatomic) NSArray<NSValue *> *ranges;
@end

@implementation CPCountryTableViewController

+ (void)pickWithViewController:(UIViewController *)viewController callback:(void (^)(CPCountry *country))callback {
    CPCountryTableViewController *tableViewController = [CPCountryTableViewController new];
    tableViewController.callback = callback;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    [viewController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark  -- Init

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    [self initTableView];
    [self initCountry];
    [self initIndicatorBar];
}

- (void)initIndicatorBar {
    CPIndicatorBar *indicatorBar = [CPIndicatorBar new];
    indicatorBar.indicators = self.titles;
    indicatorBar.delegate = self;

    CGRect parentFrame = self.view.frame;
    CGRect frame = indicatorBar.frame;
    frame.origin.x = parentFrame.size.width - frame.size.width;
    frame.origin.y = (parentFrame.size.height - frame.size.height) / 2;
    indicatorBar.frame = frame;

    [self.view addSubview:indicatorBar];
}

- (void)initNavigationBar {
    self.navigationItem.title = @"选择国家和地区";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initTableView {
    self.countryTable.dataSource = self;
    self.countryTable.delegate = self;
    [self.countryTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)initCountry {
    NSString *path = [ResourceBundle pathForResource:@"code" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.countries = [CPCountry mj_objectArrayWithKeyValuesArray:json];

    //分组
    NSMutableArray *titles = [NSMutableArray new];
    NSMutableArray *ranges = [NSMutableArray new];
    CPCountry *country;
    NSString *en;
    NSString *lastTitle = nil;
    NSString *curTitle = nil;
    int count = 0;
    for (int i = 0, len = self.countries.count; i < len; i++) {
        country = self.countries[i];
        en = country.en;
        if (en && en.length > 0) {
            curTitle = [en substringToIndex:1];
            if ([curTitle isEqualToString:lastTitle]) {
                count++;
            } else {
                if (i != 0) {
                    [titles addObject:lastTitle];
                    [ranges addObject:[NSValue valueWithRange:NSMakeRange(i - count, count)]];
                }
                count = 1;
                lastTitle = curTitle;
            }
        }
    }
    [titles addObject:lastTitle];
    [ranges addObject:[NSValue valueWithRange:NSMakeRange(self.countries.count - count, count)]];

    self.titles = titles;
    self.ranges = ranges;

}

#pragma mark -- TableView data source delegate

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CPCountry *country = [self countryFormIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ +%d", country.zh, country.code];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ranges[section].rangeValue.length;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

#pragma mark -- TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CPCountry *country = [self countryFormIndexPath:indexPath];
    self.callback(country);
    [self close];
}


#pragma mark -- action

- (void)close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Other

- (CPCountry *)countryFormIndexPath:(NSIndexPath *)indexPath {
    unsigned long index = self.ranges[[indexPath indexAtPosition:0]].rangeValue.location + [indexPath indexAtPosition:1];
    return self.countries[index];
}

#pragma mark -- IndicatorBar delegate

- (void)indicatorBar:(CPIndicatorBar *)indicatorBar didSelectAtIndex:(int)index {
    NSUInteger indexes[] = {index, 0};
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
    [self.countryTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}


@end
