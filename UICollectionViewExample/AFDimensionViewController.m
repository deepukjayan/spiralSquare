//
//  AFDimensionViewController.m
//  UICollectionViewExample
//
//  Created by Deepak K on 07/11/14.
//  Copyright (c) 2014 221B. All rights reserved.
//

#import "AFDimensionViewController.h"
#import "AFMasterViewController.h"

@interface AFDimensionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtDimension;

@end

@implementation AFDimensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AFMasterViewController*master = (AFMasterViewController*)segue.destinationViewController;
    [master setDimension:[self.txtDimension.text intValue]];
}


@end
