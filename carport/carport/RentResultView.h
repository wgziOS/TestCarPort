//
//  RentResultView.h
//  carport
//
//  Created by 吴桂钊 on 2017/2/17.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MyEditorWidth 270.0f
#define MyEditorHeight 500.0f

@interface RentResultView : UIView
{
//    BOOL _leaveAlertView;
}

@property (nonatomic, strong) UILabel * title;               //标题
@property (nonatomic, strong) UILabel * subTitle;            //子标题
@property (nonatomic, strong) UIView  * backImageView;       //顶层模态视图，半透明视图


@property(nonatomic,strong) void (^goonBlock)();


-(id)initViewTitleImgString:(NSString *)titleImgString TitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString BtnImgString:(NSString *)btnImgString;

- (void)show;
@end
