//
//  ViewController.swift
//  ViewModelSystem
//
//  Created by Igor-Macbook Pro on 13/06/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let label = UILabel()
    
    let dBag = DisposeBag()
    
    var endFlag = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("STARTED")
        configureUI(text : "fds")
     //   rxAction()
        resultAction()
    }

    
    private func configureUI(text : String) {
        self.view.backgroundColor = UIColor.blue
        let rxButton = UIButton()
        let resultButton = UIButton()
        
        label.frame = CGRect(x: 200, y: 200, width: 1000, height: 1000)
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor.black
        label.text = text
        label.sizeToFit()
        label.backgroundColor = UIColor.red
        
        self.view.addSubview(label)
        
    }

    private func rxAction() {
        ViewModel.someAPICallRx()
        let d = ViewModel.relayValue.subscribe(onNext: { [unowned self] (str) in
            self.configureUI(text: str)
            if str == "End" {
                self.endFlag = true
            }
        }, onError: { (error) in
            print("error")
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }

        if self.endFlag {
            d.disposed(by: dBag)
        }
    }
    
    private func resultAction() {
        ViewModel.someAPICallResult { (result) in
            switch result {
            case .failure(.badUrl):
                print("faild")
            case .success(let value):
                print(value)
                self.configureUI(text: value)
            }
        }
    }
    
}

