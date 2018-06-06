//
//  SemverTest.swift
//  TDDSampleTests
//
//  Created by 早川 智也 on 2018/06/06.
//  Copyright © 2018年 TomoyaHaykawa. All rights reserved.
//

import XCTest
@testable import TDDSample

class SemverTestCase: XCTestCase {

    var semver1_2_3: Semver!
    var semver2_3_4: Semver!

    override func setUp() {
        semver1_2_3 = Semver(major: 1, minor: 2, patch: 3)
        semver2_3_4 = Semver(major: 2, minor: 3, patch: 4)
    }
}

class SemverPrintVersionTest: SemverTestCase {

    func testバージョン1_2_3を出力する() {
        XCTAssertEqual("1.2.3", semver1_2_3.version)
    }
}

class SemverEquatableTest: SemverTestCase {

    func test同じバージョンのオブジェクトが等しい() {
        let _semver1_2_3 = Semver(major: 1, minor: 2, patch: 3)
        XCTAssertEqual(true, semver1_2_3 == _semver1_2_3)
    }

    func test違うバージョンのオブジェクトは等しくない() {
        XCTAssertEqual(false, semver1_2_3 == semver2_3_4)
    }
}

class SemverCompareTest: SemverTestCase {

    func testオブジェクト同士で大なり比較() {
        XCTAssertEqual(true, semver2_3_4 > semver1_2_3)
    }

    func testオブジェクト同士で小なり比較() {
        XCTAssertEqual(true, semver1_2_3 < semver2_3_4)
    }
}

class SemverCompareEqualTest: SemverTestCase {

    func testオブジェクト同士で大なりイコール比較() {
        XCTAssertEqual(true, semver2_3_4 >= semver1_2_3)
    }

    func testオブジェクト同士で小なりイコール比較() {
        XCTAssertEqual(true, semver1_2_3 <= semver2_3_4)
    }
}

class SemverVersionUpTest: SemverTestCase {

    func testバグ修正バージョンアップを行うとpatchをインクリメント() {
        let semver = semver1_2_3.versionUp(type: .bugfix)
        XCTAssertEqual(1, semver.major)
        XCTAssertEqual(2, semver.minor)
        XCTAssertEqual(4, semver.patch)
    }

    func test下位互換性のある機能追加を行うとminorをインクリメントしpatchをゼロ() {
        let semver = semver1_2_3.versionUp(type: .addFunctionality)
        XCTAssertEqual(1, semver.major)
        XCTAssertEqual(3, semver.minor)
        XCTAssertEqual(0, semver.patch)
    }

    func test破壊的変更を含む機能追加を行うとmajorをインクリメントminorとpatchをゼロ() {
        let semver = semver1_2_3.versionUp(type: .incompatibleAPIChange)
        XCTAssertEqual(2, semver.major)
        XCTAssertEqual(0, semver.minor)
        XCTAssertEqual(0, semver.patch)
    }
}
