import Foundation

@objc public class MyFrameworkClass: NSObject {
    @objc public static func echoFromFramework() -> String {
        return "Hello from Swift 4.2!";
    }
}


public func highOrderFunction() -> String { "Hello from High Order Function in Swift 4.2" };
