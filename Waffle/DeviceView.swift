//
//  DeviceView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2024/02/06.
//

import SwiftUI

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
                ListRow(key: "Efficiency Cores",
                        value: "\(deviceInfo.efficiencyCore)-core")
                ListRow(key: "Performance Cores",
                        value: "\(deviceInfo.performanceCore)-core")
                
                ListRow(key: "GPU", value: deviceInfo.gpu)
                
                ListRow(key: "Neural Engine", value: deviceInfo.neuralEngine)
                
                ListRow(key: "RAM", value: deviceInfo.ramString)
                
                #if os(iOS)
                ListRow(key: "DynamicIsland", value: (deviceInfo.hasDynamicIsland ?? false) ? "Yes" : "No")
                #endif
            }
            .navigationTitle("Device")
        }
    }
}

#Preview {
    DeviceView(deviceInfo: DeviceInfo.shared)
}
