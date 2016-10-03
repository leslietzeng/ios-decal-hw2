//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var someDataStructure: [String] = ["0"]
    var totalSoFar: Double = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        print("Update (DataStructure) me like one of those PCs")
        someDataStructure.append(content);
        if content == "C" {
            someDataStructure.removeAll();
            someDataStructure.append("0");
            updateResultLabel(calculate());
        }
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        print("Update (ResultLabel) me like one of those PCs")
        resultLabel.text = content;
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    //REDO
    func calculate() -> String {
        var total: Double = 0
        var prevIsOperator: Bool = false;
        var op: String = "";
        for next in someDataStructure {
            if let next = Double(next) {
                //is an Int
                if !prevIsOperator {
                    let sign: Double = total < 0 ? -1 : 1
                    total = (total * 10) + (sign * next);
                } else {
                    //make sure you can switch on String in swift.
                    switch op {
                    case "/":
                        if next == 0 {break};
                        total /= next;
                        break;
                    case "*":
                        total *= next;
                        break;
                    case "-":
                        total -= next;
                        break;
                    case "+":
                        total += next;
                        break;
                    case "+/-":
                        total *= -1;
                        break;
                    case "%":
                        total /= 100.0;
                        break;
                    case "=":
                        //IMPLEMENT
                        break;
                    default:
                        break;
                    }
                    
                }
                prevIsOperator = false;
                
            } else {
                //is an operator or special button
                op = next;
                prevIsOperator = true;
                
            }
        }
        let isInteger:Bool = (floor(total) == total);
        if isInteger {
            return String(Int(total));
        }
        return String(total);

//        var total: Double = 0
//        var enterDecimal: Bool = false;
//        var multiplier: Double = 1;
//        var op: String = "";
//        for next in someDataStructure {
//            if let next = Double(next) {
//                //is a number
//                let sign: Double = total < 0 ? -1 : 1
//                if enterDecimal {
//                    total = total + (multiplier * next);
//                } else {
//                    total = (total * 10) + (sign * next);
//                }
//
//            } else {
//                //FIX LOGIC
//                //is an operator or special button
//                switch next {
//                    case ".":
//                        enterDecimal = true;
//                        multiplier /= 10;
//                        break;
//                    case "=":
//                        totalSoFar = total;
//                        break;
//                    case "%":
//                        totalSoFar /= 100.0;
//                        break;
//                    default:
//                        break;
//                    
//                }
//                switch op {
//                    case "/":
//                        if total == 0 {break};
//                        totalSoFar /= total;
//                        break;
//                    case "*":
//                        totalSoFar *= total;
//                        break;
//                    case "-":
//                        totalSoFar -= total;
//                        break;
//                    case "+":
//                        totalSoFar += total;
//                        break;
//                    case "+/-":
//                        totalSoFar *= total;
//                        break;
//                    case "=":
//                        //IMPLEMENT
//                        break;
//                    default:
//                        break;
//                    }
//                    op = next;
//                total = 0;
//                
//            }
//        }
//        let isInteger:Bool = (floor(totalSoFar) == totalSoFar);
//        if isInteger {
//            return String(Int(totalSoFar));
//        }
//        return String(totalSoFar);
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        //did not implement; dealt with by always doing double operations and converting to Int at end if applicable
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        //did not implement; dealt with by always doing double operations and converting to Int at end if applicable
        print("Calculation requested for \(a) \(operation) \(b)")
        return 0.0
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        // Fill me in!
        updateSomeDataStructure(sender.content);
        updateResultLabel(calculate());
        
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        updateSomeDataStructure(sender.content);
        
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        if Int(sender.content) == nil {
            operatorPressed(sender);
        } else {
            numberPressed(sender);
        }
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}

