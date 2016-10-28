//
//  File.swift
//  Solity-iOS
//
//  Created by Artem Kulagin on 26.10.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import UIKit

extension DKImagePickerController
{
    func createBottonCount() -> UIButton
    {
        let heightButton = CGFloat(44)
        let width = UIScreen.width()
        let button = UIButton(frame: CGRectMake(0, UIScreen.height() - heightButton, width, heightButton))
        button.setTitleColor(.customBlueButton(), forState: .Normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        button.backgroundColor = .whiteColor()
        button.addTarget(self, action: #selector(actionBottonCount), forControlEvents: .TouchUpInside)
        
        let view = UIView(frame: CGRectMake(0, 0, width, 1))
        view.backgroundColor = .gree165()
        button.addSubview(view)
        return button
    }
    
    func prepareBottonCount()
    {
        self.view.addSubview(bottonCount)
        updateBottonCount()
    }
    
    func updateBottonCount()
    {
        let count = self.selectedAssets.count
        bottonCount.setTitle("ПРИКРЕПИТЬ \(count) ФОТО", forState: .Normal)
        bottonCount.hidden = count == 0
    }
    
    func actionBottonCount()
    {
        done()
    }
}
