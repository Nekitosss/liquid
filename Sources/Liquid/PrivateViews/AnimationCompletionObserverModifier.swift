//
//  File.swift
//  
//
//  Created by Nikita Patskov on 05.05.2021.
//

import Foundation
import SwiftUI

struct AnimationCompletionShape<Value: VectorArithmetic>: Shape {
    
    var animatableData: Value {
        get { tmpValue }
        set {
            tmpValue = newValue
            if tmpValue == value {
                DispatchQueue.main.async(execute: handler)
            }
        }
    }
    
    let value: Value
    let handler: () -> Void
    var tmpValue: Value
    
    init(value: Value, handler: @escaping () -> Void) {
        self.value = value
        self.handler = handler
        self.tmpValue = value
    }
    
    func path(in rect: CGRect) -> Path {
        .init()
    }
    
}

extension View {

    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, handler: @escaping () -> Void) -> some View {
        background(AnimationCompletionShape(value: value, handler: handler))
    }
}
