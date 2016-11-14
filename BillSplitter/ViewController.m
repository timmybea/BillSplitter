//
//  ViewController.m
//  BillSplitter
//
//  Created by Tim Beals on 2016-11-12.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinersLabel;
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UISlider *dinersSlider;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentSlider;

@property (weak, nonatomic) IBOutlet UILabel *shareOfBillLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) NSDecimalNumber *billAmt;
@property (nonatomic, strong) NSDecimalNumber *shareBill;
@property (nonatomic, strong) NSDecimalNumber *tip;
@property (nonatomic, strong) NSDecimalNumber *total;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.billField.delegate = self;
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (IBAction)dinersSliderChanges:(UISlider *)sender
{
    self.dinersLabel.text = [NSString stringWithFormat:@"%d", (int)self.dinersSlider.value];
    [self updateResults];
}

- (IBAction)tipPercentSliderChanged:(UISlider *)sender
{
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%.1f", self.tipPercentSlider.value];
    [self updateResults];

}

- (void)dismissKeyboard:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.billAmt = [[NSDecimalNumber alloc] initWithFloat: textField.text.floatValue];
    [self updateResults];
}


-(void)updateResults
{
        NSDecimalNumber *diners = [[NSDecimalNumber alloc] initWithInt:(int)self.dinersSlider.value];
        self.shareBill = [self.billAmt decimalNumberByDividingBy:diners];
        
        NSDecimalNumber *percentage = [[NSDecimalNumber alloc] initWithFloat:self.tipPercentSlider.value / 100];
        self.tip = [self.shareBill decimalNumberByMultiplyingBy:percentage];
        
        self.total = [self.shareBill decimalNumberByAdding:self.tip];
        
        self.tipLabel.text = [NSNumberFormatter localizedStringFromNumber:self.tip numberStyle:NSNumberFormatterCurrencyAccountingStyle];
        
        self.shareOfBillLabel.text = [NSNumberFormatter localizedStringFromNumber:self.shareBill numberStyle:NSNumberFormatterCurrencyAccountingStyle];
        
        self.totalLabel.text = [NSNumberFormatter localizedStringFromNumber:self.total numberStyle:NSNumberFormatterCurrencyAccountingStyle];
}

@end
