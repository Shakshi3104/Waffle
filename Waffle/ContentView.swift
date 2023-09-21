//
//  ContentView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2023/09/21.
//

import SwiftUI
import CoreWafer

// MARK: -
struct ListRow: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: -
struct ContentView: View {
    @ObservedObject var processor = ProcessorObserver()
    private let deviceInfo = DeviceInfo.shared
    
    var body: some View {
        NavigationStack {
            List {
                Section("CPU") {
                    WafersView(processor: processor)
                        .scaleEffect(0.65)
                        .onAppear {
                            processor.start()
                        }
                }
                
                Section("Device") {
                    ListRow(key: "Device", value: deviceInfo.device)
                    ListRow(key: "Model Identifier", value: deviceInfo.modelIdentifier)
                    ListRow(key: "OS", value: deviceInfo.os)
                    ListRow(key: "Processor", value: deviceInfo.processor)
                    ListRow(key: "CPU", value: deviceInfo.cpu)
                    ListRow(key: "GPU", value: deviceInfo.gpu)
                    ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
                    ListRow(key: "RAM", value: deviceInfo.ramString)
                }
                
            }
            .navigationTitle("Waffle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
