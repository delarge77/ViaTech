//
//  ReverseMappable.swift
//  ViaPlay-TechTest
//
//  Created by Alessandro dos Santos Pinto on 22/03/2017.
//  Copyright © 2017 Alessandro dos Santos Pinto. All rights reserved.
//

import Foundation

public protocol ReverseMappable {
    func toJSON() -> Any?
}

extension Float: ReverseMappable {
    public func toJSON() -> Any? {
        return self
    }
}

extension Double: ReverseMappable {
    public func toJSON() -> Any? {
        return self
    }
}

extension Int: ReverseMappable {
    public func toJSON() -> Any? {
        return self
    }
}

extension String: ReverseMappable {
    public func toJSON() -> Any? {
        return self
    }
}

extension Bool: ReverseMappable {
    public func toJSON() -> Any? {
        return self
    }
}

extension URL: ReverseMappable {
    public func toJSON() -> Any? {
        return absoluteString
    }
}

extension Optional where Wrapped: ReverseMappable {
    public func toJSON() -> Any? {
        return flatMap { $0.toJSON() }
    }
}

extension Optional where Wrapped: Sequence, Wrapped.Iterator.Element: ReverseMappable {
    public func toJSON() -> Any? {
        return flatMap { array in
            array.flatMap { $0.toJSON() }
        }
    }
}

extension Array where Element: ReverseMappable {
    public func toJSON() -> Any? {
        return flatMap { $0.toJSON() }
    }
}

extension NSDictionary: ReverseMappable {
    public func toJSON() -> Any? {
        return self
    }
}

extension ReverseMappable where Self: RawRepresentable, Self.RawValue: ReverseMappable {
    public func toJSON() -> Any? {
        return rawValue.toJSON()
    }
}
