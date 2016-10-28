//
//  DKImagePickerControllerDefaultUIDelegate.swift
//  DKImagePickerControllerDemo
//
//  Created by ZhangAo on 16/3/7.
//  Copyright © 2016年 ZhangAo. All rights reserved.
//

import UIKit

@objc
public class DKImagePickerControllerDefaultUIDelegate: NSObject, DKImagePickerControllerUIDelegate {
	
	public weak var imagePickerController: DKImagePickerController!

	public func prepareLayout(imagePickerController: DKImagePickerController, vc: UIViewController) {
		self.imagePickerController = imagePickerController
		vc.navigationItem.leftBarButtonItem = barCancel()
	}
    
    func barCancel() -> UIBarButtonItem
    {
        return barItem("cross", action: #selector(DKImagePickerController.dismiss))
    }
    
    func barItem(image: String, action: Selector) -> UIBarButtonItem
    {
        return UIBarButtonItem(image: UIImage(named: image), style: .Plain, target: imagePickerController, action: action)
    }

	public func imagePickerControllerCreateCamera(imagePickerController: DKImagePickerController,
	                                              didCancel: (() -> Void),
	                                              didFinishCapturingImage: ((image: UIImage) -> Void),
	                                              didFinishCapturingVideo: ((videoURL: NSURL) -> Void)) -> UIViewController {
		
		let camera = DKCamera()
		
		camera.didCancel = { () -> Void in
			didCancel()
		}
		
		camera.didFinishCapturingImage = { (image) in
			didFinishCapturingImage(image: image)
		}
		
		self.checkCameraPermission(camera)
	
		return camera
	}
	
	public func layoutForImagePickerController(imagePickerController: DKImagePickerController) -> UICollectionViewLayout.Type {
		return DKAssetGroupGridLayout.self
	}
	
	public func imagePickerController(imagePickerController: DKImagePickerController,
	                                  showsCancelButtonForVC vc: UIViewController) {
	}
	
	public func imagePickerController(imagePickerController: DKImagePickerController,
	                                  hidesCancelButtonForVC vc: UIViewController) {
	}
	
	public func imagePickerController(imagePickerController: DKImagePickerController, didSelectAsset: DKAsset) {
		updateBottonCount()
	}
    
    public func imagePickerController(imagePickerController: DKImagePickerController, didSelectAssets: [DKAsset]) {
        updateBottonCount()
    }
	
	public func imagePickerController(imagePickerController: DKImagePickerController, didDeselectAsset: DKAsset) {
		updateBottonCount()
	}
    
    public func imagePickerController(imagePickerController: DKImagePickerController, didDeselectAssets: [DKAsset]) {
        updateBottonCount()
    }
	
	public func imagePickerControllerDidReachMaxLimit(imagePickerController: DKImagePickerController) {
        let alert = UIAlertController(title: DKImageLocalizedStringWithKey("maxLimitReached")
            , message:String(format: DKImageLocalizedStringWithKey("maxLimitReachedMessage"), imagePickerController.maxSelectableCount)
            , preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: DKImageLocalizedStringWithKey("ok"), style: .Cancel) { _ in })
        imagePickerController.presentViewController(alert, animated: true){}
	}
	
	public func imagePickerControllerFooterView(imagePickerController: DKImagePickerController) -> UIView? {
		return nil
	}
    
    public func imagePickerControllerCameraImage() -> UIImage {
        return DKImageResource.cameraImage()
    }
    
    public func imagePickerControllerCheckedNumberColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    public func imagePickerControllerCheckedNumberFont() -> UIFont {
        return UIFont.boldSystemFontOfSize(14)
    }
    
    public func imagePickerControllerCheckedImageTintColor() -> UIColor? {
        return nil
    }
    
    public func imagePickerControllerCollectionViewBackgroundColor() -> UIColor {
        return UIColor.whiteColor()
    }
	
	// Internal
	
	public func checkCameraPermission(camera: DKCamera) {
		func cameraDenied() {
			dispatch_async(dispatch_get_main_queue()) {
				let permissionView = DKPermissionView.permissionView(.Camera)
				camera.cameraOverlayView = permissionView
			}
		}
		
		func setup() {
			camera.cameraOverlayView = nil
		}
		
		DKCamera.checkCameraPermission { granted in
			granted ? setup() : cameraDenied()
		}
	}
    
    func updateBottonCount()
    {
        self.imagePickerController.updateBottonCount()
    }
}
