//
//  TableMaker.m
//  pinball
//
//  Created by Kristie Syda on 8/24/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "TableMaker.h"
#import "PinkBricks.h"
#import "Bouncer.h"
#import "Target.h"
#import "BottomNode.h"
#import "GameScene.h"


static const uint32_t pinkCat = 0x1 << 1;
static const uint32_t bounceCat = 0x1 << 3;
static const uint32_t targetCat = 0x1 << 4;
static const uint32_t bottomCat = 0x1 << 5;

@implementation TableMaker
@synthesize plunger,RFlipper,LFlipper;


////plunger
-(SKSpriteNode *)addPlunger {
    
    SKSpriteNode *plungerNode = [SKSpriteNode spriteNodeWithImageNamed:@"plunger.png"];
    plungerNode.anchorPoint = CGPointMake(0.5,0.5);
    plungerNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(plungerNode.size.width, plungerNode.size.height)];
    plungerNode.physicsBody.dynamic = NO;
    plungerNode.name = @"plunger";
    plungerNode.physicsBody.restitution = 1;
    plungerNode.position = CGPointMake(375 - 16, 80);
   
    self.plunger = plungerNode;
    
    return plungerNode;
}

//Bottom Right sprite
-(SKSpriteNode *)addBotRight{
    
    SKSpriteNode *right = [SKSpriteNode spriteNodeWithImageNamed:@"botRight.png"];
    
    /////**From Generator
    CGFloat offsetX = right.frame.size.width * right.anchorPoint.x;
    CGFloat offsetY = right.frame.size.height * right.anchorPoint.y;
    CGMutablePathRef path = CGPathCreateMutable();

    //creates custom polygon physics body
    CGPathMoveToPoint(path, NULL, 96 - offsetX, 199 - offsetY);
    CGPathAddLineToPoint(path, NULL, 119 - offsetX, 199 - offsetY);
    CGPathAddLineToPoint(path, NULL, 119 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 1 - offsetX, 59 - offsetY);
    CGPathCloseSubpath(path); ////**
    
    //Physics
    right.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    right.anchorPoint = CGPointMake(0.5, 0.5);
    right.physicsBody.dynamic = NO;
    right.name = @"right";
    right.position = CGPointMake(375 - 16 - 80, 80);
    
    return right;
}

//Bottom Left Sprite
-(SKSpriteNode *)addBotLeft{
    
    SKSpriteNode *left = [SKSpriteNode spriteNodeWithImageNamed:@"botLeft.png"];
    
    /////**From Generator
    CGFloat offsetX = left.frame.size.width * left.anchorPoint.x;
    CGFloat offsetY = left.frame.size.height * left.anchorPoint.y;
    CGMutablePathRef path = CGPathCreateMutable();
    
    //creates custom polygon physics body
    CGPathMoveToPoint(path, NULL, 0 - offsetX, 199 - offsetY);
    CGPathAddLineToPoint(path, NULL, 22 - offsetX, 199 - offsetY);
    CGPathAddLineToPoint(path, NULL, 118 - offsetX, 55 - offsetY);
    CGPathAddLineToPoint(path, NULL, 119 - offsetX, 1 - offsetY);
    CGPathAddLineToPoint(path, NULL, 0 - offsetX, 1 - offsetY);
    CGPathCloseSubpath(path); ////**
    
    //physics
    left.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    left.anchorPoint = CGPointMake(0.5, 0.5);
    left.physicsBody.dynamic = NO;
    left.name = @"left";
    left.position = CGPointMake(50, 80);
    
    return left;
}

