//
//  NSBundle+Language.h
//  Baraa
//
//  Created by Sobhi Imad on 10/27/19.
//  Copyright © 2019 sobhi imad. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef USE_ON_FLY_LOCALIZATION

@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end

#endif
