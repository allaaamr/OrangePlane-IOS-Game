//
//  GameScene.swift
//  OrangePlane
//
//  Created by Alaa Amr Abdelazeem on 26/08/2022.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
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
        //
    }
}
