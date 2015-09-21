//
//  GameScene.m
//  pinball
//
//  Created by Kristie Syda on 8/3/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//
//IAD

#import "GameScene.h"
#import "Score.h"
#import "GameOver.h"
#import "TableMaker.h"
#import "PinkBricks.h"
#import "Bouncer.h"
#import "Levels.h"
#import "Menu.h"
#import "Achieve.h"
#import <Parse/Parse.h>

static const uint32_t ballCat = 0x1;
static const uint32_t pinkCat = 0x1 << 1;
static const uint32_t worldCat = 0x1 << 2;
static const uint32_t bounceCat = 0x1 << 3;
static const uint32_t bottomCat = 0x1 << 4;
static const uint32_t rightFlip = 0x1 << 5;
static const uint32_t leftFlip = 0x1 << 6;


@implementation GameScene

#pragma mark - Table sprites
//ball
- (void)addBall {
    
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
    ball.anchorPoint = CGPointMake(0.5, 0.5);
    ball.position = CGPointMake(self.size.width - 18, 160);
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
    ball.physicsBody.dynamic = YES;
    ball.physicsBody.categoryBitMask = ballCat;
    ball.physicsBody.contactTestBitMask = pinkCat|worldCat|bounceCat|bottomCat|rightFlip|leftFlip;
    ball.physicsBody.collisionBitMask = worldCat|pinkCat|bounceCat|rightFlip|leftFlip;
    ball.physicsBody.friction = 0.0;
    ball.physicsBody.restitution = 0.5;
    ball.name = @"ball";
    
    [self addChild:ball];
}
//add top
-(void)addTop{
    
    SKSpriteNode *topImg = [SKSpriteNode spriteNodeWithImageNamed:@"top.png"];
    topImg.position = CGPointMake(188, 667-42);
    
    CGPoint A = CGPointMake(-25, 20);
    CGPoint B = CGPointMake(50, -50);
    
    SKSpriteNode *topCurve = [SKSpriteNode spriteNodeWithImageNamed:@"deflectorTop.png"];
    topCurve.position = CGPointMake(350, 667-105);
    topCurve.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:A toPoint:B];

    [self addChild:topImg];
    [self addChild:topCurve];
}
//gate
-(void)addGate{
    
    gateImg = [SKSpriteNode spriteNodeWithImageNamed:@"gate.png"];
    gateImg.position = CGPointMake(480, 218);
    
    CGPoint A = CGPointMake(60, gateImg.size.height);
    CGPoint B = CGPointMake(-35, -40);
    gateImg.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:A toPoint:B];
    
    [self addChild:gateImg];
}
//key image
-(void)keyImg {
    
    key = [SKSpriteNode spriteNodeWithImageNamed:@"key.png"];
    key.name = @"key";
    
    key.position = CGPointMake(self.size.width/2 - 20, self.size.height - 50);
    
    [self addChild:key];
}
//create pink + purple bricks
-(PinkBricks *)addBricks:(NSString*)type pos:(CGPoint)position {
    
    PinkBricks *bricks = [PinkBricks node];
    
    SKSpriteNode *pink;
    pink.name = @"child_pink";
    
    if ([type isEqualToString:@"pink"]) {
        
        pink = [SKSpriteNode spriteNodeWithImageNamed:@"hotPink.png"];
        
    } else {
        
        pink = [SKSpriteNode spriteNodeWithImageNamed:@"purple.png"];
        
    }
    
    [bricks addChild:pink];
    
    bricks.position = position;
    bricks.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pink.size];
    bricks.physicsBody.dynamic = NO;
    bricks.physicsBody.categoryBitMask = pinkCat;
    
    return bricks;
}
//create bouncers
-(Bouncer *)createBouncer:(NSString *)type position:(CGPoint)pos {
    
    Bouncer *bouncerNode = [Bouncer node];
    
    
    SKSpriteNode *bouncer;
    
    
    if ([type isEqualToString:@"bouncer1"]) {
        
        bouncer = [SKSpriteNode spriteNodeWithImageNamed:@"bouncer.png"];
        
    } else if ([type isEqualToString:@"bouncer2"]){
        
        bouncer = [SKSpriteNode spriteNodeWithImageNamed:@"bouncer1.png"];
        
    } else if ([type isEqualToString:@"bouncer3"]){
        
        bouncer = [SKSpriteNode spriteNodeWithImageNamed:@"bouncer3.png"];
        
    }
    
    bouncer.size = CGSizeMake(40, 40);
    bouncer.name = @"child_bouncer";
    
    [bouncerNode addChild:bouncer];
    [bouncerNode setPosition:pos];
    bouncerNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bouncer.size.width/2];
    bouncerNode.physicsBody.dynamic = NO;
    bouncerNode.physicsBody.restitution = 1;
    bouncerNode.physicsBody.categoryBitMask = bounceCat;
    
    return bouncerNode;
}

