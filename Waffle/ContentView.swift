//
//  ContentView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2023/09/21.
//

import SwiftUI
import CoreWafer
import DeviceHardware



// MARK: -
struct ContentView: View {
    @ObservedObject var processor = ProcessorObserver()
    private let deviceInfo = DeviceInfo.shared
    
    var body: some View {
        if #available(iOS 18, macOS 15, *) {
            TabView {
                Tab("CPU", systemImage: "cpu") {
                    CPUView(processor: processor)
                }
                Tab("Device", systemImage: getDeviceIcon()) {
                    DeviceView(deviceInfo: deviceInfo)
                }
            }
            .tabViewStyle(.sidebarAdaptable)
        } else {
            TabView {
                CPUView(processor: processor)
                    .tabItem {
                        Label("CPU", systemImage: "cpu")
                    }

                DeviceView(deviceInfo: deviceInfo)
                    .tabItem {
                        Label("Device", systemImage: getDeviceIcon())
                    }
            }
        }
    }
}

// MARK: - Change the device icon for each OS
func getDeviceIcon() ->  String {
#if targetEnvironment(macCatalyst) || os(macOS)
    // TODO: Change the device icon for each Mac series via DeviceHardware
    let macDeivce = MacDeviceHardware.deviceHardware
    let macModelName = macDeivce.modelName
    
    if macModelName.contains("iMac") {
        return "desktopcomputer"
    } else if macModelName.contains("Mac mini") {
        return "macmini"
    } else if macModelName.contains("Mac Studio") {
        return "macstudio"
    } else if macModelName.contains("Mac Pro") {
        return "macpro.gen3"
    } else if macModelName.contains("MacBook") {
        return "macbook"
    } else {
        return "laptopcomputer"
    }
#else
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        return "iphone"
    case .pad:
        return "ipad"
    default:
        return "ipod"
    }
#endif
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
