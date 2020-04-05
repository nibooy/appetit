//
//  appetitTests.swift
//  appetitTests
//
//  Created by Mark Kang on 4/4/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

import XCTest
@testable import appetit
import CoreData
class UserControllerTests: XCTestCase {

    let testEmail = "test@gmail.com"
    let testPassword = "testpassword"
    let testFirstName = "testFirstName"
    let testLastName = "testLastName"
    let testMaxCaloriesPerMeal = 29
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let entity = "User"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "(email  =  %@) AND (password = %@)", testEmail, testPassword)
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignUp(){
        let testUser = UserController()
        let signUpStatus: Bool;
        do{
            signUpStatus = try testUser.saveUser(email: testEmail, password: testPassword, firstName: testFirstName
            , lastName: testLastName, maxCaloriesPerMeal: testMaxCaloriesPerMeal)
        }catch{
            signUpStatus = false
        }
        XCTAssertEqual(true, signUpStatus)
    }
    func testLogIn() {
//         This is an example of a functional test case.
//         Use XCTAssert and related functions to verify your tests produce the correct results.
        let testUser = UserController()
        let logInStatus: Bool;
        do{
            let signUpStatus = try testUser.saveUser(email: testEmail, password: testPassword, firstName: testFirstName
            , lastName: testLastName, maxCaloriesPerMeal: testMaxCaloriesPerMeal)
            if !signUpStatus{
                logInStatus = false
            }else{
                logInStatus = try testUser.isValidUser(email: testEmail, password: testPassword)
            }
        }catch{
            logInStatus = false
        }
        XCTAssertEqual(true, logInStatus)
    }

    func testGetUserInfo() {
        let testUser = UserController()
        do{
            let signUpStatus = try testUser.saveUser(email: testEmail, password: testPassword, firstName: testFirstName
            , lastName: testLastName, maxCaloriesPerMeal: testMaxCaloriesPerMeal)
            let userResult = try testUser.getUser(email: testEmail, password: testPassword)
            XCTAssertEqual(true, signUpStatus)
            XCTAssertEqual(userResult.firstName, testFirstName)
            XCTAssertEqual(userResult.lastName, testLastName)
            XCTAssertEqual(userResult.email, testEmail)
            XCTAssertEqual(userResult.maxCaloriesPerMeal, testMaxCaloriesPerMeal)
        }catch{
        }
    }
    func testPerformance() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