#pragma mark - Table Labels
//adding score + scorelabel
-(void)addScore {
    
    //Score label
    score = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];
    score.fontColor = [SKColor whiteColor];
    score.text = [NSString stringWithFormat:@"%i",[Score shared].currentScore];
    score.position = CGPointMake(self.size.width/2, self.size.height-65);
    
    //score title label
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    scoreLabel.fontColor = [SKColor whiteColor];
    scoreLabel.text = @"Score";
    scoreLabel.position = CGPointMake(self.size.width/2, score.position.y + 35);
    scoreLabel.fontSize = 21;
    
    [self addChild:score];
    [self addChild:scoreLabel];
}
//ball count
-(void)ballLabel {
    
    ballLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    ballLabel.fontColor = [SKColor whiteColor];
    ballLabel.text = [NSString stringWithFormat:@"%i",[Score shared].ball];
    ballLabel.position = CGPointMake(self.size.width/3 - 90, self.size.height-65);
    
    SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    titleLabel.fontColor = [SKColor whiteColor];
    titleLabel.text = @"Balls";
    titleLabel.position = CGPointMake(self.size.width/3 - 90, ballLabel.position.y + 35);
    titleLabel.fontSize = 21;
    titleLabel.position = CGPointMake(self.size.width/3 - 90, ballLabel.position.y + 35);
    titleLabel.fontSize = 21;
    
    [self addChild:ballLabel];
    [self addChild:titleLabel];
}
//level label
-(void)levelLabel {
    SKLabelNode *lvlLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    lvlLabel.text = [NSString stringWithFormat: @"Level: %i",lvl];
    lvlLabel.fontColor = [SKColor whiteColor];
    lvlLabel.position = CGPointMake(self.size.width/2 - 20, self.size.height/3 - 140);
    lvlLabel.fontSize = 25;
    [self addChild:lvlLabel];
}

#pragma mark - Pause
//pause button
-(void)addPause {
    
    pauseButton = [SKSpriteNode spriteNodeWithImageNamed:@"pause.png"];
    pauseButton.name = @"pause";
    pauseButton.position = CGPointMake(self.size.width - 45, self.size.height - 40);
    
    //initialize play btn -- but not add it yet
    playBtn = [SKSpriteNode spriteNodeWithImageNamed:@"play.png"];
    playBtn.name = @"play";
    playBtn.position = CGPointMake(self.size.width - 45, self.size.height - 40);
    
    [self addChild:pauseButton];
}
//pause game
-(void)pauseGame {
    
    self.paused = !self.scene.paused;
    
    if (self.scene.paused == YES) {
        [self addMenu];
        [pauseButton removeFromParent];
        [self addChild:playBtn];
        
    } else if (self.scene.paused == NO) {
        [menuNode removeFromParent];
        [playBtn removeFromParent];
        [self addChild:pauseButton];
    }
}
//Pause menu
-(void)addMenu {
    
    menuNode = [SKNode node];
    menuNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    SKSpriteNode *menuImg = [SKSpriteNode spriteNodeWithImageNamed:@"pauseMenu.png"];
    
    SKSpriteNode *resume = [SKSpriteNode spriteNodeWithImageNamed:@"resume.png"];
    resume.position = CGPointMake(0, 20);
    resume.name = @"resume";
    
    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithImageNamed:@"menuBtn.png"];
    menu.name = @"menu";
    menu.position = CGPointMake(0, -50);
    
    [menuNode addChild:menuImg];
    [menuNode addChild:resume];
    [menuNode addChild:menu];
    [self addChild:menuNode];
}

