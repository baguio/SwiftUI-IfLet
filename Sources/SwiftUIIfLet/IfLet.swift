//
//  IfLet.swift
//  SwiftUI-IfLet
//
//  Created by baguio on 12/4/19.
//  Copyright © 2019 baguio. All rights reserved.
//

import SwiftUI

public struct IfLet<T, Out: View, EmptyOut: View>: View {
    let value: T?
    let produce: (T) -> Out
    let produceIfNil: () -> EmptyOut

    public init(_ value: T?,
         _ produce: @escaping (T) -> Out,
         else produceIfNil: @escaping () -> EmptyOut)
    {
        self.value = value
        self.produce = produce
        self.produceIfNil = produceIfNil
    }

    public var body: some View {
        Group {
            if value != nil {
                produce(value!)
            } else {
                produceIfNil()
            }
        }
    }
}

public extension IfLet where EmptyOut == EmptyView {
    init (_ value: T?,
          _ produce: @escaping (T) -> Out) {
        self.init(value, produce, else: {
            return EmptyView()
        })
    }
}

struct IfLet_Preview: PreviewProvider {
    static let lol : String? = nil
    
    static var previews: some View {
        VStack {
            IfLet(IfLet_Preview.lol) { nlol in
                VStack {
                    Text("This won't appear because the variable used is nil")
                    Text(nlol)
                }
            }
            IfLet(IfLet_Preview.lol, { nlol in
                Text(nlol)
            }, else: {
                Text("This text will appear, since the variable used is nil")
            })
        }.previewLayout(.sizeThatFits)
            .padding(10)
    }
}
