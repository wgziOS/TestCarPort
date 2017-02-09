//
//  LoadImage.h
//  YzzYingyuan
//
//  Created by Ashes of time on 8/30/16.
//  Copyright © 2016 csq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadImage : NSObject

+(NSMutableURLRequest*)loadImageWithPost:(NSString*)urlString;

+(void)loadWithImageView:(UIImageView*)imageView andUrl:(NSString*)urlString;

+(void)loadWithButton:(UIButton*)button andUrl:(NSString*)urlString;

@end
