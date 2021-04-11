//
//  CalculateModel.swift
//  Kadai1CocoaMVC
//
//  Created by 坂本龍哉 on 2021/04/09.
//

import Foundation

protocol CalculateModelDelegate : AnyObject {
    func successCalculate(_ calculateModel: CalculateModel, result: Int)
}

protocol Calculate {
    func sum(_ number: [Int])
}


class CalculateModel : Calculate {
    weak var delegate: CalculateModelDelegate?
    
    func sum(_ number: [Int]) {
        let sum = number.reduce(0, { $0 + $1 })
        delegate?.successCalculate(self, result: sum)
    }
}

