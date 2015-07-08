//
//  ArticleDetailViewController.h
//  CC
//
//  Created by Fly on 12/15/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleMO.h"
#import "CustomButton.h"

@interface ArticleDetailViewController : UIViewController

/**Image Cointainer View**/

@property (strong, nonatomic) IBOutlet CustomButton *buttonImageDetailView;

@property (strong, nonatomic) IBOutlet UITextField *articleName;
@property (strong, nonatomic) IBOutlet UITextField *percentageDiscount;

/**Description Container View**/
@property (strong, nonatomic) IBOutlet UITextView *articleDescriptionTextView;

/**Price Container View**/
@property (strong, nonatomic) IBOutlet UITextField *regularPriceFieldText;
@property (strong, nonatomic) IBOutlet UITextField *valueRegularPriceFieldText;
@property (strong, nonatomic) IBOutlet UITextField *discountPriceFieldText;
@property (strong, nonatomic) IBOutlet UITextField *valueDiscountPriceText;

/**Navigation Container View**/
@property (strong, nonatomic) IBOutlet UITextField *navigationFieldText;
@property (strong, nonatomic) IBOutlet CustomButton *navigationButton;

/**Utility**/
@property(strong, nonatomic) ArticleMO *articleMOSelected;

@end
