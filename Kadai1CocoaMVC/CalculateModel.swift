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
    func sum(_ number: [Int]) throws -> Void
}

enum CalculateError : Error {
    case intOutOfRange
    var text: String {
        switch self {
        case .intOutOfRange:
            return "範囲外の計算結果です"
        }
    }
}


class CalculateModel : Calculate {
    weak var delegate: CalculateModelDelegate?
    
    func sum(_ number: [Int]) throws -> Void {
        
        let sum = number.reduce(0, { $0 + $1 })
        guard sum < Int.max else { throw CalculateError.intOutOfRange }
        delegate?.successCalculate(self, result: sum)
    }
}

