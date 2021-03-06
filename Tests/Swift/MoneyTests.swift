//
//  MoneyTests.swift
//  iTestMoneyDesignPatternSwift
//
//  Created by Aleksandar Petrov on 7/27/15.
//  Copyright (c) 2015 Aleksandar Petrov. All rights reserved.
//

import UIKit
import XCTest

class MoneyTests: XCTestCase {

    // 
    // Mark: Test Public Read Only Properties
    //
    
    func testCanReadCurrency() {
        let currency            =
            Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let money               =
            Money(amount: NSDecimalNumber(string: "4.23"), currency: currency)
        XCTAssertEqual(money.currency,  currency, "Money currency should match")
    }
    
    func testCanReadAmount() {
        let currency            =
            Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let amount              = NSDecimalNumber(string: "4.23")
        let money               = Money(amount: amount, currency: currency) 
        XCTAssertEqual(money.amount,  amount, "Money amount should match")
    }
    
    //
    // Mark: Test NSDecimalNumber/amount Facade Methods
    //
    
    func testIsZeroReturnsTrue() {
        let money               = Money() 
        XCTAssertTrue(money.isZero(), "Money amount should be zero")
    }
    
    func testIsZeroReturnsFalse() {
        let money               = Money(amount: NSDecimalNumber(string: "4.23")) 
        XCTAssertFalse(money.isZero(), "Money amount should not be zero")
    }
    
    func testIsNegativeReturnsTrue() {
        let money               = Money(amount: NSDecimalNumber(string: "-4.23")) 
        XCTAssertTrue(money.isNegative(), "Money amount should be negative")
    }
    
    func testIsNegativeReturnsFalse() {
        let money               = Money(amount: NSDecimalNumber(string: "4.23")) 
        XCTAssertFalse(money.isNegative(), "Money amount should not be negative")
    }
    
    func testIsPositiveReturnsTrue() {
        let money               = Money(amount: NSDecimalNumber(string: "4.23")) 
        XCTAssertTrue(money.isPositive(), "Money amount should be positive")
    }
    
    func testIsPositiveReturnsFalse() {
        let money               = Money(amount: NSDecimalNumber(string: "-4.23")) 
        XCTAssertFalse(money.isPositive(), "Money amount should not be positive")
    }
    
    func testAbsolute() {
        let money               = Money(amount: NSDecimalNumber(string: "-4.23")) 
        XCTAssertTrue(money.absoluteAmount().isPositive(),
            "Money amount should not be positive")
    }
    
    //
    // MARK: Test Public Static Methods
    //
    
    func testDefaultCurrencyIsUSD() {
        let currency            = Money.defaultCurrency()
        XCTAssertEqual(currency.code, "USD", "Currency code should match")
    }
    
    //
    // MARK: Test Other Public Methods
    //
    
    func testAmountInSubunits() {
        let money               = Money(amount: NSDecimalNumber(string: "4.23"))
        XCTAssertEqual(money.amountInSubunits(), 423, "Subunits amount should match")
    }
    
    func testOneSubunit() {
        let money               = Money()
        let oneSubunit          = NSDecimalNumber(string: "0.01");
        XCTAssertEqual(money.oneSubunit(), oneSubunit, "Smallest subunit should match")
    }
    
    //
    // MARK: Allocate
    //
    
    func testAllocateToRecepients() {
        let money               = Money(amount: NSDecimalNumber(string: "0.05"))
        let array               = money.allocate(2)
        XCTAssertEqual(array[0].amount, NSDecimalNumber(string: "0.03"),
            "First recepient should have 0.03")
        XCTAssertEqual(array[1].amount, NSDecimalNumber(string: "0.02"),
            "Second recepient should have 0.02")
    }
        
    // ??? Test Allocate to Zero Recepients (throws "Division by zero")
    
    func testAllocateToRecepientsUsingRatios() {
        let money               = Money(amount: NSDecimalNumber(string: "1"))
        let array               = money.allocate([70, 30])
        XCTAssertEqual(array[0].amount, NSDecimalNumber(string: "0.70"),
            "First recepient should have 0.70")
        XCTAssertEqual(array[1].amount, NSDecimalNumber(string: "0.30"),
            "Second recepient should have 0.30")
    }
    
