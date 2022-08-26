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
        //
    }
    func drawObstacles(){
        //
    }
}
