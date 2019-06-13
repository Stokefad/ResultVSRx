//
//  ViewModel.swift
//  ViewModelSystem
//
//  Created by Igor-Macbook Pro on 13/06/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire


class ViewModel {
    
    private static let data = "Hello world"
    
    public static let relayValue = BehaviorRelay(value: "fds")

    public static func someAPICallRx() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("sending")
            relayValue.accept(data)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            print("sending")
            relayValue.accept("End")
        }
    }
    
    public static func someAPICallResult(callback : @escaping (Swift.Result<String, MyError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if data.count == 0 {
                callback(.failure(.badUrl))
            }
            else {
                callback(.success(data))
            }
        }
    }
    
}


enum MyError : Error {
    case badUrl
}