    // ??? Test with Zero Ratios (throws "Division by zero")
    
    //
    // MARK: Convert
    //
    
    func testConvertEurosToDollars() {
        let currencyEUR         =
            Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let currencyUSD         =
            Currency.currencyWithCurrencyCode(currencyCode: "USD")!
        let euros               =
            Money(amount: NSDecimalNumber(string: "20"), currency: currencyEUR)
        let exchangeRate        = NSDecimalNumber(string: "1.1234")
        let dollars             = euros.convertTo(currencyUSD, usingExchangeRate: exchangeRate)
        
        XCTAssertEqual(dollars.amount, NSDecimalNumber(string: "22.47"),
            "Dollars amount should be 22.47")
    }
    
    // ??? Test Convert ot Same Currency (throws "Cannot convert to the same currency")
    // ??? Test Convert with negative multiplier 
    // (throws "Cannot convert using a negative conversion multiplier")
    
    //
    // MARK: Initialization
    //
    
    func testCanCreateMoney() {
        let money               = Money()
        XCTAssertNotNil(money, "Could not create money")
    }
    
    func testCanCreateMoneyWithAmountAsDecimal() {
        let money               = Money(amount: NSDecimalNumber(int: 1))
        XCTAssertNotNil(money, "Could not create money with decimal amount")
    }
    
    func testCanCreateMoneyWithAmountAsString() {
        let money               = Money(amount: "1")
        XCTAssertNotNil(money, "Could not create money with string amount")
    }
    
    func testCanCreateMoneyWithAmountAsFormattedString() {
        let money               = Money(amount: "$1")
        XCTAssertNotNil(money, "Could not create money with formatted string amount")
    }
    
    func testCanCreateMoneyWithCurrency() {
        let currency            =
            Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let money               = Money(currency: currency)
        XCTAssertNotNil(money, "Could not create money with currency")
    }
    
    func testCanCreateMoneyWithAmountAsDecimalAndCurrency() {
        let currency            =
            Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let money               =
            Money(amount: NSDecimalNumber(int: 1), currency: currency)
        XCTAssertNotNil(money, "Could not create money with currency")
    }
    
    func testCanCreateMoneyWithAmountAsStringAndCurrency() {
        let currency            =
        Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let money               =
            Money(amount: "1", currency: currency)
        XCTAssertNotNil(money, "Could not create money with currency")
    }
    
    func testCanCreateMoneyWithAmountAsFormattedStringAndCurrency() {
        let currency            =
        Currency.currencyWithCurrencyCode(currencyCode: "EUR")!
        let money               =
            Money(amount: "1 €", currency: currency)
        XCTAssertNotNil(money, "Could not create money with currency")
    }
    
    func testCanCreateMoneyWithBadDecimal() {
        let money               =
            Money(amount: NSDecimalNumber.notANumber())
        XCTAssertNotNil(money, "Could not create money with not a number")
    }
    
    func testCanCreateMoneyWithBadString() {
        let money               =
            Money(amount: "Random &^Ugjh2 string")
        XCTAssertNotNil(money, "Could not create money with random string")
    }
    
    //
    // MARK: Equal
    //
    
