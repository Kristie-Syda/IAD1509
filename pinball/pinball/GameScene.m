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

@interface GameScene()

//Variables
{
    SKSpriteNode *ball;
    SKSpriteNode *plunger;
    SKSpriteNode *leftBump;
    SKSpriteNode *rightBump;
    SKSpriteNode *pauseButton;
    SKSpriteNode *playBtn;
    SKLabelNode *pauseLbl;
    SKLabelNode *scoreLabel;
    SKNode *touched;
    NSString *plungBall;
    SKAction *springs;
    SKAction *bumpers;
    SKAction *released;
    SKAction *edge;
    SKAction *flippedLeft;
    SKAction *flippedRight;
    SKAction *movingTarget;
    SKAction *keepFlashing;
    CGFloat plungerPressed;
    CGFloat plungerReleased;
    NSTimeInterval current;
    NSTimeInterval previous;
    SKLabelNode *score;
    SKLabelNode *ballLabel;
    int lvl;

    BOOL gameOver;
    BOOL nextLevel;
}

@end

static const uint32_t ballCat = 0x1;
static const uint32_t pinkCat = 0x1 << 1;
static const uint32_t worldCat = 0x1 << 2;
static const uint32_t bounceCat = 0x1 << 3;
static const uint32_t bottomCat = 0x1 << 4;


@implementation GameScene


//ball
- (void)addBall {
    
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
    ball.anchorPoint = CGPointMake(0.5, 0.5);
    ball.position = CGPointMake(self.size.width - 18, 200);
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
    ball.physicsBody.dynamic = YES;
    ball.physicsBody.categoryBitMask = ballCat;
    ball.physicsBody.contactTestBitMask = pinkCat|worldCat|bounceCat|bottomCat;
    ball.physicsBody.collisionBitMask = worldCat|pinkCat|bounceCat;
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

//adding score
-(void)addScore {
    
    //Score label
    score = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypewriter"];
    score.fontColor = [SKColor whiteColor];
    score.text = @"0";
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
    ballLabel.text = @"3";
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

//pause
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

//pause Label
-(void)pauseLabel {
    
    pauseLbl = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    pauseLbl.text = @"Game Paused";
    pauseLbl.fontColor = [SKColor whiteColor];
    pauseLbl.position = CGPointMake(self.size.width/2, self.size.height/3);
    pauseLbl.fontSize = 25;
  
    [self addChild:pauseLbl];
}

//pause game
-(void)pauseGame {
    
    self.paused = !self.scene.paused;
    
    if (self.scene.paused == YES) {
        [self pauseLabel];
        [pauseButton removeFromParent];
        [self addChild:playBtn];
        
    } else if (self.scene.paused == NO) {
        [pauseLbl removeFromParent];
        [playBtn removeFromParent];
        [self addChild:pauseButton];
    }
}

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
    
    //save level number to user defaults
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setInteger:lvl forKey:@"passed"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //load in game scene with next level
    SKTransition *close= [SKTransition doorsCloseHorizontalWithDuration:2];
    GameScene *scene = [[GameScene alloc]initWithSize:self.size level:nextlvl];
    [self.view presentScene:scene transition:close];
}

-(void)levelLabel {
    
    SKLabelNode *lvlLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    lvlLabel.text = [NSString stringWithFormat: @"Level: %i",lvl];
    lvlLabel.fontColor = [SKColor whiteColor];
    lvlLabel.position = CGPointMake(self.size.width/2 - 20, self.size.height/3 - 140);
    lvlLabel.fontSize = 25;
    
    [self addChild:lvlLabel];
}

//All SKActions
-(void)actions {
    
    //Sound Effects
    springs = [SKAction playSoundFileNamed:@"spring.caf" waitForCompletion:NO];
    bumpers = [SKAction playSoundFileNamed:@"bumpers.caf" waitForCompletion:NO];
    edge = [SKAction playSoundFileNamed:@"edge.caf" waitForCompletion:NO];
    released = [SKAction playSoundFileNamed:@"released.caf" waitForCompletion:NO];
    
    //flipper SKActions
    SKAction *Left = [SKAction rotateByAngle:1.2 duration:0.2];
    SKAction *Right = [SKAction rotateByAngle:-1.2 duration:0.2];
    NSArray *flipLeft = @[Left,Right];
    NSArray *flipRight = @[Right,Left];
    flippedLeft = [SKAction sequence:flipLeft];
    flippedRight = [SKAction sequence:flipRight];
    
    //Label SKAction
    SKAction *flashText = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.3],[SKAction waitForDuration:0.3],[SKAction fadeInWithDuration:0.3]]];
    keepFlashing = [SKAction repeatAction:flashText count:5];
}

//create pink bricks
-(PinkBricks *)addBricks:(CGPoint)position {
    
    PinkBricks *bricks = [PinkBricks node];
    
    SKSpriteNode *pink = [SKSpriteNode spriteNodeWithImageNamed:@"hotPink.png"];
    pink.name = @"child_pink";
    
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

//init
-(id)initWithSize:(CGSize)size level:(NSString*)lvlNum {
    if (self = [super initWithSize:size]) {
        
        //background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:size];
        background.anchorPoint = CGPointMake(0, 0);

        gameOver = NO;
        nextLevel = NO;
        lvl = [lvlNum intValue];
        
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
        [self addBall];
        [self addScore];
        [self ballLabel];
        [self actions];
        [self addPause];
        [self levelLabel];
    
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
            CGFloat x = [info[@"x"] floatValue];
            CGFloat y = [info[@"y"] floatValue];
            NSString *type = info[@"type"];
            
            //add bouncers to scene
            Bouncer *bouncer = [self createBouncer:type position:CGPointMake(x, y)];
            [self addChild:bouncer];
        }
        
        //grab the pink brick info from plist
        NSArray *brickArray = data[@"PinkBricks"];
        for (NSDictionary *info in brickArray) {
            CGFloat x = [info[@"x"] floatValue];
            CGFloat y = [info[@"y"] floatValue];
            
            //add bricks to scene
            PinkBricks *brick = [self addBricks:CGPointMake(x, y)];
            [self addChild:brick];
        }
    }
    return self;
}

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
            }
            
            //game is paused
        } else if (self.scene.paused == YES) {
            
            //play button is pressed unpause game
            if ([touched.name isEqualToString:@"play"]) {
                [self pauseGame];
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
   
    SKPhysicsBody *importantContact;
    
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
        [self addBall];
    }
    
    if(update) {
        //updates score
        score.text = [NSString stringWithFormat:@"%i",[Score shared].currentScore];
        
        //if out of balls -- game over
        if ([Score shared].ball == 0) {
            
            //game over Label shows
            [self addEndLabel];
            
            //changes label to show total score and flashes
            score.text = [NSString stringWithFormat:@"%i", [Score shared].totalScore];
            scoreLabel.text = @"Total Score";
            [score runAction:keepFlashing];
            [scoreLabel runAction:keepFlashing];
            gameOver = YES;
            
        } else if([Score shared].pinkCount == 0) {
            nextLevel = YES;
           [self next];
        }        
    }
}

//update
-(void)update:(CFTimeInterval)currentTime {
    
    //interpolation??
    if (previous == 0) {
        current = 0;
    } else {
        current = ((currentTime - previous) * 60);
    }
    previous = currentTime;
    
    
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
