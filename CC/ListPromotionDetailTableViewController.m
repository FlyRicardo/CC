//
//  ListPromotionDetailTableViewController.m
//  CC
//
//  Created by Fly on 12/5/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "ListPromotionDetailTableViewController.h"
#import "ArticleDetailViewController.h"

#import "WebServiceFactory.h"
#import "WebServicePromotionsDetailListByCategory.h"
#import "WebServicePromotionList.h"

#import "UtilityFactory.h"
#import "ImageUtility.h"

#import "ArticlesViewCell.h"

#import "LocalServiceFactory.h"
#import "FetchedResultController.h"

#import "ArticleMO.h"
#import "PhotoMO.h"
#import "StoreMO.h"
#import "PromotionMO.h"

@interface ListPromotionDetailTableViewController ()

@property (nonatomic, strong) NSArray *promotionListByCategory;
@property (nonatomic) ArticleMO *articleMOSelected;

@property (nonatomic, strong) FetchedResultController *fetchedResultsController;

@end

@implementation ListPromotionDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFetchedViewController];
    self.tableView.separatorColor = [UIColor clearColor];
    [self callWSPromotionsDetail:[_categoryMO categoryId]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [self configureNavigationBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
     return [[[_fetchedResultsController getFetchedResultsController] sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil((float)_promotionListByCategory.count/(float)2);
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     NSInteger indexPathRow = 0;
     if(indexPath.row != 0)indexPathRow = (2*indexPath.row);
     
     ArticlesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articlesCell" forIndexPath:indexPath];
     
     if(indexPathRow < _promotionListByCategory.count){

         ArticleMO *articleMO1 = _promotionListByCategory[indexPathRow];
         
         [[cell articleButton1] setImage:[self loadArticleImage:articleMO1] forState:UIControlStateNormal];
         cell.articleButton1.idButton = articleMO1.articleId;
         cell.articleButton1.nameButton = articleMO1.name;
         [cell.articleButton1 addTarget:self action:@selector(articleButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
         
         
         [[cell storeNameTextField1 ] setText:[NSString stringWithFormat:@"%@",[[articleMO1 storeMO]name]]];
         [[cell storeNameTextField1] setBackground:[UIImage imageNamed:@"nameStoreListBg"]];
//         cell.storeNameTextField1.leftViewMode= UITextFieldViewModeAlways;
//         cell.storeNameTextField1.leftView = self.customView;

         
         [[cell discountTextField1] setText:[[NSString stringWithFormat:@" %@",[[articleMO1 promotionMO]percentageDiscount]] stringByAppendingString:@"%"]];
         [[cell discountTextField1] setBackground:[UIImage imageNamed:@"percentageDiscList"]];
         
         
     }else{
         return cell;
     }
     
     if(indexPathRow + 1 < _promotionListByCategory.count){
         ArticleMO *articleMO2 = _promotionListByCategory[indexPathRow+1];
         
         [[cell articleButton2] setImage:[self loadArticleImage:articleMO2] forState:UIControlStateNormal];
         cell.articleButton2.idButton = articleMO2.articleId;
         cell.articleButton2.nameButton = articleMO2.name;
         [cell.articleButton2 addTarget:self action:@selector(articleButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
         
         [[cell storeNameTextField2] setText:[NSString stringWithFormat:@"%@", [[articleMO2 storeMO]name]]];
         [[cell storeNameTextField2] setBackground:[UIImage imageNamed:@"nameStoreListBg"]];
         
         [[cell discountTextField2] setText:[[NSString stringWithFormat:@" %@",[[articleMO2 promotionMO]percentageDiscount]] stringByAppendingString:@"%"]];
         [[cell discountTextField2] setBackground:[UIImage imageNamed:@"percentageDiscList"]];
    }else{
         return cell;
     }
     
     return cell;
 }

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSManagedObject *object = [[_fetchedResultsController getFetchedResultsController ]objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

-(void) articleButtonSelected: (id) button
{
    CustomButton *articleButton = (CustomButton*) button;
    NSLog(@"Button selected %li", (long)articleButton.idButton);
      _articleMOSelected = [[ArticleMO alloc]init];
    [_articleMOSelected setArticleId : articleButton.idButton];
    [_articleMOSelected setName: articleButton.nameButton];
    [self performSegueWithIdentifier:@"ArticleDetail" sender:self];
}


 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if( [[segue identifier] isEqualToString: @"ArticleDetail"]){
         ArticleDetailViewController  *articleDetailViewController = [segue destinationViewController];
         articleDetailViewController.articleMOSelected = _articleMOSelected;
     }
 }
 

#pragma mark - Customize methods class

-(void) initFetchedViewController
{
    LocalServiceFactory *localServiceFactory = [[LocalServiceFactory alloc]init];
    _fetchedResultsController = [localServiceFactory createFetchedResultControllerWithType:0];
}

-(void) callWSPromotionsDetail :(NSInteger) withId{
    
    //Register the notification proccess of complete the fetching data
    [self registerNotifyPromotionListByCategoryProcess];
    
    WebServiceFactory *ws = [[WebServiceFactory alloc]init];//TODO: convert this on Singleton
    
    WebServicePromotionsDetailListByCategory *webServicePromotionsDetailListByCategory = [ws createWebServicePromotionsDetail:0];
    
    //Trigger the Web Service Promotion List
    [webServicePromotionsDetailListByCategory getPromotionsDetailByCategory:withId];
    
}

-(void)registerNotifyPromotionListByCategoryProcess{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePromotionListByCategoryNotification:)
                                             name:@"PromotionListByCategoryNotification"
                                               object:nil];
}

- (void) receivePromotionListByCategoryNotification:(NSNotification *) notification
{
    // [notification name] should always be @"PromotionListNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"PromotionListByCategoryNotification"]){
        NSDictionary *dictionary = notification.userInfo;
        _promotionListByCategory = (NSArray*) dictionary[@"promotionListByCategory"];
        [self saveArticlesImage];
        [self.tableView reloadData];
    }
}

-(UIImage*) loadArticleImage:(ArticleMO*) articleMO{
    
    UtilityFactory *utilityFactory = [[UtilityFactory alloc]init];
    
    ImageUtility *imageUtility = [utilityFactory createImageUtility:0];
    
    return [imageUtility loadImageFromLocalURL:[[articleMO photoMO]url] withTypeOfImage:1];
    
}


-(void) saveArticlesImage{
    UtilityFactory *utilityFactory = [[UtilityFactory alloc]init];
    
    ImageUtility *imageUtility = [utilityFactory createImageUtility:0];
    
    for (int i = 0; i<[_promotionListByCategory count]; i++) {
        ArticleMO *temp = _promotionListByCategory[i];
        [imageUtility saveImageFromHttpURL:[[temp photoMO] url] withTypeOfImage:1];
    }
    
}

-(void) configureNavigationBar{
    
    //The index of View controllers, for this case, should be : 1 , or the second view Added to the Navigation Controler
    UINavigationController *navigationController = [self.navigationController.viewControllers objectAtIndex:1];
    UINavigationBar *navigationBar =[[navigationController navigationController] navigationBar];
    UINavigationItem* navigationItem = [navigationController navigationItem];
    
    [navigationBar setTintColor:[UIColor redColor]];
    [navigationItem setTitle: [_categoryMO name]];
    
//    UIBarButtonItem* backbutton = [[UIBarButtonItem alloc] initWithTitle:@"< Accesorios" style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];
//    
//    UIBarButtonItem* backbutton =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backAccesories"] style:UIBarButtonItemStylePlain target:self action:@selector(btnClicked:)];
//
//    
//    [backbutton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                            [UIFont fontWithName:@"Helvetica" size:12.0f],
//                                            NSFontAttributeName,
//                                            [UIColor blackColor],
//                                            NSFontAttributeName,
//                                            nil]
//                              forState:UIControlStateNormal];
//    [navigationItem setLeftBarButtonItem:backbutton];
    
   [[navigationItem leftBarButtonItem]
        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"Helvetica" size:8.0f],
                                NSFontAttributeName,
                                [UIColor blackColor],
                                NSFontAttributeName,
                                nil]
                                forState:UIControlStateNormal];
}
                                   
-(void) btnClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:TRUE];
}




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



@end
