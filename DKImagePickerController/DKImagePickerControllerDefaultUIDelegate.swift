//
//  DKImagePickerControllerDefaultUIDelegate.swift
//  DKImagePickerControllerDemo
//
//  Created by ZhangAo on 16/3/7.
//  Copyright © 2016年 ZhangAo. All rights reserved.
//

import UIKit

@objc
open class DKImagePickerControllerDefaultUIDelegate: NSObject, DKImagePickerControllerUIDelegate {
	
	open weak var imagePickerController: DKImagePickerController!

	open func prepareLayout(_ imagePickerController: DKImagePickerController, vc: UIViewController) {
		self.imagePickerController = imagePickerController
		vc.navigationItem.leftBarButtonItem = barCancel()
	}
    
    func barCancel() -> UIBarButtonItem
    {
        return barItem("cross", action: #selector(DKImagePickerController.dismissScreen))
    }
    
    func barItem(_ image: String, action: Selector) -> UIBarButtonItem
    {
        return UIBarButtonItem(image: UIImage(named: image), style: .plain, target: imagePickerController, action: action)
    }

	open func imagePickerControllerCreateCamera(_ imagePickerController: DKImagePickerController,
	                                              didCancel: @escaping (() -> Void),
	                                              didFinishCapturingImage: @escaping ((_ image: UIImage) -> Void),
	                                              didFinishCapturingVideo: @escaping ((_ videoURL: URL) -> Void)) -> UIViewController {
		
		let camera = DKCamera()
		
		camera.didCancel = { () -> Void in
			didCancel()
		}
		
		camera.didFinishCapturingImage = { (image) in
			didFinishCapturingImage(image)
		}
		
		self.checkCameraPermission(camera)
	
		return camera
	}
	
	open func layoutForImagePickerController(_ imagePickerController: DKImagePickerController) -> UICollectionViewLayout.Type {
		return DKAssetGroupGridLayout.self
	}
	
	open func imagePickerController(_ imagePickerController: DKImagePickerController,
	                                  showsCancelButtonForVC vc: UIViewController) {
	}
	
	open func imagePickerController(_ imagePickerController: DKImagePickerController,
	                                  hidesCancelButtonForVC vc: UIViewController) {
	}
	
	open func imagePickerController(_ imagePickerController: DKImagePickerController, didSelectAsset: DKAsset) {
		updateBottonCount()
	}
    
    open func imagePickerController(_ imagePickerController: DKImagePickerController, didSelectAssets: [DKAsset]) {
        updateBottonCount()
    }
	
	open func imagePickerController(_ imagePickerController: DKImagePickerController, didDeselectAsset: DKAsset) {
		updateBottonCount()
	}
    
    open func imagePickerController(_ imagePickerController: DKImagePickerController, didDeselectAssets: [DKAsset]) {
        updateBottonCount()
    }
	
	open func imagePickerControllerDidReachMaxLimit(_ imagePickerController: DKImagePickerController) {
        let alert = UIAlertController(title: DKImageLocalizedStringWithKey("maxLimitReached")
            , message:String(format: DKImageLocalizedStringWithKey("maxLimitReachedMessage"), imagePickerController.maxSelectableCount)
            , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DKImageLocalizedStringWithKey("ok"), style: .cancel) { _ in })
        imagePickerController.present(alert, animated: true){}
	}
	
	open func imagePickerControllerFooterView(_ imagePickerController: DKImagePickerController) -> UIView? {
		return nil
	}
    
    open func imagePickerControllerCameraImage() -> UIImage {
        return DKImageResource.cameraImage()
    }
    
    open func imagePickerControllerCheckedNumberColor() -> UIColor {
        return UIColor.white
    }
    
    open func imagePickerControllerCheckedNumberFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    open func imagePickerControllerCheckedImageTintColor() -> UIColor? {
        return nil
    }
    
    open func imagePickerControllerCollectionViewBackgroundColor() -> UIColor {
        return UIColor.white
    }
	
	// Internal
	
	open func checkCameraPermission(_ camera: DKCamera) {
		func cameraDenied() {
			DispatchQueue.main.async {
				let permissionView = DKPermissionView.permissionView(.camera)
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
