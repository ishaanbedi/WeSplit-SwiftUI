//
//  ContentView.swift
//  WeSplit
//
//  Created by Ishaan Bedi on 02/01/22.
//

import SwiftUI

struct ContentView: View {
    @State private var baseAmount = 0.0
    @State private var people = 0
    @State private var tipPercentage = 0
    @State private var tipPercentages = [0,10,15,20,25]
    @FocusState private var focusedKeyboard: Bool
    var amountPerPerson: Double {
        let totalPeople = Double(people+2)
        let tip = Double(tipPercentage)
        let tipValue = baseAmount / 100 * tip
        let grandTotal = baseAmount + tipValue
        let perPerson = grandTotal/totalPeople
        return perPerson
    }
    var totalAmount: String {
        let tip = Double(tipPercentage)
        let tipValue = baseAmount / 100 * tip
        let grandTotal = baseAmount + tipValue
        let totalText: String =  String(format: "%.2f", grandTotal)
        return totalText
    }
    var body: some View {
        NavigationView{
            
        
        Form{
            TextField("Enter amount to split", value: $baseAmount, format: .currency(code: "USD"))
                .keyboardType(.decimalPad)
                .focused($focusedKeyboard)
            Picker("Number of people", selection: $people){
                ForEach(2..<26){
                    Text("\($0)")
                }
            }
            Section {
                Picker("Tip percentage", selection: $tipPercentage ){
                    ForEach (tipPercentages,id: \.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("How much tip you'd like to leave?")
            }
            Section{
                Text(amountPerPerson, format: .currency(code:"USD"))
            } header: {
                Text("Amount per person:")
            
            }
            Section{
                Text("$\(totalAmount)")
            } header : {
                Text("Total amount")
            }
        }
        .navigationTitle("WeSplit")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done"){
                    focusedKeyboard = false
                }
            }

        }

                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
