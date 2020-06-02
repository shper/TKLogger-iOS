//
//  ViewController.swift
//  TKLogger-iOS
//
//  Created by me@shper.cn on 05/28/2020.
//  Copyright (c) 2020 me@shper.cn. All rights reserved.
//
import UIKit
import SnapKit
import TKLogger

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.addSubview(self.testTextView)
        self.testTextView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
        TKLogger.debug("AAA")
    }
    
    // MARK: UI
    fileprivate lazy var testTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Root ViewController"
        textView.textAlignment = NSTextAlignment.center
        textView.font = UIFont.systemFont(ofSize: 24.0)
        textView.textColor = UIColor.black
        textView.isEditable = false
        
        return textView
    }()
    
}

