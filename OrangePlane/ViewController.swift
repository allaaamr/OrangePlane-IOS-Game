//
//  ViewController.swift
//  OrangePlane
//
//  Created by Alaa Amr Abdelazeem on 26/08/2022.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsDrawCount = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        // Do any additional setup after loading the view.
        
    }
    

}

