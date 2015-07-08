//
//  StoreNavigationMapViewController.m
//  CC
//
//  Created by Fly on 12/18/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "StoreNavigationMapViewController.h"

@interface StoreNavigationMapViewController ()

@end

@implementation StoreNavigationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    //The index of View controllers, for this case, should be : 2 , or the third view Added to the Navigation Controler
    [self configureNavigationBar];
}

-(void) configureNavigationBar{
    
    //The index of View controllers, for this case, should be : 1 , or the second view Added to the Navigation Controler
    UINavigationController *navigationController = [self.navigationController.viewControllers objectAtIndex:3];
    UINavigationBar *navigationBar =[[navigationController navigationController] navigationBar];
    UINavigationItem* navigationItem = [navigationController navigationItem];
    
    [navigationBar setTintColor:[UIColor redColor]];
    [navigationItem setTitle: [_storeMO name]];
    
    /**Setting left button with text**/
        UIBarButtonItem* backbutton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];
    
    /**Setting left button with image**/
//    UIBarButtonItem* backbutton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];
    
//    
//    [backbutton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                        [UIFont fontWithName:@"Helvetica" size:12.0f],
//                                        NSFontAttributeName,
//                                        [UIColor blackColor],
//                                        NSFontAttributeName,
//                                        nil]
//                              forState:UIControlStateNormal];
//    [navigationItem setLeftBarButtonItem:backbutton];
}

-(void) btnClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:TRUE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
