//
//  CPUView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2024/02/06.
//

import SwiftUI
import CoreWafer

struct CPUView: View {
    @ObservedObject var processor: ProcessorObserver
    let coreTypeInfo = CoreTypeInformation()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Usage") {
                    HStack {
                        Spacer()
                        WafersView(processor: processor)
                            .scaleEffect(0.65)
                            
                        Spacer()
                    }
                }
                
//                Section("Total Usage") {
//                    ListRow(key: "CPU",
//                            value: String(format: "%.2f",  "\(processor.overallUsage.user + processor.overallUsage.system)") + "%")
//                }
                
//                Section("Each Core") {
//                    ForEach(processor.coreUsages.indices, id: \.self) { index in
//                        let processorType = index < coreTypeInfo.efficiencyCoreCount ? "Efficiency" : "Performance"
//                        let coreUsage = processor.coreUsages[index]
//                        ListRow(key: "\(processorType) \(index + 1)",
//                                value: String(format: "%.2f", "\(coreUsage.user + coreUsage.system)") + "%")
//                    }
//                }
            }
            .navigationTitle("CPU")
            .onAppear {
                processor.start()
            }
        }
    }
}

#Preview {
    CPUView(processor: ProcessorObserver())
}
