//
//  UtilityView.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2024/06/16.
//

import SwiftUI

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
