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
        let width = UIScreen.main.bounds.width
        let button = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - heightButton, width: width, height: heightButton))
        button.setTitleColor(UIColor(red: 0.0 / 255.0, green: 118.0 / 255.0, blue: 252.0 / 255.0, alpha: 1), for: UIControlState())
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(actionBottonCount), for: .touchUpInside)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 1))
        view.backgroundColor = UIColor(red: 165.0 / 255.0, green: 165.0 / 255.0, blue: 165.0 / 255.0, alpha: 1)
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
        bottonCount.setTitle("ПРИКРЕПИТЬ \(count) ФОТО", for: UIControlState())
        bottonCount.isHidden = count == 0
    }
    
    func actionBottonCount()
    {
        done()
    }
}
