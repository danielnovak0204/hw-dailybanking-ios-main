//
//  OneTimeTaskViewModifier.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

import SwiftUI

struct OneTimeTaskViewModifier: ViewModifier {
    let action: () async -> Void
    @State private var isFired = false
    
    func body(content: Content) -> some View {
        content
            .task {
                if !isFired {
                    await action()
                    isFired = true
                }
            }
    }
}
