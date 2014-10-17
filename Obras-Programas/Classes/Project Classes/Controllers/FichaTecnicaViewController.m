//
//  FichaTecnicaViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras Nava on 10/10/14.
//  Copyright (c) 2014 Edicomex. All rights reserved.
//

#import "FichaTecnicaViewController.h"
#import "Obra.h"
#import "FirstColumnTableViewController.h"
#import "SecondColumnTableViewController.h"
#import "ThirdColumnTableViewController.h"

@interface FichaTecnicaViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagenBanner;
@property (weak, nonatomic) IBOutlet UIImageView *imagenLogo;
@property (weak, nonatomic) IBOutlet UIImageView *imagenLogoDependencia;
@property FirstColumnTableViewController *firstColumn;
@property SecondColumnTableViewController *secondColumn;
@property ThirdColumnTableViewController *thirdColumn;

@end

@implementation FichaTecnicaViewController
@synthesize obra = _obra;
@synthesize firstColumn = _firstColumn;
@synthesize secondColumn = _secondColumn;
@synthesize thirdColumn = _thirdColumn;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"firstColumnSegue"]) {
        _firstColumn = (FirstColumnTableViewController*) [segue destinationViewController];
        _firstColumn.obra = _obra;
    }else
    if ([segueName isEqualToString: @"secondColumnSegue"]) {
        _secondColumn = (SecondColumnTableViewController*) [segue destinationViewController];
        _secondColumn.obra = _obra;
    }else
    if ([segueName isEqualToString: @"thirdColumnSegue"]) {
        _thirdColumn = (ThirdColumnTableViewController*) [segue destinationViewController];
        _thirdColumn.obra = _obra;
    }
}



#pragma mark - Navigation



@end