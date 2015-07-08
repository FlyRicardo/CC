//
//  ImageUtilityImpl1.m
//  CC
//
//  Created by Fly on 12/1/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "ImageUtilityApache.h"
#import <UIKit/UIKit.h>

#import "IconMO.h"

@interface ImageUtilityApache ()

@property (nonatomic, strong)  NSString * acceptedAppSpecificFolder;

@end

NSString* const rootFolder = @"images";
NSString* const iconFolder = @"icons";
NSString* const imageListFolder = @"imageList";
NSString* const imageDetailFolder = @"imageDetail";


@implementation ImageUtilityApache

-(id)init{
    self = [super init];
    if(self){
        _acceptedAppSpecificFolder = [self getAcceptedAppSpecificFolder];
//        NSLog(@"Accepted directory: %@",_acceptedAppSpecificFolder);
    }
    return self;
}

-(Boolean) saveImageFromHttpURL : (NSString *) httpUrl withTypeOfImage:(NSInteger) type;{
    
    NSString *imageURLHttpApache = httpUrl;
    NSString *imageFolder = [self getLocalImageFolderWithType:type];
    NSString *imageName = [self getLocalImageName:httpUrl];
    NSString *extension = @"PNG";
    
    NSString* fullFolderName = [self createFolder:imageFolder];
    
    //Saving the image on folder recently created
    Boolean wasOperationSuccssefull = (![fullFolderName isEqualToString: @"" ] && [self saveImage:[self getImageFromUrl:imageURLHttpApache] WithFileName:imageName WithExtension:extension InDirectory:fullFolderName]);
    
    return wasOperationSuccssefull;
}


-(UIImage*) loadImageFromLocalURL : (NSString *) imageName withTypeOfImage:(NSInteger) type;{

    NSString *imageNameWithSeparator = [ @"/" stringByAppendingString: [self getLocalImageName:imageName]];
    NSString *folderNameWithSeparator = [ @"/" stringByAppendingString:[self getLocalImageFolderWithType:type]];
    
    NSString *localImagePath = [[_acceptedAppSpecificFolder stringByAppendingString:folderNameWithSeparator] stringByAppendingString:imageNameWithSeparator];
    
    return [UIImage imageWithContentsOfFile:localImagePath];
    
}


#pragma custom methods

- (UIImage *) getImageFromUrl:(NSString *)fileURL{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    return [[UIImage alloc] initWithData:data];
}

-(NSString *)getAcceptedAppSpecificFolder{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

-(NSString*) createFolder:(NSString *)folderName{
    
    Boolean wasOperationSuccssefull = true;
    NSString *fullFolderName = [_acceptedAppSpecificFolder stringByAppendingString:[@"/" stringByAppendingString: folderName]];
    NSError *error = nil;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:fullFolderName]){
        
        wasOperationSuccssefull = [[NSFileManager defaultManager] createDirectoryAtPath:fullFolderName withIntermediateDirectories:NO attributes:nil error:&error];
        
        if(wasOperationSuccssefull){
            NSLog(@"The folder %@, was created", fullFolderName);
            wasOperationSuccssefull = true;
        }else
            NSLog(@"An error ocurred creating the folder %@", fullFolderName);
        
    }else{
        NSLog(@"The folder %@, already exist", fullFolderName);
        wasOperationSuccssefull = true;
    }

    if(!wasOperationSuccssefull){
        NSLog(@"Error: %@ %@", error, [error userInfo]);
        fullFolderName = @"";
    }
    return fullFolderName;
}

-(Boolean) saveImage:(UIImage *)image WithFileName:(NSString *)imageName WithExtension:(NSString *)extension InDirectory:(NSString *)directoryPath{
    
    Boolean wasImageSaved = false;
    
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
       wasImageSaved = [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        wasImageSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
    
    return wasImageSaved;
}

-(NSString *) getLocalImageFolderWithType :(NSInteger) type{
    switch (type) {
        case 0:
            return iconFolder;
            break;
        case 1:
            return imageListFolder;
            break;
        case 2:
            return imageDetailFolder;
            break;
            
        default:
            return iconFolder;
            break;
    }
}

-(NSString *) getLocalImageName: (NSString *) absolutePathUrl{
    NSArray* folders = [absolutePathUrl componentsSeparatedByString:@"/"];
    return [folders[[folders count]-1] componentsSeparatedByString:@"."][0];
    
}


@end