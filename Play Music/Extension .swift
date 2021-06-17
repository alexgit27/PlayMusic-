//
//  Extension .swift
//  Play Music
//
//  Created by Alexandr on 12.06.2021.
//

import Foundation

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