//Left Flipper
-(SKSpriteNode *)addLeftBumper{
    SKSpriteNode *leftBump = [SKSpriteNode spriteNodeWithImageNamed:@"leftBumper.png"];
    
    /////**From Generator
    CGFloat offsetX = leftBump.frame.size.width * 0;
    CGFloat offsetY = leftBump.frame.size.height * 0.5;
    CGMutablePathRef path = CGPathCreateMutable();
    

        
    //I just counted the flippers as polygons to use generator
    CGPathMoveToPoint(path, NULL, 83 - offsetX, 3 - offsetY);
    CGPathAddLineToPoint(path, NULL, 87 - offsetX, 5 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 49 - offsetY);
    CGPathAddLineToPoint(path, NULL, 7 - offsetX, 49 - offsetY);
    CGPathAddLineToPoint(path, NULL, 3 - offsetX, 41 - offsetY);
    CGPathAddLineToPoint(path, NULL, 5 - offsetX, 34 - offsetY);
    CGPathCloseSubpath(path); /////**
        

    //physics
    leftBump.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    leftBump.anchorPoint = CGPointMake(0, 0.5);
    leftBump.physicsBody.dynamic = NO;
    leftBump.name = @"left";
    leftBump.physicsBody.restitution = 3.0;
    leftBump.position = CGPointMake(375/3 - 60, 150);
    
    self.LFlipper = leftBump;
    
    return leftBump;
}

//Right Flipper
-(SKSpriteNode *)addRightBumper{
    
    SKSpriteNode *rightBump = [SKSpriteNode spriteNodeWithImageNamed:@"rightBumper.png"];
    
    ///////**From generator
    CGFloat offsetX = rightBump.frame.size.width * 1;
    CGFloat offsetY = rightBump.frame.size.height * 0.5;
    CGMutablePathRef path = CGPathCreateMutable();
    
    //I just counted the flippers as polygons to use generator
    CGPathMoveToPoint(path, NULL, 76 - offsetX, 49 - offsetY);
    CGPathAddLineToPoint(path, NULL, 80 - offsetX, 49 - offsetY);
    CGPathAddLineToPoint(path, NULL, 86 - offsetX, 44 - offsetY);
    CGPathAddLineToPoint(path, NULL, 86 - offsetX, 38 - offsetY);
    CGPathAddLineToPoint(path, NULL, 4 - offsetX, 4 - offsetY);
    CGPathAddLineToPoint(path, NULL, 2 - offsetX, 7 - offsetY);
    CGPathCloseSubpath(path); ////**
    
    //physics
    rightBump.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    rightBump.anchorPoint = CGPointMake(1, 0.5);
    rightBump.physicsBody.dynamic = NO;
    rightBump.name = @"right";
    rightBump.physicsBody.restitution = 3.0;
    rightBump.position = CGPointMake(375/3 - 60 + (rightBump.size.width * 2) + 20, 150);
    
    self.RFlipper = rightBump;
    
    return rightBump;
}

//Top
-(SKNode *)addTop{
    
    //adding a top invisible boundary
    SKNode *top = [SKNode node];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    /////**From Generator
    CGFloat offsetX = 374* 0.5;
    CGFloat offsetY = 160 * 0.5;
        
    CGPathMoveToPoint(path, NULL, 0 - offsetX, 167 - offsetY);
    CGPathAddLineToPoint(path, NULL, 372 - offsetX, 168 - offsetY);
    CGPathAddLineToPoint(path, NULL, 373 - offsetX, 1 - offsetY);
    CGPathAddLineToPoint(path, NULL, 265 - offsetX, 84 - offsetY);
    CGPathAddLineToPoint(path, NULL, 0 - offsetX, 84 - offsetY);
    CGPathCloseSubpath(path);//////***
    
    //physics
    top.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    top.position = CGPointMake(188, 667-80);
    top.physicsBody.dynamic = NO;
    
    return top;
}

