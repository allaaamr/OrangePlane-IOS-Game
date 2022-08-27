//
//  GameScene.swift
//  OrangePlane
//
//  Created by Alaa Amr Abdelazeem on 26/08/2022.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var plane: SKSpriteNode = SKSpriteNode()
    var gameOver: Bool = false
    var gameStarted: Bool = false
    
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
        
        if(gameStarted){
            let gapHeight = plane.size.height * 2
            
            let movePipes = SKAction.move(
                by: CGVector(dx: -2 * self.frame.width, dy: 0),
                duration: TimeInterval(self.frame.width / 100)
            )

            let removePipes = SKAction.removeFromParent()

            let movementAmount = arc4random() % UInt32(self.frame.height / 2)
            let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])

            let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
                
            let wallPair = SKNode()
            
            let topTexture = SKTexture(imageNamed: "topWall.png")
            let topWall = SKSpriteNode(texture: topTexture)
            
            let bottomTexture = SKTexture(imageNamed: "bottomWall.png")
            let bottomWall = SKSpriteNode(texture: bottomTexture)

            topWall.position = CGPoint(
                x: self.frame.midX + self.frame.width,
                y: self.frame.midY + topTexture.size().height / 2 + gapHeight / 2 + pipeOffset
            )
            
            bottomWall.position = CGPoint(
                x: self.frame.midX + self.frame.width,
                y: self.frame.midY + bottomTexture.size().height / 2 - gapHeight / 2  + pipeOffset
            )
            
            topWall.run(moveAndRemovePipes)
            topWall.physicsBody = SKPhysicsBody(rectangleOf: topTexture.size())
            topWall.physicsBody!.contactTestBitMask = CollideType.Wall.rawValue
            topWall.physicsBody!.categoryBitMask = CollideType.Wall.rawValue
            topWall.physicsBody!.collisionBitMask = CollideType.Wall.rawValue
            topWall.physicsBody!.isDynamic = false
            
            bottomWall.run(moveAndRemovePipes)
            bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomTexture.size())
            bottomWall.physicsBody!.contactTestBitMask = CollideType.Wall.rawValue
            bottomWall.physicsBody!.categoryBitMask = CollideType.Wall.rawValue
            bottomWall.physicsBody!.collisionBitMask = CollideType.Wall.rawValue
            bottomWall.physicsBody!.isDynamic = false
            
            wallPair.addChild(topWall)
            wallPair.addChild(bottomWall)
            
            self.addChild(wallPair)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if gameOver == false {
            plane.physicsBody!.isDynamic = true
            plane.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            plane.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 1000))
        } else {
//            startGame()
            removeAllChildren()
//            initializeGame()
        }
    }
    @objc func fireTimer(){
        //
    }
}
