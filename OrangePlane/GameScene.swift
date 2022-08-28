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
    
    enum CType: UInt32 {
        case Plane = 1
        case Pipe = 2
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
    func initializeGame() -> Void {
        timer = Timer.scheduledTimer(
            timeInterval: 3,
             target: self,
             selector: #selector(self.drawPipes),
             userInfo: nil,
             repeats: true
        )

        drawBackground()
        drawPlane()
        drawPipes()
        drawStart()
        ground()
        sky()
 
    }
   
    func drawPlane() -> Void {
        let planeTexture = SKTexture(imageNamed: "plane1.png")
        let planeTexture2 = SKTexture(imageNamed: "plane2.png")
        let animation = SKAction.animate(with: [planeTexture, planeTexture2], timePerFrame: 0.1)
        let planeFlying = SKAction.repeatForever(animation)
        plane = SKSpriteNode(texture: planeTexture)
        plane.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        plane.run(planeFlying)
        plane.physicsBody = SKPhysicsBody(circleOfRadius: planeTexture.size().height / 2)
        plane.physicsBody!.isDynamic = false
        plane.physicsBody!.contactTestBitMask = CType.Pipe.rawValue
        plane.physicsBody!.categoryBitMask = CType.Plane.rawValue
        plane.physicsBody!.collisionBitMask = CType.Plane.rawValue
        self.addChild(plane)
        
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
    
    @objc func drawPipes() -> Void {
 
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

        drawTopPipe(moveAndRemovePipes, gapHeight, pipeOffset)
        drawBottomPipe(moveAndRemovePipes, gapHeight, pipeOffset)
        
        }
    }
    
    func drawBottomPipe(_ moveAndRemovePipes: SKAction, _ gapHeight: CGFloat, _ pipeOffset: CGFloat) -> Void {
        let pipe2Texture = SKTexture(imageNamed: "bPipe.png")
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        pipe2.position = CGPoint(
            x: self.frame.midX + self.frame.width,
            y: self.frame.midY - pipe2Texture.size().height / 2 - gapHeight / 2  + pipeOffset
        )
        pipe2.run(moveAndRemovePipes)

        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipe2Texture.size())
        pipe2.physicsBody!.isDynamic = false

        pipe2.physicsBody!.contactTestBitMask = CType.Plane.rawValue
        pipe2.physicsBody!.categoryBitMask = CType.Plane.rawValue
        pipe2.physicsBody!.collisionBitMask = CType.Plane.rawValue
        self.addChild(pipe2)
    }
    
    func drawTopPipe(_ moveAndRemovePipes: SKAction, _ gapHeight: CGFloat, _ pipeOffset: CGFloat) -> Void {
        let pipeTexture = SKTexture(imageNamed: "UPipe.png")
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPoint(
            x: self.frame.midX + self.frame.width,
            y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset
        )
        pipe1.run(moveAndRemovePipes)

        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe1.physicsBody!.isDynamic = false
        pipe1.physicsBody!.contactTestBitMask = CType.Plane.rawValue
        pipe1.physicsBody!.categoryBitMask = CType.Plane.rawValue
        pipe1.physicsBody!.collisionBitMask = CType.Plane.rawValue
        self.addChild(pipe1)
    }
    
    func sky() -> Void {
        let sky = SKNode()
        sky.position = CGPoint(x: self.frame.midX, y: self.frame.height)
        sky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        sky.physicsBody!.isDynamic = false
        sky.physicsBody!.contactTestBitMask = CType.Plane.rawValue
        sky.physicsBody!.categoryBitMask = CType.Plane.rawValue
        sky.physicsBody!.collisionBitMask = CType.Plane.rawValue
        self.addChild(sky)
    }

    func ground() -> Void {
        let ground = SKNode()
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        ground.physicsBody!.isDynamic = false
        ground.physicsBody!.contactTestBitMask = CType.Plane.rawValue
        ground.physicsBody!.categoryBitMask = CType.Plane.rawValue
        ground.physicsBody!.collisionBitMask = CType.Plane.rawValue

        self.addChild(ground)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        startLabel.removeFromParent()
        gameStarted = true
        if gameOver == false {
            plane.physicsBody!.isDynamic = true
            plane.physicsBody!.velocity = CGVector(dx: 10, dy: 30)
            plane.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 1000))
        }
        else {
            startGame()
            removeAllChildren()
            initializeGame()
        }
    }
    @objc func fireTimer(){
        //
    }
    func startGame() -> Void {
        gameOver = false
        self.speed = 1
    }

    func resetGame() -> Void {
        self.speed = 0
        gameOver = true
        timer.invalidate()
    }
}

    
}