#pragma mark - Game Over
//gameOver Label
-(void)addEndLabel {
    
    SKLabelNode *endLbl = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    endLbl.text = @"Game Over";
    endLbl.fontColor = [SKColor whiteColor];
    endLbl.position = CGPointMake(self.size.width/2, self.size.height/3);
    endLbl.fontSize = 25;
    
    [self addChild:endLbl];
}
//Game OVer
-(void)gameOver {

    SKTransition *close= [SKTransition doorsCloseHorizontalWithDuration:2];
    GameOver *scene = [GameOver sceneWithSize:self.size];
    [self.view presentScene:scene transition:close];
    [[Score shared]reset];
}
//next Level
-(void)next {
    
    NSString *nextlvl = [NSString stringWithFormat:@"%i", lvl + 1];
    NSNumber *lvlNumber = [NSNumber numberWithInt:lvl];
    NSNumber *previousLevel;
    
    PFUser *user = [PFUser currentUser];
    
    //if not a user than save level to NSDefaults -- If level is higher than last level
    if (!user) {
        
        NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
        previousLevel = [NSNumber numberWithInteger:[data integerForKey:@"passed"]];
        
        if (previousLevel < lvlNumber) {
            
            //save level number to user defaults
            NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
            [data setInteger:lvl forKey:@"passed"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        } else {
            //do nothing
        }
        
    }
    
    //if next level is 11 got to menu bc there is no level 11
    if ([nextlvl isEqualToString:@"11"]) {
        
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        [self.view presentScene:scene transition:reveal];
        [[Score shared]reset];
        
    } else {
        
        //load in game scene with next level
        SKTransition *close= [SKTransition doorsCloseHorizontalWithDuration:2];
        GameScene *scene = [[GameScene alloc]initWithSize:self.size level:nextlvl];
        [self.view presentScene:scene transition:close];
    }
}

#pragma mark - Scene Setup
//All SKActions
-(void)actions {
    
    //Sound Effects
    springs = [SKAction playSoundFileNamed:@"spring.caf" waitForCompletion:NO];
    bumpers = [SKAction playSoundFileNamed:@"bumpers.caf" waitForCompletion:NO];
    edge = [SKAction playSoundFileNamed:@"edge.caf" waitForCompletion:NO];
    released = [SKAction playSoundFileNamed:@"released.caf" waitForCompletion:NO];
    done = [SKAction playSoundFileNamed:@"target.caf" waitForCompletion:NO];
    
    //flipper SKActions
    SKAction *Left = [SKAction rotateByAngle:1.2 duration:0.2];
    SKAction *Right = [SKAction rotateByAngle:-1.2 duration:0.2];
    SKAction *ballHit = [SKAction runBlock:^{
        if (ballTouch == YES) {
            
            [ball.physicsBody applyImpulse:CGVectorMake(0, 10)];
            ballTouch = NO;
        }
    }];
    
    NSArray *flipLeft = @[Left,ballHit,Right];
    NSArray *flipRight = @[Right,ballHit,Left];
    flippedLeft = [SKAction sequence:flipLeft];
    flippedRight = [SKAction sequence:flipRight];
    
    //Label SKAction
    SKAction *flashText = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.3],[SKAction waitForDuration:0.3],[SKAction fadeInWithDuration:0.3]]];
    keepFlashing = [SKAction repeatAction:flashText count:5];
    
    //key image dropping from the top to the bottom
    keyDrop = [SKAction moveTo:CGPointMake(self.size.width/2 - 20, self.size.height/3 - 40) duration:2];
    
    //gate action
    gateDrop = [SKAction moveTo:CGPointMake(348, 218) duration:0.5];
    openGate = [SKAction moveTo:CGPointMake(480, 218) duration:0.5];
}
//init
-(id)initWithSize:(CGSize)size level:(NSString*)lvlNum {
    if (self = [super initWithSize:size]) {
        
        //background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:size];
        background.anchorPoint = CGPointMake(0, 0);
        
        //reset game
        gameOver = NO;
        nextLevel = NO;
        lvl = [lvlNum intValue];
        [Score shared].currentLevel = lvl;
        
        //if first level get 3 balls
        if (lvl == 1) {
            [Score shared].ball = 3;
        }
        
        //physics of the world
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = worldCat;
        self.physicsBody.restitution = 0.1;
        self.physicsWorld.gravity = CGVectorMake(0,-1);
        self.physicsWorld.contactDelegate = self;
        
        //create the table
        TableMaker *table = [[TableMaker alloc]init];
        SKNode *tableNode = [table createTable];
       
        [self addChild:background];
        [self addTop];
        [self addChild:tableNode];
        [self levelLabel];
        [self addBall];
        [self addScore];
        [self ballLabel];
        [self actions];
        [self addPause];
        [self addGate];
        
        //had to connect by properties so I could use in touches
        rightBump = table.RFlipper;
        leftBump = table.LFlipper;
        plunger = table.plunger;
        
        //After table is set up.....load in plist level
        NSString *pList = [[NSBundle mainBundle] pathForResource:lvlNum ofType:@"plist"];
        
        //make a dictionary of all the contents in the plist
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:pList];
        
        //store the brick count
        [Score shared].pinkCount = [data[@"brickCount"]intValue];
        
        //grab the bouncer array information
        NSArray *bouncerArray = data[@"Bouncers"];
        for (NSDictionary *info in bouncerArray) {
             NSString *type = info[@"type"];
             CGFloat x = [info[@"x"] floatValue];
             CGFloat y = [info[@"y"] floatValue];
            
            //add bouncers to scene
            Bouncer *bouncer = [self createBouncer:type position:CGPointMake(x, y)];
            [self addChild:bouncer];
        }
        
        //grab the pink brick info from plist
        NSArray *brickArray = data[@"PinkBricks"];
        for (NSDictionary *info in brickArray) {
             NSString *type = info[@"type"];
             CGFloat x = [info[@"x"] floatValue];
             CGFloat y = [info[@"y"] floatValue];
  
            //add bricks to scene
            PinkBricks *brick = [self addBricks:type pos:CGPointMake(x, y)];
            [self addChild:brick];
        }
    }
    return self;
}

