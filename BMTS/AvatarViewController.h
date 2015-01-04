//
//  AvatarViewController.h
//  BMTS
//
//  Created by JD Hatton on 1/4/15.
//  Copyright (c) 2015 Homeroom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePicture:(id)sender;

- (IBAction)selectPicture:(id)sender;

- (IBAction)saveSelection:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *GeneralAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *FemaleAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *GardnerAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *ShieldAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *FireFighterAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *SurferAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *StudentAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *GuruAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *CopAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *Cop2Avatar;

@property (weak, nonatomic) IBOutlet UIImageView *NurseAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *Nurse2Avatar;

@property (weak, nonatomic) IBOutlet UIImageView *ComposerAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *ModeratorAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *KingAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *Guru2Avatar;

@property (weak, nonatomic) IBOutlet UIImageView *AngelAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *GameAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *JokerAvatar;

@property (weak, nonatomic) IBOutlet UIImageView *SmileyAvatar;

@end
