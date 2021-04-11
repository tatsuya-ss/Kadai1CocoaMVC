//
//  ViewController.swift
//  Kadai1CocoaMVC
//
//  Created by 坂本龍哉 on 2021/04/03.
//

import UIKit

class ViewController: UIViewController {
    var myModel: CalculateModel? {
        didSet {
            registerModel()
        }
    }
    
    private(set) lazy var myView: View = View()
    var calculateResult : String? = nil {
        didSet {
            myView.resultDisplayLabel.text = calculateResult ?? "Label"
        }
    }
    
    override func loadView() {
        view = myView
        print("ロードしました")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myModel?.delegate = self
    }
    
    private func registerModel() {
        myView.sumButton.addTarget(self,
                                   action: #selector(onSumButtonTapped),
                                   for: .touchUpInside)
    }
    
    @objc func onSumButtonTapped() {
        let numberArray  = [
            Int(myView.textField1.text!) ?? 0,
            Int(myView.textField2.text!) ?? 0,
            Int(myView.textField3.text!) ?? 0,
            Int(myView.textField4.text!) ?? 0,
            Int(myView.textField5.text!) ?? 0
        ]
        myModel?.sum(numberArray)
        view.endEditing(true)
    }
}

extension ViewController : CalculateModelDelegate {
    func successCalculate(_ calculateModel: CalculateModel, result: Int) {
        self.calculateResult = String(result)
    }
}

