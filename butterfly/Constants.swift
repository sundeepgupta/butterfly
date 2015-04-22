import Foundation

public typealias Success = () -> ()
public typealias Failure = (NSError) -> ()

public struct Constants {
    public static let storyboardName = "Main"
}

public struct Keys {
    public static let email = "emailKey"
    public static let errorHash = "errorHashKey"
    public static let errorMessage = "errrorMessageKey"
}