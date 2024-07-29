//
//  CustomSubject.swift
//  SwiftDemo
//
//  Created by june on 2024/7/17.
//

import Foundation

class CustomSubject<Value> {
    private var observers = [(Value) -> Void]()
    
    func send(_ value: Value) {
        for observer in observers {
            DispatchQueue.main.async {
                observer(value)
            }
        }
    }
    
    func subscribe(_ observer: @escaping (Value) -> Void) {
        observers.append(observer)
    }
}
