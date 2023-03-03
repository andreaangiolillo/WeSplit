//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrea on 01/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var nOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    
    private let currency = Locale.current.currency?.identifier ?? "USD"
    private var c :FloatingPointFormatStyle<Double>.Currency = .currency(code: currency)
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totPerPerson : Double{
        return getTotAmount() / Double(nOfPeople + 2)
    }
    
    func getTotAmount() -> Double{
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: currency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $nOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(getTotAmount(), format: .currency(
                        code: currency))
                } header: {
                    Text("Total Amount")
                }
                
                Section{
                    Text(totPerPerson, format: .currency(
                        code: currency))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
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
