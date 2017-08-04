//
//  GameScene.swift
//  ScrollLargeBgImages1
//
//  Created by macadmin on 2017-08-02.
//  Copyright © 2017 Test. All rights reserved.

//////////////////////////////////////////////////////////////////////
//                                                                  //
// Run this project on a physical device. Change the bundle         //
// identifier, if needed.                                           //
//                                                                  //
// The background images are preloaded from GameViewController      //
// and SceneManager.                                                //
//                                                                  //
// Tap screen to start the scrolling, tap again and the speed       //
// increases for every tap.                                         //
//                                                                  //
// This project makes the background images scroll but there        //
// is a twitch in the scrolling when the bg images are 'loaded'     //
// for the first time. When all the images has looped once, the     //
// scrolling is smooth and stays smooth, even at a very high        //
// scrolling speed (tap to increase speed).                         //
//                                                                  //
// How do I preload and scroll MANY large images so the twitch      //
// can be avoided?                                                  //
//                                                                  //
//////////////////////////////////////////////////////////////////////

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  
  // When the scrolling bg image reaches this x-coordinat, it will be moved to the right side outside the screen
  let BG_X_RESET: CGFloat = -1030.0
  
  // The spritenodes (bg images) are stored in this array, this is used when we scroll the images
  var bgImagesArray = [SKSpriteNode]()
  
  // This is the scrolling speed of the bg images.
  var backgroundSpeed:CGFloat = -15.0
  
  // We use this in 'touchesBegan' to start scrolling the bg images
  var scrollAction: SKAction!
  
  override init(size: CGSize) {
    super.init(size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMove(to view: SKView) {
    
    // Change 'numberOfBgPieces' to the number of bg image we want to scroll.
    setupBackgroundPieces(numberOfBgPieces: 8, bgArray: &bgImagesArray)
  }

  // Make sprites of the bg images and position them correctly
  func setupBackgroundPieces(numberOfBgPieces: Int, bgArray: inout [SKSpriteNode]){
    for x in 1...numberOfBgPieces {
      let bgImageName = "bgImage\(x)"
      let bg = SKSpriteNode(imageNamed: bgImageName)
      bg.position = CGPoint(x: self.frame.minX + (CGFloat(x-1) * bg.size.width), y: self.size.height / 2)
      bg.zPosition = 10
      bgArray.append(bg)
      self.addChild(bg)
    }
  }
  
  // This function is called from the update loop
  // This moves the bg images to the right side outside the
  // screen so that they will scroll again. The bg image is moved when it reaches 'spriteResetXPos' which is x -1030.0
  func bgMovementPosition(piecesArray: [SKSpriteNode], spriteResetXPos: CGFloat){
    
    for x in (0..<piecesArray.count){
      
      if piecesArray[x].position.x <= spriteResetXPos {
        
        var index: Int!
        
        if x == 0 {
          index = piecesArray.count - 1
        } else {
          index = x - 1
        }
        
        let newPos = CGPoint(x: piecesArray[index].position.x + piecesArray[x].size.width, y: piecesArray[x].position.y)
        
        piecesArray[x].position = newPos
      }
    }
  }
  
  
  func touchDown(atPoint pos : CGPoint) {
    
  }
  
  func touchMoved(toPoint pos : CGPoint) {
    
  }
  
  func touchUp(atPoint pos : CGPoint) {
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    // Start scrolling the background images when we tap screen.
    // Each time we tap screen, the scroll speed increases (I don't know if this
    // is the best way to increase the scroll speed but that is not relevant in this case
    // since the problem occurs after the first screen tap = start scrolling).
    scrollAction = SKAction.repeatForever(SKAction.moveBy(x: backgroundSpeed, y: 0, duration: 0.02))
    for x in bgImagesArray {
      x.run(scrollAction)
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    bgMovementPosition(piecesArray: bgImagesArray, spriteResetXPos: BG_X_RESET)
  }
}
