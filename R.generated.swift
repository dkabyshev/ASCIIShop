//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(identifier: "com.hilltrix.ASCIIShop") ?? Bundle.main
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 3 files.
  struct file {
    /// Resource file `Info.plist`.
    static let infoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "Info", pathExtension: "plist")
    /// Resource file `env_prod.plist`.
    static let env_prodPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "env_prod", pathExtension: "plist")
    /// Resource file `env_stage.plist`.
    static let env_stagePlist = Rswift.FileResource(bundle: R.hostingBundle, name: "env_stage", pathExtension: "plist")
    
    /// `bundle.url(forResource: "Info", withExtension: "plist")`
    static func infoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.infoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "env_prod", withExtension: "plist")`
    static func env_prodPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.env_prodPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "env_stage", withExtension: "plist")`
    static func env_stagePlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.env_stagePlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `LaunchImage`.
    static let launchImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "LaunchImage")
    
    /// `UIImage(named: "LaunchImage", bundle: ..., traitCollection: ...)`
    static func launchImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchImage, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `ItemStockCell`.
    static let itemStockCell = _R.nib._ItemStockCell()
    /// Nib `LoadingView`.
    static let loadingView = _R.nib._LoadingView()
    
    /// `UINib(name: "ItemStockCell", in: bundle)`
    static func itemStockCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.itemStockCell)
    }
    
    /// `UINib(name: "LoadingView", in: bundle)`
    static func loadingView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.loadingView)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `itemCell`.
    static let itemCell: Rswift.ReuseIdentifier<ItemTableViewCell> = Rswift.ReuseIdentifier(identifier: "itemCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      // There are no resources to validate
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}

struct _R {
  struct nib {
    struct _ItemStockCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = ItemTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "itemCell"
      let name = "ItemStockCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> ItemTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ItemTableViewCell
      }
      
      fileprivate init() {}
    }
    
    struct _LoadingView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "LoadingView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard {
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}