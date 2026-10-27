//
//  DeviceView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2024/02/06.
//

import SwiftUI

#if os(iOS)
struct DeviceView: View {
    let deviceInfo: DeviceInfo
    
    var body: some View {
        NavigationStack {
            List {
                ListRow(key: "Device", value: deviceInfo.device)
                
                ListRow(key: "Model Identifier", value: deviceInfo.modelIdentifier)
                ListRow(key: "OS", value: deviceInfo.os)
                
                ListRow(key: "Processor", value: deviceInfo.processor)
                
                ListRow(key: "CPU", value: deviceInfo.cpu)
                ListRow(key: "\(deviceInfo.coreTypeStyle.lowerLabel) Cores",
                        value: "\(deviceInfo.efficiencyCore)-core")
                ListRow(key: "\(deviceInfo.coreTypeStyle.upperLabel) Cores",
                        value: "\(deviceInfo.performanceCore)-core")
                
                ListRow(key: "GPU", value: deviceInfo.gpu)
                
                ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
                
                ListRow(key: "RAM", value: deviceInfo.ramString)

                ListRow(key: "Dynamic Island", value: (deviceInfo.hasDynamicIsland ?? false) ? "Yes" : "No")
            }
            .navigationTitle("Device")
        }
    }
}
#elseif os(macOS) || targetEnvironment(macCatalyst)
struct DeviceView: View {
    let deviceInfo: DeviceInfo
    
    var body: some View {
        ScrollView {
            GroupBox {
                ListRow(key: "Device", value: deviceInfo.device)
                    .padding(4)
                Divider()
                
                ListRow(key: "Model Identifier", value: deviceInfo.modelIdentifier)
                    .padding(4)
                Divider()
                
                ListRow(key: "OS", value: deviceInfo.os)
                    .padding(4)
                Divider()
                
                ListRow(key: "Processor", value: deviceInfo.processor)
                    .padding(4)
                Divider()
                
                ListRow(key: "CPU", value: deviceInfo.cpu)
                    .padding(4)
                Divider()
                
                ListRow(key: "\(deviceInfo.coreTypeStyle.lowerLabel) Cores",
                        value: "\(deviceInfo.efficiencyCore)-core")
                    .padding(4)
                Divider()
                
                ListRow(key: "\(deviceInfo.coreTypeStyle.upperLabel) Cores",
                        value: "\(deviceInfo.performanceCore)-core")
                    .padding(4)
                Divider()
                
                ListRow(key: "GPU", value: deviceInfo.gpu)
                    .padding(4)
                Divider()
                
                ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
                    .padding(4)
                Divider()
                
                ListRow(key: "RAM", value: deviceInfo.ramString)
                    .padding(4)
            }
            .padding(.horizontal)
        }
    }
}
#endif

#Preview {
    DeviceView(deviceInfo: DeviceInfo.shared)
}
