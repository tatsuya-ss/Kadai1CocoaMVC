//
//  ViewController.swift
//  Kadai1CocoaMVC
//
//  Created by 坂本龍哉 on 2021/04/03.
//

import UIKit

protocol Calculate {
    var result: String { get }
    
    func sum(_ number: [Int])
}

class ViewController: UIViewController {
    var myModel: Model? {
        didSet {
            registerModel()
        }
    }
    
    private(set) lazy var myView: View = View()
    
    override func loadView() {
        view = myView
        print("ロードしました")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func registerModel() {
        guard let model = myModel else { return }
        
        myView.resultDisplayLabel.text = model.result.description
        
        myView.sumButton.addTarget(self,
                                   action: #selector(onSumButtonTapped),
                                   for: .touchUpInside)
        model.notificationCenter.addObserver(forName: .init(rawValue: "result"),
                                             object: nil,
                                             queue: nil,
                                             using: { [unowned self] notification in
                                                    print("通知中")
                                                    if let result = notification.userInfo?["result"] as? String {
                                                        self.myView.resultDisplayLabel.text = "\(result)"
                                                        print("result \(result)")
                                                    }
                                                })
    }
    

    @objc func onSumButtonTapped() {
        let textNumber1 = Int(myView.textField1.text!) ?? 0
        let textNumber2 = Int(myView.textField2.text!) ?? 0
        let textNumber3 = Int(myView.textField3.text!) ?? 0
        let textNumber4 = Int(myView.textField4.text!) ?? 0
        let textNumber5 = Int(myView.textField5.text!) ?? 0
        let numberArray  = [textNumber1, textNumber2, textNumber3, textNumber4, textNumber5]
        myModel?.sum(numberArray)
        view.endEditing(true)
    }

}

class Model : Calculate {
    let notificationCenter = NotificationCenter()
    private(set) var result = "Label" {
        didSet {
            print("\(result)に更新しました")
            notificationCenter.post(name: .init(rawValue: "result"),
                                    object: nil,
                                    userInfo: ["result": result])
        }
    }
    
    
    func sum(_ number: [Int]) {
        let sum = number.reduce(0, { $0 + $1 })
        result = String(sum)
        print("\(result)計算しました")
    }
}

class View: UIView {
    let textField1 = UITextField()
    let textField2 = UITextField()
    let textField3 = UITextField()
    let textField4 = UITextField()
    let textField5 = UITextField()
    let sumButton = UIButton()
    let resultDisplayLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
        print("viewが追加されました")
        setLayout()
        print("レイアウトが追加されました")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        addSubview(textField1)
        addSubview(textField2)
        addSubview(textField3)
        addSubview(textField4)
        addSubview(textField5)
        addSubview(sumButton)
        addSubview(resultDisplayLabel)
        
        self.backgroundColor = .white
        
        textField1.borderStyle = .roundedRect
        textField1.layer.borderColor = UIColor.gray.cgColor
        textField1.keyboardType = .numberPad
        
        textField2.borderStyle = .roundedRect
        textField2.layer.borderColor = UIColor.gray.cgColor
        textField2.keyboardType = .numberPad
        
        textField3.borderStyle = .roundedRect
        textField3.layer.borderColor = UIColor.gray.cgColor
        textField3.keyboardType = .numberPad
        
        textField4.borderStyle = .roundedRect
        textField4.layer.borderColor = UIColor.gray.cgColor
        textField4.keyboardType = .numberPad
        
        textField5.borderStyle = .roundedRect
        textField5.layer.borderColor = UIColor.gray.cgColor
        textField5.keyboardType = .numberPad
        
        sumButton.setTitle("Button", for: .normal)
        sumButton.setTitleColor(UIColor.systemBlue, for: .normal)
        
        resultDisplayLabel.textColor = .black

    }
    
    private func setLayout() {
        textField1.translatesAutoresizingMaskIntoConstraints = false
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField3.translatesAutoresizingMaskIntoConstraints = false
        textField4.translatesAutoresizingMaskIntoConstraints = false
        textField5.translatesAutoresizingMaskIntoConstraints = false
        sumButton.translatesAutoresizingMaskIntoConstraints = false
        resultDisplayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let standardValue = CGFloat(8)
        let leftAnchorValue = CGFloat(30)
        let itemWidthAnchorValue = CGFloat(97)

        textField1.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        textField1.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorValue).isActive = true
        textField1.widthAnchor.constraint(equalToConstant: itemWidthAnchorValue).isActive = true
        
        textField2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: standardValue).isActive = true
        textField2.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorValue).isActive = true
        textField2.widthAnchor.constraint(equalToConstant: itemWidthAnchorValue).isActive = true

        textField3.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: standardValue).isActive = true
        textField3.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorValue).isActive = true
        textField3.widthAnchor.constraint(equalToConstant: itemWidthAnchorValue).isActive = true

        textField4.topAnchor.constraint(equalTo: textField3.bottomAnchor, constant: standardValue).isActive = true
        textField4.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorValue).isActive = true
        textField4.widthAnchor.constraint(equalToConstant: itemWidthAnchorValue).isActive = true

        textField5.topAnchor.constraint(equalTo: textField4.bottomAnchor, constant: standardValue).isActive = true
        textField5.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorValue).isActive = true
        textField5.widthAnchor.constraint(equalToConstant: itemWidthAnchorValue).isActive = true
        
        sumButton.topAnchor.constraint(equalTo: textField5.bottomAnchor, constant: standardValue).isActive = true
        sumButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leftAnchorValue).isActive = true
        sumButton.widthAnchor.constraint(equalToConstant: itemWidthAnchorValue).isActive = true
        
        resultDisplayLabel.topAnchor.constraint(equalTo: sumButton.bottomAnchor, constant: standardValue).isActive = true
        resultDisplayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftAnchorValue).isActive = true
    }
}
