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
  
  let playableRect: CGRect
  
  let BG_X_RESET: CGFloat = -1030.0
  var bgImages = [SKSpriteNode]()
  var backgroundActions = [SKAction]()
  var backgroundSpeed:CGFloat = -15.0
  var action: SKAction!
  
  var touchScreen: Bool = false
  
  override init(size: CGSize) {
    let maxAspectRatio:CGFloat = 16.0/9.0
    let playableHeight = size.width / maxAspectRatio
    let playableMargin = (size.height-playableHeight)/2.0
    playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
    super.init(size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMove(to view: SKView) {
    
    // Draw a red square around the playable area (gameArea)
    debugDrawPlayableArea()
    
    // Change 'numberOfBgPieces' to the number of bg image we want to scroll.
    setupBackgroundPieces(numberOfBgPieces: 8, bgImage: "bgImage", spriteName: "bgImage", bgYPos: 400, bgZIndex: 10, bgArray: &bgImages, bgActionX: backgroundSpeed, gameArea: playableRect)
  }
  
  func debugDrawPlayableArea() {
    let shape = SKShapeNode()
    let path = CGMutablePath()
    path.addRect(playableRect)
    shape.path = path
    shape.strokeColor = SKColor.red
    shape.lineWidth = 4.0
    shape.zPosition = 100
    addChild(shape)
  }
  
  func setupBackgroundPieces(numberOfBgPieces: Int, bgImage: String, spriteName: String, bgYPos: CGFloat, bgZIndex: CGFloat, bgArray: inout [SKSpriteNode], bgActionX: CGFloat, gameArea: CGRect){
    
    for x in 1...numberOfBgPieces {
      let bgImageName = "\(bgImage)\(x)"
      let bg = SKSpriteNode(imageNamed: bgImageName)
      bg.name = spriteName
      bg.position = CGPoint(x: gameArea.minX + (CGFloat(x-1) * bg.size.width), y: self.size.height / 2)
      bg.zPosition = bgZIndex
      bgArray.append(bg)
      self.addChild(bg)
    }
  }
  
  // This is called from the update loop
  // This moves the bg images to the right side outside the
  // screen so that they will scroll again. The bg image is moved when it reaches 'spriteResetXPos'
  func groundAndBgMovementPosition(piecesArray: [SKSpriteNode], spriteResetXPos: CGFloat){
    
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
    // Start scrolling the background images when we tap screen
    // Each time we tap screen, the scroll speed increases (I don't know if this
    // is the best way to increase the scroll speed).
    action = SKAction.repeatForever(SKAction.moveBy(x: -15.0, y: 0, duration: 0.02))
    for x in bgImages {
      x.run(action)
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
    groundAndBgMovementPosition(piecesArray: bgImages, spriteResetXPos: BG_X_RESET)
  }
}
