//
//  PublishRentCarInfoCell.m
//  carport
//
//  Created by 吴桂钊 on 2017/2/14.
//  Copyright © 2017年 86gg.cn. All rights reserved.
//

#import "PublishRentCarInfoCell.h"

@implementation PublishRentCarInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //变数箱
    CGFloat y = self.boxLabel.frame.origin.y;
    NSArray * array = @[@"czfb-zdd-wxz",@"czfb-sdd-wxz"];
    NSArray * DJArray = @[@"czfb-zdd",@"czfb-sdd"];
    for (int i = 0; i<2; i++) {
        boxButton = [WGZToggleButton buttonWithOnImage:[UIImage imageNamed:DJArray[i]] offImage:[UIImage imageNamed:array[i]] highlightedImage:[UIImage imageNamed:array[i]]];
        boxButton.frame = CGRectMake(81+i*60, y, 50, 25);
        boxButton.tag = i+1;
        [boxButton addTarget:self action:@selector(boxButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:boxButton];
    }
    //配置
    CGFloat z = self.configurationLabel.frame.origin.y;
    NSArray * array1 = @[@"czfb-usbck-wxz",@"czfb-gpsdhxwxz"];
    NSArray * DJArray1 = @[@"czfb-usbck",@"czfb-gpsdhx"];
    for (int i = 0; i<2; i++) {
        configurationButton = [WGZToggleButton buttonWithOnImage:[UIImage imageNamed:DJArray1[i]] offImage:[UIImage imageNamed:array1[i]] highlightedImage:[UIImage imageNamed:array1[i]]];
        configurationButton.frame = CGRectMake(81+i*70, z, 60, 25);
        configurationButton.tag = i+3;
        [configurationButton addTarget:self action:@selector(configurationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:configurationButton];
    }
    
    //排量
    CGFloat x = self.displacementLabel.frame.origin.y;
    NSArray * array2 = @[@"czfb-1jyx-wxz",@"czfb-1z6-wxz",@"czfb-7z2-wxz",@"czfb-1z5-wxz",@"czfb-6z3-wxz",@"czfb-3ys-wxz"];
    NSArray * DJArray2 = @[@"czfb-1jyx",@"czfb-1z6",@"czfb-7z2",@"czfb-1z5",@"czfb-6z3",@"czfb-3ys"];
    for (int i = 0; i<6 ;i++) {
        displacementButton = [WGZToggleButton buttonWithOnImage:[UIImage imageNamed:DJArray2[i]] offImage:[UIImage imageNamed:array2[i]] highlightedImage:[UIImage imageNamed:array2[i]]];
        displacementButton.tag = i+5;
        if (i > 2) {
            displacementButton.frame = CGRectMake((i-3)*85+81, x+33, 75, 25);
        }else{
            displacementButton.frame = CGRectMake(81+i*85, x, 75, 25);
        }
        [displacementButton addTarget:self action:@selector(displacementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:displacementButton];
    }
    
    [self.seatCountTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.carSizeTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.plateNumTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.buyCarYearTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.kilometersTraveledTextfield addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.seatCountTextfield becomeFirstResponder];
//}

#pragma mark - private method
- (void)textfieldTextDidChange:(UITextField *)textField
{
    
    switch ([[NSString stringWithFormat:@"%ld",(long)textField.tag] intValue]) {
        case 101:
        {
            self.carSizeBlock(self.carSizeTextfield.text);
        }
            break;
        case 102:
        {
            self.plateNumBlock(self.plateNumTextfield.text);
        }
            break;
        case 103:
        {
            self.seatCountBlock(self.seatCountTextfield.text);
        }
            break;
        case 104:
        {
            self.buyCarYearBlock(self.buyCarYearTextfield.text);
        }
            break;
        case 105:
        {
            self.kmBlock(self.kilometersTraveledTextfield.text);
        }
            break;
            
        default:
            break;
    }
    
}
//排量
-(void)displacementButtonClick:(WGZToggleButton *)sender
{
    if (self.displacementBtnBlock) {
        
        WGZToggleButton * button = sender;
        NSInteger a  = sender.tag;
        _displacementValue = [NSString stringWithFormat:@"%ld",a-4];
        
        switch (button.tag) {
            case 5:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 6 || btn.tag == 7 || btn.tag == 8 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:YES];
                        }
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 6 || btn.tag == 7 || btn.tag == 8 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
            case 6:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 8 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:YES];
                        }
                        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 8 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
            case 7:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 6 || btn.tag == 8 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:YES];
                        }
                        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 6 || btn.tag == 8 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
            case 8:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 6 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:YES];
                        }
                        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 6 || btn.tag == 9 || btn.tag == 10)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
            case 9:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 8 || btn.tag == 6 || btn.tag == 10)
                        {
                            [btn setEnabled:YES];
                        }
                        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 8 || btn.tag == 6 || btn.tag == 10)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
            case 10:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 8 || btn.tag == 9 || btn.tag == 6)
                        {
                            [btn setEnabled:YES];
                        }
                        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 5 || btn.tag == 7 || btn.tag == 8 || btn.tag == 9 || btn.tag == 6)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
            default:
                break;
        }

        self.displacementBtnBlock();
    }
}
//配置
-(void)configurationButtonClick:(WGZToggleButton *)sender
{
    if (self.configurationBtnBlock) {
        
        WGZToggleButton * button = sender;
        NSInteger a  = sender.tag;
        _configurationValue = [NSString stringWithFormat:@"%ld",a-2];
   
        switch (button.tag) {
            case 3:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 4)
                        {
                            [btn setEnabled:YES];
                        }
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 4)
                        {
                            [btn setEnabled:NO];
                        }
    
                    }
                }
                
            }
                break;
            case 4:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 3)
                        {
                            [btn setEnabled:YES];
                        }
        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 3)
                        {
                            [btn setEnabled:NO];
                        }
               
                    }
                }
                
            }
                break;
           
            default:
                break;
        }

        
        self.configurationBtnBlock();
    }
}
//变数箱
-(void)boxButtonClick:(WGZToggleButton *)sender
{
    if (self.boxBtnBlock) {
        
        WGZToggleButton * button = sender;
        
        _boxValue = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        switch (button.tag) {
            case 1:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 2)
                        {
                            [btn setEnabled:YES];
                        }
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 2)
                        {
                            [btn setEnabled:NO];
                        }
                    }
                }
                
            }
                break;
            case 2:
            {
                if (button.on == NO) {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 1)
                        {
                            [btn setEnabled:YES];
                        }
                        
                    }
                }
                if (button.on == YES)
                {
                    for (WGZToggleButton * btn in self.subviews)
                    {
                        if (btn.tag == 1)
                        {
                            [btn setEnabled:NO];
                        }
                        
                    }
                }
                
            }
                break;
                
            default:
                break;
        }
        
        
        
        self.boxBtnBlock();
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
