//
//  ContentView.swift
//  WeSplit
//
//  Created by William Mead on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double? = nil
    @State private var totalSplits: Int = 2
    @State private var tipPart: Int = 0
    @FocusState private var checkAmountFocused: Bool
    private var tipAmount: Double {
        let tipPart = Double(tipPart)/100
        return (checkAmount ?? 0)*tipPart
    }
    private var totalAmount: Double {
        return (checkAmount ?? 0)+tipAmount
    }
    private var shareAmount: Double {
        let splits = Double(totalSplits)
        let share = totalAmount/splits
        return share
    }
    let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "EUR")
    let tip: Array<Int> = [0, 10, 15, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    var body: some View {
        NavigationView {
            ZStack {
                Color.cyan.ignoresSafeArea()
                Form {
                    Section {
                        HStack {
                            TextField("Amount", value: $checkAmount, format: currency, prompt: Text("Check Amount"))
                                .keyboardType(.decimalPad)
                                .focused($checkAmountFocused)
                        }
                    } header: {
                        HStack {
                            Spacer()
                            Text("🖋 Check").foregroundColor(.white)
                            Spacer()
                        }
                    }
                    Section {
                        HStack {
                            Text("Tipping").foregroundColor(.secondary)
                            Spacer()
                            Text(tipAmount, format: currency)
                            Spacer()
                            Picker("tip", selection: $tipPart) {
                                ForEach(tip, id: \.self) {
                                    Text($0, format: .percent).tag($0)
                                }
                            }.pickerStyle(.menu)
                        }
                    } header: {
                        HStack {
                            Spacer()
                            Text("🪙 Tip").foregroundColor(.white)
                            Spacer()
                        }
                    }
                    Section {
                        HStack {
                            Text("Check + Tip").foregroundColor(.secondary)
                            Spacer()
                            Text(totalAmount, format: currency).foregroundColor(tipPart == 0 ? .red : .green)
                        }
                    } header: {
                        HStack {
                            Spacer()
                            Text("🧾 Total").foregroundColor(.white)
                            Spacer()
                        }
                    }
                    Section {
                        HStack {
                            Text("Split by").foregroundColor(.secondary)
                            Spacer()
                            Picker("People", selection: $totalSplits) {
                                ForEach(2..<13) {
                                    Text("\($0) people").tag($0)
                                }
                            }.pickerStyle(.menu)
                        }
                        HStack {
                            Text("Pay \(totalSplits)x").foregroundColor(.secondary)
                            Spacer()
                            Text(shareAmount, format: currency).bold()
                        }
                    } header: {
                        HStack {
                            Spacer()
                            Text("🤝 Share").foregroundColor(.white)
                            Spacer()
                        }
                    }
                }.navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            checkAmountFocused = false
                        }
                    }
                }
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = .clear
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
