//
//  SceneManager.swift
//  ScrollLargeBgImages1
//
//  Created by macadmin on 2017-07-29.
//  Copyright © 2017 CodeZapp. All rights reserved.
//

import Foundation
import SpriteKit

class SceneManager {
  
  static let sharedInstance = SceneManager()
  
  // Preload from atlas. All images cannot be used into one atlas.
  // If all images are put in one atlas, when building Xcode gives error:
  // “Generate SpriteKit Texture Atlas Error Group”: “/TextureAtlas: cannot fit input texture into a maximum supported dimension of 2048 x 2048.”
  var textureAtlas = [SKTextureAtlas]()
  
  func preloadAssets() {
    
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesA"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesB"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesC"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesD"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesE"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesF"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesG"))
    textureAtlas.append(SKTextureAtlas(named: "BGScrollImagesH"))
    
    SKTextureAtlas.preloadTextureAtlases(textureAtlas, withCompletionHandler: { () -> Void in
      print("PRELOAD COMPLETED")
    })
    
  }
  
}
