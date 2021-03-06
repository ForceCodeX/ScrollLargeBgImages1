//
//  GameViewController.swift
//  ScrollLargeBgImages1
//
//  Created by macadmin on 2017-08-02.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Preload images from SceneManager.swift
    SceneManager.sharedInstance.preloadAssets()
    self.startScene()
    
  }
  
  func startScene() {
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      let scene = GameScene(size:CGSize(width: 2048, height: 1536))
      // Set the scale mode to scale to fit the window
      scene.scaleMode = .aspectFill
      
      // Present the scene
      view.presentScene(scene)
      
      view.ignoresSiblingOrder = true
      view.showsFPS = true
      view.showsNodeCount = true
    }
    
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
