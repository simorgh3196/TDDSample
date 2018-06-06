//
//  Semver.swift
//  TDDSample
//
//  Created by 早川 智也 on 2018/06/06.
//  Copyright © 2018年 TomoyaHaykawa. All rights reserved.
//

import Foundation

struct Semver: Equatable {

    enum VersionUpType {
        case bugfix
        case addFunctionality
        case incompatibleAPIChange
    }

    let major: UInt
    let minor: UInt
    let patch: UInt

    var version: String {
        return "\(major).\(minor).\(patch)"
    }

    func versionUp(type: VersionUpType) -> Semver {
        switch type {
        case .bugfix:
            return Semver(major: major, minor: minor, patch: patch + 1)
        case .addFunctionality:
            return Semver(major: major, minor: minor + 1, patch: 0)
        case .incompatibleAPIChange:
            return Semver(major: major + 1, minor: 0, patch: 0)
        }
    }
}

func == (lhs: Semver, rhs: Semver) -> Bool {
    return (lhs.major, lhs.minor, lhs.patch) == (rhs.major, rhs.minor, rhs.patch)
}

func > (lhs: Semver, rhs: Semver) -> Bool {
    guard lhs.major == rhs.major else {
        return lhs.major > rhs.major
    }
    guard lhs.minor == rhs.minor else {
        return lhs.minor > rhs.minor
    }
    guard lhs.patch == rhs.patch else {
        return lhs.patch > rhs.patch
    }
    return false
}

func < (lhs: Semver, rhs: Semver) -> Bool {
    return lhs != rhs && !(lhs > rhs)
}

func >= (lhs: Semver, rhs: Semver) -> Bool {
    return lhs == rhs || lhs > rhs
}

func <= (lhs: Semver, rhs: Semver) -> Bool {
    return lhs == rhs || lhs < rhs
}
