//
//  CPUView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2024/02/06.
//

import SwiftUI
import CoreWafer

#if os(iOS)
struct CPUView: View {
    @ObservedObject var processor: ProcessorObserver
    let coreTypeInfo = CoreTypeInformation()
    let coreTypeStyle = DeviceInfo.shared.coreTypeStyle
    
    var body: some View {
        NavigationStack {
            List {
                Section("Usage") {
                    HStack {
                        Spacer()
                        WafersView(processor: processor,
                                   efficiencyCoreColor: coreTypeStyle.lowerColor,
                                   performanceCoreColor: coreTypeStyle.upperColor)
                            .scaleEffect(0.65)
                            
                        Spacer()
                    }
                }
                
                Section("Total Usage") {
                    ListRow(key: "CPU",
                            value: String(format: "%.2f",  processor.overallUsage.user + processor.overallUsage.system) + "%")
                }
                
                Section("Each Core") {
                    ForEach(processor.coreUsages.indices, id: \.self) { index in
                        let processorType = index < coreTypeInfo.efficiencyCoreCount ? coreTypeStyle.lowerLabel : coreTypeStyle.upperLabel
                        let coreUsage = processor.coreUsages[index]
                        ListRow(key: "\(processorType) \(index + 1)",
                                value: String(format: "%.2f", coreUsage.user + coreUsage.system) + "%")
                    }
                }
            }
            .navigationTitle("CPU")
            .onAppear {
                processor.start()
            }
        }
    }
}


#elseif os(macOS) || targetEnvironment(macCatalyst)
struct CPUView: View {
    @ObservedObject var processor: ProcessorObserver
    let coreTypeInfo = CoreTypeInformation()
    let coreTypeStyle = DeviceInfo.shared.coreTypeStyle
    
    var body: some View {
        ScrollView {
            GroupBox {
                HStack {
                    Spacer()
                    WafersView(processor: processor,
                               efficiencyCoreColor: coreTypeStyle.lowerColor,
                               performanceCoreColor: coreTypeStyle.upperColor)
                        .scaleEffect(0.65)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            GroupBox {
                ListRow(key: "CPU",
                        value: String(format: "%.2f",  processor.overallUsage.user + processor.overallUsage.system) + "%")
                .padding(4)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            GroupBox {
                ForEach(processor.coreUsages.indices, id: \.self) { index in
                    let processorType = index < coreTypeInfo.efficiencyCoreCount ? coreTypeStyle.lowerLabel : coreTypeStyle.upperLabel
                    let coreUsage = processor.coreUsages[index]
                    ListRow(key: "\(processorType) \(index + 1)",
                            value: String(format: "%.2f", coreUsage.user + coreUsage.system) + "%")
                    .padding(4)
                    if index != processor.coreUsages.indices.last {
                        Divider()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onAppear {
            processor.start()
        }
    }
}

#endif

#Preview {
    CPUView(processor: ProcessorObserver())
}
