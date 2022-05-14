//
//  AccountManager.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/12.
//  Copyright © 2022 鈞. All rights reserved.
//

import UIKit
import AWSMobileClient
import AWSAuthCore
import AWSAuthUI
import AWSS3

// MARK: - Seknova SDK 帳號管理類別
public class AccountManager: NSObject {
    
    public var token: String = "" // 用來存取 Web API 的 Token

    public var signInState: UInt8 = 0 // 當前登入狀態，0 = Success，1 = Error (No specific error description)
    
    /// 使用者登入 (Email 一般登入)
    /// - Parameters:
    ///   - username: String，使用者帳號
    ///   - password: String，使用者設定的密碼
    ///   - finish: @escaping(SignInResult?, String?, Error?, UInt8) -> Void
    ///     - SignInResult?，使用者登入的結果
    ///     - String?，從 AWSMobileClient.default().getTokens 取得的 token
    ///     - Error?，AWSMobileClientError
    ///     - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func UserSignIn(username: String, password: String, finish: @escaping(SignInResult?, String?, Error?, UInt8) -> Void) {
        AWSMobileClient.default().signIn(username: username, password: password) { signInResult, error in
            if let error = error as? AWSMobileClientError {
                print("error:", error)
                self.signInState = 1
                finish(signInResult, "", error, self.signInState)
            } else {
                AWSMobileClient.default().getTokens { (userToken, error) in
                    if let error = error as? AWSMobileClientError {
                        print("error:", error)
                        self.signInState = 1
                        finish(signInResult, "", error, self.signInState)
                    } else {
                        print("token:", userToken?.idToken?.tokenString ?? "")
                        self.token = userToken?.idToken?.tokenString ?? ""
                        self.signInState = 0
                        finish(signInResult, self.token, error, self.signInState)
                    }
                }
            }
        }
    }
    
    /// HostedUIOptions 第三方登入提供商
    /// - Parameters:
    ///   - apple: HostedUIOptions(identityProvider: "SignInWithApple")
    ///   - facebook: HostedUIOptions(scopes: ["openid", "email","profile","aws.cognito.signin.user.admin"], identityProvider: "Facebook")
    ///   - google: HostedUIOptions(scopes: ["openid", "email","profile","aws.cognito.signin.user.admin"], identityProvider: "Google")
    
    /*--------------------------------------------------------------------------------------------------*/
    
    /// 使用者登入 (第三方登入，Sign in with Apple、Facebook、Google)
    /// - Parameters:
    ///   - hostedUIOption: HostedUIOptions，第三方登入提供商
    ///   - navigationController: UINavigationController，用來呈現第三方登入頁面的
    ///   - finish: @escaping(UserState?, String?, Error?, UInt8)
    ///     - UserState?，AWS Cognito 使用者登入狀態
    ///     - String?，從 AWSMobileClient.default().getTokens 取得的 token
    ///     - Error?，AWSMobileClientError
    ///     - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func ShowSignIn(hostedUIOption: HostedUIOptions, navigationController: UINavigationController, finish: @escaping(UserState?, String?, Error?, UInt8) -> Void) {
        AWSMobileClient.default().showSignIn(navigationController: navigationController, hostedUIOptions: hostedUIOption) { (userState, error) in
            if let error = error as? AWSMobileClientError {
                print(error.localizedDescription)
                self.signInState = 1
                finish(userState, "", error, self.signInState)
            }
            print(userState?.rawValue)
            if (AWSMobileClient.default().currentUserState == .signedIn) {
                AWSMobileClient.default().getTokens { (userToken, error) in
                    if let error = error as? AWSMobileClientError {
                        print("error:", error)
                        self.signInState = 1
                        finish(userState, "", error, self.signInState)
                    } else {
                        print("token:", userToken?.idToken?.tokenString ?? "")
                        self.token = userToken?.idToken?.tokenString ?? ""
                        self.signInState = 0
                        finish(userState, self.token, error, self.signInState)
                    }
                }
            }
        }
    }
    
    /// 使用者登出
    public func UserSignOut() {
        AWSMobileClient.default().signOut()
        let identityProvider = AWSCognitoCredentialsProvider()
        if (identityProvider.identityId != nil) { // AWSCognitoCredentialsProvider
            identityProvider.clearKeychain() // 刪除舊的 AWS Cognito ID
            assert(identityProvider.identityId == nil)
        }
    }
    
    /// 使用者註冊
    /// - Parameters:
    ///    - username: String，使用者帳號
    ///    - password: String，使用者設定的密碼
    ///    - locale: String，使用者設定的國籍
    ///    - finish: @escaping(SignUpResult?, Error?, UInt8) -> Void
    ///      - SignUpResult?，使用者註冊的結果
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func UserSignUp(username: String, password: String, locale: String, finish: @escaping(SignUpResult?, Error?, UInt8) -> Void) {
        AWSMobileClient.default().signUp(username: username, password: password, userAttributes: ["locale": locale]) { (signUpResult, error) in
            if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(signUpResult, error, self.signInState)
            } else {
                self.signInState = 0
                finish(signUpResult, error, self.signInState)
            }
        }
    }
    
    /// 使用者驗證碼輸入
    /// - Parameters:
    ///   - username: String，使用者帳號
    ///   - code: String，6 碼驗證碼
    ///   - finish: @escaping(Error?, UInt8) -> Void
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func ConfirmVerifyUser(username: String, code: String, finish: @escaping(Error?, UInt8) -> Void) {
        AWSMobileClient.default().confirmVerifyUserAttribute(attributeName: "phone_number", code: code) { (error) in
            if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(error, self.signInState)
            } else {
                self.signInState = 0
                finish(error, self.signInState)
            }
        }
    }
    
    /// 使用者驗證
    /// - Parameters:
    ///    - username: String，使用者帳號
    ///    - finish: @escaping(SignUpResult?, Error?, UInt8) -> Void
    ///      - SignUpResult?，使用者重送驗證信的結果
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func ResendSignUpVerifyCode(username: String, finish: @escaping(SignUpResult?, Error?, UInt8) -> Void) {
        AWSMobileClient.default().resendSignUpCode(username: username, completionHandler: { (result, error) in
            if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(result, error, self.signInState)
            } else if let signUpResult = result {
                print("驗證碼已寄送: \(signUpResult.codeDeliveryDetails!.deliveryMedium) at \(signUpResult.codeDeliveryDetails!.destination!)")
                self.signInState = 1
                finish(result, error, self.signInState)
            }
        })
    }
    
    /// 使用者忘記密碼觸發驗證碼發送
    /// - Parameters:
    ///   - username: String，使用者帳號
    ///   - finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void
    ///      - ForgotPasswordResult?，忘記密碼的資料
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func ForgotPassword(username: String, finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void) {
        AWSMobileClient.default().forgotPassword(username: username) { (forgotPasswordResult, error) in
            if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(forgotPasswordResult, error, self.signInState)
            } else if let forgotPasswordResult = forgotPasswordResult {
                if (forgotPasswordResult.forgotPasswordState == .confirmationCodeSent) {
                    self.signInState = 0
                    finish(forgotPasswordResult, error, self.signInState)
                } else {
                    self.signInState = 1
                    finish(forgotPasswordResult, error, self.signInState)
                }
//                switch (forgotPasswordResult.forgotPasswordState) {
//                case .confirmationCodeSent:
//                    self.signInState = 0
//                    finish(forgotPasswordResult, error, self.signInState)
//                default:
//                    self.signInState = 1
//                    finish(forgotPasswordResult, error, self.signInState)
//                }
            }
        }
    }
    
    /// 使用者忘記密碼重新設定
    /// - Parameters:
    ///   - username: String，使用者帳號
    ///   - newPassword: String，使用者新設定的密碼
    ///   - confirmCode: String，確認驗證碼
    ///   - finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void
    ///      - ForgotPasswordResult?，忘記密碼的資料
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func ComfirmForgotPassword(username: String, newPassword: String, confirmCode: String, finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void) {
        AWSMobileClient.default().confirmForgotPassword(username: username, newPassword: newPassword, confirmationCode: confirmCode) { (forgotPasswordResult, error) in
            if let forgotPasswordResult = forgotPasswordResult {
                if (forgotPasswordResult.forgotPasswordState == .done) {
                    self.signInState = 0
                    finish(forgotPasswordResult, error, self.signInState)
                } else {
                    self.signInState = 1
                    finish(forgotPasswordResult, error, self.signInState)
                }
//                switch(forgotPasswordResult.forgotPasswordState) {
//                case .done:
//                    self.signInState = 0
//                    finish(forgotPasswordResult, error, self.signInState)
//                default:
//                    self.signInState = 1
//                    finish(forgotPasswordResult, error, self.signInState)
//                }
            } else if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(forgotPasswordResult, error, self.signInState)
            }
        }
    }
    
    /// 使用者修改密碼
    /// - Parameters:
    ///   - username: String，使用者帳號
    ///   - currentPassword: String，使用者目前的密碼
    ///   - newPassword: String，使用者新設定的密碼
    ///   - finish: @escaping(Error?, UInt8) -> Void
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func UserChangePassword(username: String, currentPassword: String, newPassword: String, finish: @escaping(Error?, UInt8) -> Void) {
        AWSMobileClient.default().changePassword(currentPassword: currentPassword, proposedPassword: newPassword) { (error) in
            if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(error, self.signInState)
            } else {
                self.signInState = 0
                finish(error, self.signInState)
            }
        }
    }
    
    /// 取得使用者紀錄之屬性
    /// - Parameters:
    ///    - finish: @escaping([String: String]?, Error?) -> Void
    ///      - [String: String]?，使用者在 AWS 上的屬性
    ///      - Error?，AWSMobileClientError
    public func GetAttribute(finish: @escaping([String: String]?, Error?) -> Void) {
                
        AWSMobileClient.default().getUserAttributes { attributedata, error in
            finish(attributedata, error)
        }
        
    }
    
    /// 更新使用者屬性
    /// - Parameters:
    ///   - input: [String: String]
    ///   - finish: @escaping(Error?, UInt8) -> Void
    ///      - Error?，AWSMobileClientError
    ///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
    public func UpdateAttribute(input: [String: String], finish: @escaping(Error?, UInt8) -> Void) {
        
        let codeDeliveryDetails: UserCodeDeliveryDetails?
        
        AWSMobileClient.default().updateUserAttributes(attributeMap: input) { (codeDeliveryDetails, error) in
            if let error = error as? AWSMobileClientError {
                self.signInState = 1
                finish(error, self.signInState)
            } else {
                self.signInState = 0
                finish(error, self.signInState)
            }
        }
    }
    
    // TODO: - 還缺 continueWith(block: ) 的參數，0318 開會說可以先不用動了
    /// 上傳資料到 S3
    /// - Parameters:
    ///   - data: Data，需要上傳的資料
    ///   - bucket: String，上傳的 S3 的 Bucket 名稱
    ///   - key: String，上傳的 S3 的 Key
    ///   - complete: AWSS3TransferUtilityUploadCompletionHandlerBlock?，上傳完成後執行的 Callback
    /// - Returns: signInState: 0 = Success，1 = Error (No specific error description)
    public func UploadDataToS3(data: Data, bucket: String, key: String, complete: AWSS3TransferUtilityUploadCompletionHandlerBlock?) {
        var progressBlock: AWSS3TransferUtilityProgressBlock?
        
        let expression = AWSS3TransferUtilityUploadExpression()
 
        expression.progressBlock = progressBlock
        
        AWSS3TransferUtility.default().uploadData(data,
                                                  bucket: bucket,
                                                  key: key,
                                                  contentType: "text/plain",
                                                  expression: expression,
                                                  completionHandler: complete)
    }
}
