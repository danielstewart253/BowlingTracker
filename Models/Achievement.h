//
//  Achievement.h
//  Bowlr
//
//  Created by Daniel Stewart on 12/9/14.
//  Copyright (c) 2014 Daniel Stewart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievement : NSObject <NSCoding>

//The title of the Achievement
@property(strong, nonatomic) NSString *title;

//The description for the Achievement
@property(strong, nonatomic) NSString *achievementDescription;

//The gameID for the specific Game that the Achievement occurred
@property(strong, nonatomic) NSNumber *gameID;

//BOOL flag indicates if the Achievement was earned in
//the current Game - Used to determine when an
//Achievement should be checked
@property BOOL achievementEarnedInCurrentGame;

//BOOL flag indicates if the Achievement was previously
//earned - Also used to determine when an Achievement
//should be check
@property BOOL achievementWasEarned;

//The date the Achievement was earned
@property NSString *dateEarned;

//The specific Frame number that the Achievement was earned
@property int frameNumberEarned;

- (instancetype)initWithTitle:(NSString *)title
                  description:(NSString *)description;

@end
