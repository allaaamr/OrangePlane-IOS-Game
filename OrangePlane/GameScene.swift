//
//  GameScene.swift
//  OrangePlane
//
//  Created by Alaa Amr Abdelazeem on 26/08/2022.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum CollideType: UInt32 {
        case Bird = 1
        case Wall = 2
        case Gap = 4
    }
    
    override func didMove(to view: SKView) {
        // Set the contactDelegate property in order to monitor collision and contact
        self.physicsWorld.contactDelegate = self
        
        // Call methods to draw the setup of the scene
        drawBackground()
        drawPlane()
        drawObstacles()
        
        // Game started, Start Time
        let timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.fireTimer),
            userInfo: nil,
            repeats: true)
        
            
        // Call methods to draw the setup of the scene
        
        
    }
   
    func drawPlane(){
        //
    }
   
    func drawBackground(){
        let backgroundTexture = SKTexture(imageNamed: "back.jpeg")
        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            background.size.height = self.frame.height
            addChild(background)
            
            let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            background.run(moveForever)
        }
    }
    
    func drawObstacles(){
        let wallPair = SKNode()
        
        let topTexture = SKTexture(imageNamed: "topWall.png")
        let topWall = SKSpriteNode(texture: topTexture)
        
        let bottomTexture = SKSpriteNode(imageNamed: "bottomWall.png")
        let bottomWall = SKSpriteNode(texture: bottomTexture)
        
        topWall.position = CGPoint(
            x: self.frame.midX + self.frame.width,
            y: self.frame.midY + topTexture.size().height / 2 + 200
        )
        
        bottomWall.position = CGPoint(
            x: self.frame.midX + self.frame.width,
            y: self.frame.midY + bottomTexture.size().height / 2 - 200
        )
        
        topWall.setScale(0.5)
        bottomWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topTexture.size())
        topWall.physicsBody!.contactTestBitMask = CollideType.Wall.rawValue
        topWall.physicsBody!.categoryBitMask = CollideType.Bird.rawValue
        topWall.physicsBody!.collisionBitMask = CollideType.Bird.rawValue
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomTexture.size())
        bottomWall.physicsBody!.contactTestBitMask = CollideType.Wall.rawValue
        bottomWall.physicsBody!.categoryBitMask = CollideType.Bird.rawValue
        bottomWall.physicsBody!.collisionBitMask = CollideType.Bird.rawValue
        
        wallPair.addChild(topWall)
        wallPair.addChild(bottomWall)
        
        self.addChild(wallPair)
    }
    
    @objc func fireTimer(){
        //
    }
}
