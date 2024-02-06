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
    
    var body: some View {
        NavigationStack {
            List {
                Section("Usage") {
                    HStack {
                        Spacer()
                        WafersView(processor: processor)
                            .scaleEffect(0.65)
                            .onAppear {
                                processor.start()
                            }
                        Spacer()
                    }
                }
            }
            .navigationTitle("CPU")
        }
    }
}

#Preview {
    CPUView(processor: ProcessorObserver())
}