//bottom
-(BottomNode *)addBottom{
    //Makes invisible Line on the bottom
    BottomNode *bottomNode = [BottomNode node];
    
    CGPoint A = CGPointMake(0, 30);
    CGPoint B = CGPointMake(375 - 100, 30);

    bottomNode.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:A toPoint:B];
    bottomNode.physicsBody.dynamic = NO;
    bottomNode.name = @"bottom";
    bottomNode.physicsBody.friction = 5.0f;
    bottomNode.physicsBody.categoryBitMask = bottomCat;
    
    return bottomNode;
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
-(Bouncer *)createBouncer:(Type)type {
    
    Bouncer *bouncerNode = [Bouncer node];
    [bouncerNode setType:type];

    SKSpriteNode *bouncer;
    CGPoint pos;
    
    if (type == Bouncer_1) {
            
        bouncer = [SKSpriteNode spriteNodeWithImageNamed:@"bouncer.png"];
        pos = CGPointMake(375/2 + 25, 667/2);
            
            
    } else if (type == Bouncer_2){
            
        bouncer = [SKSpriteNode spriteNodeWithImageNamed:@"bouncer1.png"];
        pos = CGPointMake(65, 667/3 + 70);
            
    } else if (type == Bouncer_3){
            
        bouncer = [SKSpriteNode spriteNodeWithImageNamed:@"bouncer3.png"];
        pos = CGPointMake(65, 667 - 245);
            
    }
        
        bouncer.size = CGSizeMake(60, 60);
        bouncer.name = @"child_bouncer";
    
    [bouncerNode addChild:bouncer];
    [bouncerNode setPosition:pos];
    bouncerNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bouncer.size.width/2];
    bouncerNode.physicsBody.dynamic = NO;
    bouncerNode.physicsBody.restitution = 0.2;
    bouncerNode.physicsBody.categoryBitMask = bounceCat;
    
    return bouncerNode;
}

//target
-(Target *)addTarget {
    
    Target *targetNode = [Target node];
    
    SKSpriteNode *targetSprite = [SKSpriteNode spriteNodeWithImageNamed:@"target.png"];
    targetSprite.anchorPoint = CGPointMake(0.5, 0.5);
    targetSprite.size = CGSizeMake(40, 40);
    
    [targetNode addChild:targetSprite];
    targetNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:targetSprite.size.width/2];
    targetNode.physicsBody.dynamic = NO;
    targetNode.physicsBody.categoryBitMask = targetCat;
    targetNode.position = CGPointMake(40, 490);
    
    return targetNode;
}

//method is used in subclasses
- (BOOL)collision:(SKNode *)ball{
    return NO;
}


//Create Table
-(SKNode *)createTable {
    
    SKNode *table = [SKNode node];
    [table setName:@"table"];
    
    PinkBricks *pink1;
    PinkBricks *pink2;
    PinkBricks *pink3;
    PinkBricks *pink4;
    
    SKSpriteNode *frame;
    frame = [SKSpriteNode spriteNodeWithImageNamed:@"frame.png"];
    frame.position = CGPointMake(375 - 16, 80);
        
    // create the bricks
    pink1 = [self addBricks:CGPointMake(30, 550)];
    pink2 = [self addBricks:CGPointMake(90, 550)];
    pink3 = [self addBricks:CGPointMake(150, 550)];
    pink4 = [self addBricks:CGPointMake(210, 550)];
    
    //create bouncers
    Bouncer *b1 = [self createBouncer:Bouncer_1];
    Bouncer *b2 = [self createBouncer:Bouncer_2];
    Bouncer *b3 = [self createBouncer:Bouncer_3];
    
    //add everything to table
    [table addChild:frame];
    [table addChild:[self addPlunger]];
    [table addChild:[self addBotRight]];
    [table addChild:[self addBotLeft]];
    [table addChild:[self addTop]];
    [table addChild:[self addBottom]];
    [table addChild:[self addLeftBumper]];
    [table addChild:[self addRightBumper]];
    [table addChild:[self addTarget]];
    [table addChild:pink1];
    [table addChild:pink2];
    [table addChild:pink3];
    [table addChild:pink4];
    [table addChild:b1];
    [table addChild:b2];
    [table addChild:b3];
    
    
    return table;
}


@end
