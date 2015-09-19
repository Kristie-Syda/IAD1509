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
#import "BottomNode.h"
#import "GameScene.h"

static const uint32_t bottomCat = 0x1 << 4;
static const uint32_t rightFlip = 0x1 << 5;
static const uint32_t leftFlip = 0x1 << 6;

@implementation TableMaker
@synthesize plunger,RFlipper,LFlipper;

#pragma mark - Table Sprites

////plunger
-(SKSpriteNode *)addPlunger {
    
    SKSpriteNode *plungerNode = [SKSpriteNode spriteNodeWithImageNamed:@"plunger.png"];
    plungerNode.anchorPoint = CGPointMake(0.5,0.5);
    plungerNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(plungerNode.size.width, plungerNode.size.height)];
    plungerNode.physicsBody.dynamic = NO;
    plungerNode.name = @"plunger";
    plungerNode.physicsBody.restitution = 1;
    plungerNode.position = CGPointMake(375 - 16, 60);
   
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
    leftBump.physicsBody.restitution = 0.0;
    leftBump.position = CGPointMake(375/3 - 60, 150);
    leftBump.physicsBody.categoryBitMask = leftFlip;
    
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
    rightBump.physicsBody.restitution = 0.0;
    rightBump.position = CGPointMake(375/3 - 60 + (rightBump.size.width * 2) + 20, 150);
    rightBump.physicsBody.categoryBitMask = rightFlip;
    
    self.RFlipper = rightBump;
    
    return rightBump;
}

//Top
-(SKNode *)addTop{
    
    //adding a top invisible boundary
    SKNode *top = [SKNode node];
    
    //physics
    top.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(374, 87)];
    top.position = CGPointMake(188, 667-40);
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

#pragma mark - Create Table Method

//Create Table
-(SKNode *)createTable {
    
    SKNode *table = [SKNode node];
    [table setName:@"table"];
    
    SKSpriteNode *frame;
    frame = [SKSpriteNode spriteNodeWithImageNamed:@"frame.png"];
    frame.position = CGPointMake(375 - 16,60);

    //add everything to table
    [table addChild:frame];
    [table addChild:[self addPlunger]];
    [table addChild:[self addBotRight]];
    [table addChild:[self addBotLeft]];
    [table addChild:[self addTop]];
    [table addChild:[self addBottom]];
    [table addChild:[self addLeftBumper]];
    [table addChild:[self addRightBumper]];
    
    return table;
}

#pragma mark - Subclass Method

//method is used in subclasses
- (BOOL)collision:(SKNode *)ball{
    return NO;
}

@end
