//
//  ViewController.m
//  EkuProgressView
//
//  Created by ysghome on 6/8/16.
//  Copyright © 2016 ysghome. All rights reserved.
//

#import "ViewController.h"
#import "EkuProgressView.h"
#import "NSString+EkuCategoriges.h"

@interface ViewController ()

@property (nonatomic, strong) EkuProgressView *createProgressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.createProgressView = [[EkuProgressView alloc] initWithFrame:CGRectMake(20, 40, 280, 30)];
    [self.createProgressView setBackgroundColor:[UIColor blackColor]];
    self.createProgressView.pageCount = 3;
    [self.view addSubview:self.createProgressView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeProgressViewV:(UISlider *)sender {
    [self.progressView setProgress:sender.value animated:YES];
    [self.createProgressView setProgress:sender.value animated:YES];
}


- (IBAction)changeProgressViewValue:(id)sender {
    if ([self.numberTextField.text isPureFloat] && [self.numberTextField.text floatValue] >= 1.0) {
        [self.progressView animateSelectedLineToNewIndex:[self.numberTextField.text floatValue]];
        [self.createProgressView animateSelectedLineToNewIndex:[self.numberTextField.text floatValue]];
    } else if ([self.numberTextField.text isPureFloat]) {
        [self.progressView setProgress:[self.numberTextField.text floatValue] animated:YES];
        [self.createProgressView setProgress:[self.numberTextField.text floatValue] animated:YES];
    }
}

@end
