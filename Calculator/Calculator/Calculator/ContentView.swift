//
//  ContentView.swift
//  Calculator
//
//  Created by Yuqi CHEN on 2022/10/01.
//

import SwiftUI

enum CalcuButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "/"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self{
        case .add, .substract, .mutliply, .divide, .equal:
            return Color(.orange)
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(displayP3Red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation{
    case add, substract, mutliply, divide, none
    
    
}


struct ContentView: View {
    
    @State var value = "0"
    
    @State var runningNumber = 0.0
    
    @State var currentOperation: Operation = .none
    
    @State var IfFlash = false
    
    let buttons:[[CalcuButton]]=[
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.mutliply],
        [.four,.five,.six,.substract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal],
    ]
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                //Text Display
                Spacer()
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size:70))
                        .foregroundColor(.white)
                }
                .padding()
                
                
                //Buttom
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12){
                            ForEach(row, id: \.self) { item in
                            Button( action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size:32))
                                    .frame(
                                        width:self.buttonWidth(item: item),
                                        height:self.buttonHeight(item: item)
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
            
        }
    }
    
    
    //button function
    func didTap(button:CalcuButton){
        switch button{
        case .clear:
            self.value="0"
            self.runningNumber=0
            
        case .add, .substract, .mutliply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0.0
            }else if button == .add{
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0.0
            }else if button == .substract{
                self.currentOperation = .substract
                self.runningNumber = Double(self.value) ?? 0.0
            }else if button == .mutliply{
                self.currentOperation = .mutliply
                self.runningNumber = Double(self.value) ?? 0.0
            }else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0.0
            }else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0.0
                switch self.currentOperation{
                case .add: self.value=doubleToString(num:(runningValue + currentValue))
                case .substract:self.value=doubleToString(num:(runningValue - currentValue))
                case .mutliply:
                    self.value=doubleToString(num:(runningValue * currentValue))
                case .divide:
                    if currentValue == 0.0 {
                        self.value = "ERROR"
                        self.IfFlash = true
                        self.runningNumber=0.0
                        break
                    }
                    self.value=doubleToString(num:(runningValue / currentValue))
                case .none:break
                }
                self.IfFlash=true
                self.runningNumber=0
            }
            
            if button != .equal{
                self.value="0"
            }
            
        case .decimal, .negative, .percent:
            let selfvalue=Double(self.value) ?? 0.0
            if button == .decimal{
                if self.value .contains("."){
                    break
                }else{
                    self.value="\(self.value)\(".")"
                }
            }
            if button == .negative{
                self.value=doubleToString(num:(selfvalue * (-1)))
            }
            if button == .percent{
                self.value=doubleToString(num: selfvalue / 100)
            }
                
        default:
            let number = button.rawValue
            if self.value == "0" || IfFlash == true{
                value=number
                self.IfFlash=false
            }else{
                self.value="\(self.value)\(number)"
            }
        }
    }
    
    //button size
    func buttonWidth(item:CalcuButton) ->CGFloat{
        //double the width of zero button
        if item == .zero{
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4)*2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight(item:CalcuButton) ->CGFloat{
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    //other funtion
    func doubleToString(num: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 99
        
        formatter.numberStyle = .decimal
        
        return formatter.string(from: num as NSNumber) ?? "n/a"
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