#pragma mark - Scene Methods
//touches begin
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    touched = [self nodeAtPoint:location];

    //game is not over
    if (gameOver == NO){
        
        //game is not paused
        if (self.scene.paused == NO) {
            
            //plunger is touched
            if ([touched.name isEqualToString:@"plunger"]) {
                
                plungBall = @"pressed";
                [self runAction:springs];
                
            //left flipper is touched
            } else if ([touched.name isEqualToString:@"left"]){
                
                [self runAction:bumpers];
                [leftBump runAction:flippedLeft];
                
            //right flipper is touched
            } else if([touched.name isEqualToString:@"right"]){
                
                [self runAction:bumpers];
                [rightBump runAction:flippedRight];
                
            //pause button
            } else if ([touched.name isEqualToString:@"pause"]){
                
                [self pauseGame];
             
            //key is touched
            } else if ([touched.name isEqualToString:@"key"]){
                
                [self next];
            }
            
        //game is paused
        } else if (self.scene.paused == YES) {
            
            //play button is pressed unpause game
            if ([touched.name isEqualToString:@"play"] ^ [touched.name isEqualToString:@"resume"]) {
                
                [self pauseGame];
            
            //menu button is pressed
            } else if ([touched.name isEqualToString:@"menu"]) {
                
                Menu *scene = [Menu sceneWithSize:self.size];
                
                SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
                
                [self.view presentScene:scene transition:reveal];
                [[Score shared]reset];
            }
        }
    
    //The game is over
    } else if(gameOver == YES) {
    
        [self gameOver];
    }
}
//touches ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //plunger was released
    if ([touched.name isEqualToString:@"plunger"]) {
        
         plungBall = @"notPressed";
         plunger.size = CGSizeMake(plunger.frame.size.width, 150);
         
        //speed plunger needs to go in air
         [ball.physicsBody applyImpulse:CGVectorMake(0, plungerReleased)];
        
        //if plunger is low enough make plunging sound
        if (plungerReleased > 15){
            
            [self runAction:released];
            
        }
        //resets plunger
        plungerReleased = 0;
    }
}
//contacts
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    BOOL update = NO;
   
    //whatever contact that is not the ball is important
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        importantContact = contact.bodyB;
    } else {
        importantContact = contact.bodyA;
    }
    
    //ball hits pink brick
    if (importantContact.categoryBitMask == pinkCat ) {
        
        update = [(PinkBricks *)importantContact.node collision:ball];
        
    //ball hits bouncer
    } else if (importantContact.categoryBitMask == bounceCat ){
        
        update = [(Bouncer *)importantContact.node collision:ball];
        
    //ball hits wall
    } else if (importantContact.categoryBitMask == worldCat){
        
        [self runAction:edge];
       
    //ball hits bottom
    } else if (importantContact.categoryBitMask == bottomCat){
        
        [ball removeFromParent];
        update = [(TableMaker *)importantContact.node collision:ball];

        ballLabel.text = [NSString stringWithFormat:@"%i",[Score shared].ball];
        gateClose = NO;
        [gateImg runAction:openGate];
        [self addBall];
        
    //right flipper
    } else if (importantContact.categoryBitMask == rightFlip){
        
        ballTouch = YES;
        
    //left flipper
    } else if (importantContact.categoryBitMask == leftFlip){
        
        ballTouch = YES;
        
    } else {
        
        ballTouch = NO;
    }

    if(update) {
        //updates score
        score.text = [NSString stringWithFormat:@"%i",[Score shared].currentScore];
        
        //if out of balls -- game over
        if ([Score shared].ball == 0) {
            
            //game over Label shows
            [self addEndLabel];
            
            //removes ball
            [ball removeFromParent];
            
            //changes label to show total score and flashes
            score.text = [NSString stringWithFormat:@"%i", [Score shared].totalScore];
            scoreLabel.text = @"Total Score";
            [score runAction:keepFlashing];
            [scoreLabel runAction:keepFlashing];
            gameOver = YES;
        
        //when all bricks are gone
        } else if([Score shared].pinkCount == 0) {
            
            nextLevel = YES;
            
            //done sound effect
            [self runAction:done];

            //removes ball
            [ball removeFromParent];
            
            //adds key to scene
            [self keyImg];
            [key runAction:keyDrop];
        
        
        } else if([Score shared].currentScore == 1000) {
            
            [[Achieve shared]saveAch:@"ach2"];
        
        //if the ball is over 200 then close the gate
        } else if (ball.position.y > 250){
            
            //if gateClose is already true -- disregard this condition
            if (gateClose) return;
            
            gateClose = YES;
            [gateImg runAction:gateDrop];
        }
    }
}
//update
-(void)update:(CFTimeInterval)currentTime {
    //spring goes down on plunger
    if ([plungBall isEqualToString:@"pressed"]) {
        
        if (plunger.size.height > 50) {
            plunger.size = CGSizeMake(plunger.size.width, plunger.size.height - 0.8);
            plungerPressed = plungerReleased + 0.18;
            plungerReleased = plungerPressed;  
        }
        else {
            //plunger do nothing
        }
    }
}

@end
