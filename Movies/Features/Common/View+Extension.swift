//
//  View+Extension.swift
//  Movies
//
//  Created by Dániel Novák on 23/01/2024.
//

import SwiftUI

extension View {
    func oneTimeTask(_ action: @escaping () async -> Void) -> some View {
        modifier(OneTimeTaskViewModifier(action: action))
    }
}
