//
//  LanguageManager.h
//  Baraa
//
//  Created by Sobhi Imad on 10/27/19.
//  Copyright © 2019 sobhi imad. All rights reserved.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ELanguage)
{
    ELanguageEnglish,
    ELanguageGerman,
    ELanguageFrench,
    ELanguageArabic,    
    ELanguageCount
};

@interface LanguageManager : NSObject

+ (void)setupCurrentLanguage;
+ (NSArray *)languageStrings;
+ (NSString *)currentLanguageString;
+ (NSString *)currentLanguageCode;
+ (NSInteger)currentLanguageIndex;
+ (void)saveLanguageByIndex:(NSInteger)index;
+ (BOOL)isCurrentLanguageRTL;
@end