    // opertator == is using equals method (??? - no need to be tested)
    func testTwoMoneyObjectsWithSameAmountAndCurrencyAreEqual() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "0.0", currency: currency) 
        let moneyRHS            = Money(amount: "0.0", currency: currency)
        XCTAssertEqual(moneyLHS.equals(moneyRHS) , true, "Money should match")
    }
    
    func testTwoMoneyObjectsWithDifferentAmountAndSameCurrencyAreNotEqual() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "0.0", currency: currency) 
        let moneyRHS            = Money(amount: "15.0", currency: currency) 
        XCTAssertEqual(moneyLHS.equals(moneyRHS), false, "Money should not match")
    }
    
    func testTwoMoneyObjectsWithSameAmountAndDifferentCurrencyAreNotEqual() {
        let currencyLHS         =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let currencyRHS         =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "fr_TN")!
        let moneyLHS            = Money(amount: "0.0", currency: currencyLHS) 
        let moneyRHS            = Money(amount: "0.0", currency: currencyRHS) 
        XCTAssertEqual(moneyLHS.equals(moneyRHS), false, "Money should not match")
    }
    
    func testTwoMoneyObjectsWithDifferentAmountAndDifferentCurrencyAreNotEqual() {
        let currencyLHS         =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let currencyRHS         =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "fr_TN")!
        let moneyLHS            = Money(amount: "0.0", currency: currencyLHS) 
        let moneyRHS            = Money(amount: "13.33", currency: currencyRHS) 
        XCTAssertEqual(moneyLHS.equals(moneyRHS), false, "Money should not match")
    }
    
    //
    // MARK: Comparable
    //
    
    // opertators <=, >=, >, <  are using compare method (??? - no need to be tested)
    func testLeftSideMoneyObjectAmountIsGreaterThanRightSideMoneyObjectAmount() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "15.0", currency: currency)
        let moneyRHS            = Money(amount: "2.0", currency: currency)
        XCTAssertEqual(moneyLHS.compareTo(moneyRHS), NSComparisonResult.OrderedDescending,
            "Money on the left side should have greater amount than  money on the right side")
    }
    
    func testLeftSideMoneyObjectAmmountIsLessThanRightSideMoneyObjectAmount() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "2.0", currency: currency)
        let moneyRHS            = Money(amount: "15.0", currency: currency)
        XCTAssertEqual(moneyLHS.compareTo(moneyRHS), NSComparisonResult.OrderedAscending,
            "Money on the left side should have less amount than  money on the right side")
    }
    
    func testLeftSideMoneyObjectAmmountIsEqualThanRightSideMoneyObjectAmmount() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "2.0", currency: currency)
        let moneyRHS            = Money(amount: "2.0", currency: currency)
        XCTAssertEqual(moneyLHS.compareTo(moneyRHS), NSComparisonResult.OrderedSame,
            "Money on the left side should have same amount than  money on the right side")
    }
    
    //
    // MARK: Arithmetic
    //
    
    func testAddMoney() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "12.0", currency: currency)
        let moneyRHS            = Money(amount: "2.0", currency: currency)
        let result              = moneyLHS.add(moneyRHS)
        XCTAssertEqual(result.amount, NSDecimalNumber(int: 14),
            "Money amount should be $ 14.00")
    }
    
    func testAddAmount() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "12.0", currency: currency)
        let result              = moneyLHS.add(NSDecimalNumber(int: 2))
        XCTAssertEqual(result.amount, NSDecimalNumber(int: 14),
            "Money amount should be $ 14.00")
    }
    
    func testSubtractMoney() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "12.0", currency: currency)
        let moneyRHS            = Money(amount: "2.0", currency: currency)
        let result              = moneyLHS.subtract(moneyRHS)
        XCTAssertEqual(result.amount, NSDecimalNumber(int: 10),
            "Money amount should be $ 10.00")
    }
    
    func testSubtractAmount() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "12.0", currency: currency)
        let result              = moneyLHS.subtract(NSDecimalNumber(int: 2))
        XCTAssertEqual(result.amount, NSDecimalNumber(int: 10),
            "Money amount should be $ 10.00")
    }
    
    
    func testMultiplyByAmount() {
        let currency            =
            Currency.currencyForLocaleIdentifier(localeIdentifier: "en_US")!
        let moneyLHS            = Money(amount: "12.0", currency: currency)
        let result              = moneyLHS.multiply(NSDecimalNumber(int: 2))
        XCTAssertEqual(result.amount, NSDecimalNumber(int: 24),
            "Money amount should be $ 24.00")
    }
    
    // ??? Test Arithmetic operations with NaN
    // ??? Test different currencies exceptions in compare and arithmetic methods
    // ??? Test Unary minus operator (it is based on multiply)
}
