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
    var someDataStructure: [String] = ["0"] //newly inputted number
    var currentOperator:String = ""
    var oldOperator:String = "";
    var oldOperatorValue:Double = 0;
    var currentValue:Double = 0;
    var numberEntered:Bool = false;
    var numCount: Int = 0;
    
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
        if (someDataStructure.count == 1 && someDataStructure[0] == "0") {
            if content != "." {
                someDataStructure.removeAll();
                numCount = 0;
            }
        }
        someDataStructure.append(content)
        
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        print("Update (ResultLabel) me like one of those PCs")
        var index = content.index(content.startIndex, offsetBy: min(content.characters.count, 7))
        if (content.contains(".")) {
            index = content.index(content.startIndex, offsetBy: min(content.characters.count, 8))
        }
            
        resultLabel.text = content.substring(to: index)
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    //REDO
    func calculate() -> String {
        return ""

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
        //shouldn't have to calculate anything - just take what's in data structure and print to screen.
        // Fill me in!
        numCount += 1;
        handleInput(sender.content);
        print("\(numCount)")
        numberEntered = true;
        
    }
    
    func handleInput(_ content: String) {
        if numCount >= 7 {
            print("\(dataStructureToDouble())")
            return;
        }
        updateSomeDataStructure(content);
        var inputtedNumber = "";
        var inverse:Bool = false;
        var decimalFlag:Bool = false;
        for str in someDataStructure {
            if str == "." {
                if decimalFlag {
                    continue;
                }
                decimalFlag = true;
            }
            if (str == "+/-") {
                inverse = inverse ? false : true; //XOR
            } else {
                inputtedNumber.append(str);
            }
            
        }
        if inverse {
            inputtedNumber = "-" + inputtedNumber;
        }
        updateResultLabel(inputtedNumber)
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        switch sender.content {
            case ".":
                handleInput(sender.content)
                break;
            case "+/-":
                handleInput(sender.content)
                break;
            case "C":
                someDataStructure.removeAll();
                numCount = 0;
                //currentValue = dataStructureToDouble();
                currentOperator = "";
                currentValue = 0;
                handleInput("0");
                break;
            
            case "=":
                print("\(currentOperator)\t\(oldOperator)\t\(oldOperatorValue)");
                if currentOperator == "" {
                    currentValue = dataStructureToDouble();
                } else {
                    let operatorVal:Double = currentOperator == "=" ? oldOperatorValue : dataStructureToDouble();
                    let operatorToCompare:String = currentOperator == "=" ? oldOperator : currentOperator;
                        switch operatorToCompare {
                        case "+":
                            currentValue += operatorVal;
                            break;
                        case "-":
                            currentValue -= operatorVal;
                            break;
                        case "/":
                            currentValue /= operatorVal;
                            break;
                        case "*":
                            currentValue *= operatorVal;
                            break;
                        case "%":
                            currentValue /= 100;
                            break;
                        default:
                            break;
                    }
                    if currentOperator != "=" {
                        oldOperator = currentOperator;
                        print("UpdateOldOperator \(dataStructureToDouble())");
                        oldOperatorValue = dataStructureToDouble();
                    }
                    numberEntered = false;
                }
                currentOperator = "=";
                if (floor(currentValue) == currentValue) {
                    updateResultLabel(String(Int(currentValue)))
                } else {
                    updateResultLabel(String(currentValue))
                }
                break;
            case "+", "-", "/", "*", "=":
                
                    
                if (currentOperator == "") {
                    currentValue = dataStructureToDouble();
                    print("currentValue: \(currentValue)");
                } else if (numberEntered) {
                    let operatorVal:Double = dataStructureToDouble();
                    switch currentOperator {
                        case "+":
                            currentValue += operatorVal;
                            break;
                        case "-":
                            currentValue -= operatorVal;
                            break;
                        case "/":
                            currentValue /= operatorVal;
                            break;
                        case "*":
                            currentValue *= operatorVal;
                            break;
                        case "%":
                            currentValue /= 100;
                            break;
                        default:
                            break;
                    }
                    print("currentValue: \(currentValue)");
                    if (floor(currentValue) == currentValue) {
                        updateResultLabel(String(Int(currentValue)))
                    } else {
                        updateResultLabel(String(currentValue))
                    }
                    numberEntered = false;
                    
                }
                print("UpdateOldOperator \(dataStructureToDouble())");
                oldOperatorValue = dataStructureToDouble();
                
                someDataStructure.removeAll();
                numCount = 0;
                someDataStructure.append("0");
                currentOperator = sender.content;

            
            
            default:
                break;
        }
        
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        if (Int(sender.content) == nil) {
            operatorPressed(sender);
        } else {
            numberPressed(sender);
        }
    }
    func dataStructureToDouble() -> Double {
        var decimalFlag:Bool = false;
        var multiplier:Double = 1;
        var total:Double = 0;
        var inverse:Bool = false;
        for str in someDataStructure {
            if let nextDigit = Double(str) {
                let sign: Double = total < 0 ? -1 : 1
                if decimalFlag {
                    multiplier /= 10;
                    total = total + (sign * multiplier * nextDigit)
                } else {
                    total = (total * 10) + (sign * nextDigit);
                }
            } else {
                switch str {
                    case ".":
                        decimalFlag = true;
                        break;
                    
                    case "+/-":
                        inverse = inverse ? false : true;
                        break;
                    default:
                        break;
                }
                    
            }
        }
        if inverse {
            return total * -1;
        }
        return total;
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

