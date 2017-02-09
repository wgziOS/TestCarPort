//
//  LoadImage.m
//  YzzYingyuan
//
//  Created by Ashes of time on 8/30/16.
//  Copyright © 2016 csq. All rights reserved.
//

#import "LoadImage.h"
#import "MHAsiNetworkUrl.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"

@implementation LoadImage

+(NSMutableURLRequest*)loadImageWithPost:(NSString*)urlString{
    
    return  [[self alloc]loadImageWithPost:urlString];
}
-(NSMutableURLRequest*)loadImageWithPost:(NSString*)urlString{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    NSString *bodyString = [NSString stringWithFormat:@"token=%@",APP_TOKEN];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    return request;
}
+(void)loadWithButton:(UIButton *)button andUrl:(NSString *)urlString{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    NSString *bodyString = [NSString stringWithFormat:@"token=%@",APP_TOKEN];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    __weak typeof(button) weakButton = button;
    
    [button setImageForState:UIControlStateNormal withURLRequest:request placeholderImage:[UIImage imageNamed:@"load_fail"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        if (!image) {
            
            [weakButton setBackgroundImage:[UIImage imageNamed:@"load_fail"] forState:UIControlStateNormal];
        }else{
            
            [weakButton setBackgroundImage:image forState:UIControlStateNormal];
        }
        
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"图片加载失败:%@",error);
        
    }];
}

+(void)loadWithImageView:(UIImageView *)imageView andUrl:(NSString *)urlString{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    NSString *bodyString = [NSString stringWithFormat:@"token=%@",APP_TOKEN];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    __weak typeof(imageView) weakView = imageView;
    [imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"load_fail"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  if (!image) {
                                      
                                      weakView.image =[UIImage imageNamed:@"load_fail"];
                                  }else{
                                      
                                      weakView.image=image;
                                  }
                                  
                                  
                                  NSLog(@"下载图片成功");
                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  NSLog(@"图片加载失败:%@",error);
                              }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"current Thread :%@",[NSThread currentThread]);//这里使用异步机制，肯定是非UI线程
//        
//        
//    });
}
@end
