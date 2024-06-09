//
//  FeatureUITests.swift
//  FortuneViewUITests.swift
//
//  Created by Taichi on 2024/06/08.
//

import XCTest

final class FortuneViewUITests: XCTestCase {
    func testBackNavigationTrigger_sendされるとFortuneResultViewからFortuneViewに遷移すること() {
        let app = XCUIApplication()
        app.launch()

        // 名前を入力
        let textField = app.textFields["Enter your name"]
        textField.tap()
        textField.typeText("Hoge")

        // FortuneResultView に遷移
        app.buttons["Check Fortune!"].tap()

        // viewModel.backNavigationTrigger.send() する
        app.buttons["Send backNavigationTrigger"].tap()

        // アラートが表示されること
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists)

        // アラートの OK ボタンをタップすると FortuneView に戻っていること
        alert.buttons["OK"].tap()
        XCTAssertTrue(app.buttons["Check Fortune!"].exists)
    }
}

