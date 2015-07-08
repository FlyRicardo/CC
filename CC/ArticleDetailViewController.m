//
//  ArticleDetailViewController.m
//  CC
//
//  Created by Fly on 12/15/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "ArticleDetailViewController.h"

#import "LocalServiceFactory.h"
#import "FetchedResultController.h"

#import "WebServiceFactory.h"
#import "WebServiceArticleDetailById.h"

#import "UtilityFactory.h"
#import "ImageUtility.h"

#import "ArticleMO.h"
#import "PhotoMO.h"
#import "StoreMO.h"
#import "PromotionMO.h"

#import "StoreNavigationMapViewController.h"


@interface ArticleDetailViewController ()

@property (nonatomic, strong) FetchedResultController *fetchedResultsController;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFetchedViewController];
    [self callWSArticleById:[_articleMOSelected articleId]];
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

#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

#pragma mark - Customize methods class

-(void) fillCustomView{
    
    [_buttonImageDetailView setImage:[self loadArticleImage : _articleMOSelected] forState:UIControlStateNormal];
    [_articleName setText: [_articleMOSelected name]];
    [_percentageDiscount setText:[[NSString stringWithFormat:@" %@",[[_articleMOSelected promotionMO]percentageDiscount]] stringByAppendingString:@"%"]];
    
    [_articleDescriptionTextView setText:[_articleMOSelected descriptionArticle]];
    
    [_regularPriceFieldText setText:@"Precio Normal"];
    [_valueRegularPriceFieldText setText:[ NSString stringWithFormat:@" $%@ COP",[self formatNumber:[_articleMOSelected price]]]];
    [_discountPriceFieldText setText:@"Precio descuento"];
    NSNumber *discount = [[_articleMOSelected promotionMO]percentageDiscount];
    NSNumber *price = [_articleMOSelected price];
    NSNumber* priceWithDiscount = [NSNumber numberWithFloat: ([price floatValue] - ([discount floatValue]*[price floatValue]/100))];
    [_valueDiscountPriceText setText:[ NSString stringWithFormat:@" $%@ COP", [self formatNumber: priceWithDiscount]]];
    
    [_navigationFieldText setText:@"Ir al Almacén"];
    [_navigationButton setImage:[UIImage imageNamed:@"NavigationIcon"] forState:UIControlStateNormal];
    [_navigationButton addTarget:self  action:@selector(articleButtonSelected:) forControlEvents:UIControlEventTouchUpInside];

}

-(void) articleButtonSelected: (id) button
{
    [self performSegueWithIdentifier:@"NavigationStoreMap" sender:self];
}


-(void) initFetchedViewController
{
    LocalServiceFactory *localServiceFactory = [[LocalServiceFactory alloc]init];
    _fetchedResultsController = [localServiceFactory createFetchedResultControllerWithType:0];
}

-(void) callWSArticleById :(NSInteger) withId{
    
    //Register the notification proccess of complete the fetching data
    [self registerNotifyArticleByIdProcess];
    
    WebServiceFactory *ws = [[WebServiceFactory alloc]init];//TODO: convert this on Singleton
    
    WebServiceArticleDetailById *webServiceArticleDetailById = [ws createWebServiceArticleById:0];
    
    //Trigger the Web Service Promotion List
    [webServiceArticleDetailById getArticleDetailWithId:_articleMOSelected.articleId];
    
}

-(void)registerNotifyArticleByIdProcess{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveArticleByIdNotification:)
                                                 name:@"ArticleByIdNotification"
                                               object:nil];
}

- (void) receiveArticleByIdNotification:(NSNotification *) notification
{
    // [notification name] should always be @"PromotionListNotification"
    // unless you use this method for observation of other notifications
    // as well.x
    
    if ([[notification name] isEqualToString:@"ArticleByIdNotification"]){
        NSDictionary *dictionary = notification.userInfo;
        _articleMOSelected = (ArticleMO*) dictionary[@"articleById"];
        [self saveArticlesImage];
        [self fillCustomView];
        [self.view setNeedsDisplay];
    }
}

-(UIImage*) loadArticleImage:(ArticleMO*) articleMO{
    
    UtilityFactory *utilityFactory = [[UtilityFactory alloc]init];
    ImageUtility *imageUtility = [utilityFactory createImageUtility:0];
    
    return [imageUtility loadImageFromLocalURL:[[articleMO photoMO]url] withTypeOfImage:2];
    
}


-(void) saveArticlesImage{
    UtilityFactory *utilityFactory = [[UtilityFactory alloc]init];
    
    ImageUtility *imageUtility = [utilityFactory createImageUtility:0];
    
    [imageUtility saveImageFromHttpURL:[[_articleMOSelected photoMO] url] withTypeOfImage:2];
    
}

-(NSString * ) formatNumber: (NSNumber* ) number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    formatter.usesSignificantDigits = NO;
    formatter.usesGroupingSeparator = YES;
    formatter.groupingSeparator = @".";
    formatter.decimalSeparator = @",";

    return [formatter stringFromNumber:number];
    
}


-(void) configureNavigationBar{
    
    //The index of View controllers, for this case, should be : 1 , or the second view Added to the Navigation Controler
    UINavigationController *navigationController = [self.navigationController.viewControllers objectAtIndex:2];
    UINavigationBar *navigationBar =[[navigationController navigationController] navigationBar];
    UINavigationItem* navigationItem = [navigationController navigationItem];
    
    [navigationBar setTintColor:[UIColor redColor]];
    [navigationItem setTitle: [_articleMOSelected name]];
    
    /**Setting left button with text**/
//    UIBarButtonItem* backbutton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];

    /**Setting left button with image**/
//    UIBarButtonItem* backbutton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];
//
//    
//    [backbutton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                        [UIFont fontWithName:@"Helvetica" size:10.0f],
//                                        NSFontAttributeName,
//                                        [UIColor blackColor],
//                                        NSFontAttributeName,
//                                        nil]
//                              forState:UIControlStateNormal];
//    
//    [navigationItem setLeftBarButtonItem:backbutton];
}


-(void) btnClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:TRUE];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [[segue identifier] isEqualToString: @"NavigationStoreMap"]){
        StoreNavigationMapViewController  *storeNavigationMapViewController = [segue destinationViewController];
        storeNavigationMapViewController.storeMO = [_articleMOSelected storeMO];
    }
}



@end