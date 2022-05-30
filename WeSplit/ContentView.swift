//
//  ContentView.swift
//  WeSplit
//
//  Created by William Mead on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var totalSplits: Int = 2
    @State private var tipPart: Int = 0
    private var shareAmount: Double {
        let splits = Double(totalSplits)
        let tip = checkAmount/100*Double(tipPart)
        let total = checkAmount+tip
        let share = total/splits
        return share
    }
    let tip: Array<Int> = [0, 10, 15, 20, 30]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                        .keyboardType(.decimalPad)
                    Picker("People", selection: $totalSplits) {
                        ForEach(2..<13) {
                            Text("\($0) people").tag($0)
                        }
                    }.pickerStyle(.menu)
                } header: {
                    Text("Check to split")
                }
                Section {
                    Picker("tip", selection: $tipPart) {
                        ForEach(tip, id: \.self) {
                            Text($0, format: .percent).tag($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Leave a tip ?")
                }
                Section {
                    Text(shareAmount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                } header: {
                    Text("Share per person")
                }
            }.navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
