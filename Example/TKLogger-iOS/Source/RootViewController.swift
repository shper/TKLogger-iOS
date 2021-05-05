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
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.addSubview(self.titleTextView)
        self.titleTextView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        
        self.view.addSubview(self.verboseFilterBtn)
        self.verboseFilterBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.titleTextView.snp.bottom).offset(30)
        }
        self.verboseFilterBtn.addTarget(self, action: #selector(self.verboseFilterBtnClickFun), for: .touchDown)

        
        self.view.addSubview(self.verboseLogBtn)
        self.verboseLogBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.verboseFilterBtn.snp.bottom).offset(30)
        }
        self.verboseLogBtn.addTarget(self, action: #selector(self.verboseLogBtnClickFun), for: .touchDown)
        
        self.view.addSubview(self.infoLogBtn)
        self.infoLogBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.verboseLogBtn.snp.bottom).offset(30)
        }
        self.infoLogBtn.addTarget(self, action: #selector(self.infoLogBtnClickFun), for: .touchDown)
     
        self.view.addSubview(self.debugLogLogBtn)
        self.debugLogLogBtn.snp.makeConstraints{ (make) in
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.infoLogBtn.snp.bottom).offset(30)
        }
        self.debugLogLogBtn.addTarget(self, action: #selector(self.debugLogBtnClickFun), for: .touchDown)
        
        self.view.addSubview(self.waringLogLogBtn)
        self.waringLogLogBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.debugLogLogBtn.snp.bottom).offset(30)
        }
        self.waringLogLogBtn.addTarget(self, action: #selector(self.waringLogBtnClickFun), for: .touchDown)
        
        self.view.addSubview(self.errorLogLogBtn)
        self.errorLogLogBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.waringLogLogBtn.snp.bottom).offset(30)
        }
        self.errorLogLogBtn.addTarget(self, action: #selector(self.errorLogBtnClickFun), for: .touchDown)
    }
    
    // MARK: UI
    fileprivate lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TKLogger Example"
        textView.textAlignment = NSTextAlignment.center
        textView.font = UIFont.systemFont(ofSize: 24.0)
        textView.textColor = UIColor.black
        textView.isEditable = false
        
        return textView
    }()
    
    fileprivate lazy var verboseFilterBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Add Verbose Filter", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10.0
        
        return button
    }()
    
    fileprivate lazy var verboseLogBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Verbose level Log", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10.0
        
        return button
    }()
    
    fileprivate lazy var infoLogBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Info level Log", for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 10.0

        return button
    }()
    
    fileprivate lazy var debugLogLogBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Debug level Log", for: .normal)
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 10.0

        return button
    }()
    
    fileprivate lazy var waringLogLogBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Warning level Log", for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 10.0

        return button
    }()
    
    fileprivate lazy var errorLogLogBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Error level Log", for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 10.0

        return button
    }()
    
    // MARK: - Target

    @objc func verboseFilterBtnClickFun() {
        TKLogger.addFilter(VerboseLogFilter())
    }
    
    @objc func verboseLogBtnClickFun() {
        TKLogger.verbose("This is the verbose level log.")
    }
    
    @objc func infoLogBtnClickFun() {
        TKLogger.info("This is the info level log.")
    }
    
    @objc func debugLogBtnClickFun() {
        TKLogger.debug("This is the debug level log.")
    }
    
    @objc func waringLogBtnClickFun() {
        TKLogger.warning("This is the warning level log.")
    }
    
    @objc func errorLogBtnClickFun() {
        TKLogger.error("This is the error level log.")
    }
    
}

