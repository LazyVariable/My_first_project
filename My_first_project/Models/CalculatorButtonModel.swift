//
//  CalculatorButtonModel.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 29.12.2022.
//

import UIKit

class ValidatorNumbers: ButtonCellCommand {
    var name: String
    private var label: UILabel
    private var command:ButtonCellCommand
    func execute() {
        if label.text == nil || label.text!.count < 25 {
            command.execute()
        }
    }
    init(command:ButtonCellCommand, label: UILabel){
        self.command = command
        self.label = label
        name = command.name
    }
}

class InputCellCommand: ButtonCellCommand {
    var name: String
    private var label: UILabel
    private var input: InputData?
    
    func execute() {
        if label.text == "0" {
            label.text = name            
            input?.value = label.text
        }
        else {
            if label.text != nil && label.text!.contains(DotCellCommand.dotSymbol) {
                let dotIndex = label.text?.lastIndex(of: DotCellCommand.dotSymbol.last!)
                let suffix = label.text?.substring(from: dotIndex!)
                if suffix == nil || suffix!.count < 3
                {
                    label.text = label.text?.appending(name)
                    input?.value = label.text
                }
            }
            else{
                label.text = label.text?.appending(name)
                input?.value = label.text
            }
        }
        
    }
    init(text:String, label: UILabel, input: InputData?) {
        self.name=text
        self.label=label
        self.input = input
    }
}
class DotCellCommand: ButtonCellCommand {
    static let dotSymbol = "."
    var name = dotSymbol
    private var label: UILabel
    private var input: InputData?
    
    func execute() {
        if label.text == nil || !label.text!.contains("."){
            label.text = label.text?.appending(name)
            input?.value = label.text
        }
    }
    init(label: UILabel, input: InputData?) {
        self.label=label
        self.input = input
    }
}
class CeCellCommand: ButtonCellCommand {
    var name = "←"
    private var label: UILabel
    private var input: InputData?
    
    func execute() {
        if label.text != nil {
            if label.text!.count > 1 {
                label.text!.removeLast()
                input?.value = label.text
            }
            else if label.text!.count == 1 && label.text != "0" {
                label.text = "0"
                input?.value = label.text!
            }
        }
    }
    init(label: UILabel, input: InputData?) {
        self.label=label
        self.input = input
    }
}
