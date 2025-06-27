import CommonCrypto
import Foundation


public class MySDK {
    public init() {}
    public static func loginConnectX(
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ){
        CoreServiceUtilities.login(email: email, password: password) { result in
               completion(result)
           }
    }
    public static func getRecordsConnectX(object:String,payload:[String:Any],completion: @escaping (Result <String, Error>) -> Void) {
        CoreServiceUtilities.getRecords(object: object, payload: payload){ result in
            completion(result)
        }
    }
    
    public static func countRecordsConnectX(object:String,payload:[String:Any],completion: @escaping (Result <String, Error>) -> Void) {
        CoreServiceUtilities.countRecords(object: object, payload: payload){ result in
            completion(result)
        }
    }
    
    public static func createRecordsConnectX(object:String,payload:[String:Any],completion: @escaping (Result <String, Error>) -> Void) {
        CoreServiceUtilities.createRecords(object: object, payload: payload){ result in
            completion(result)
        }
    }
    
    public static func updateRecordsConnectX(object:String,payload:[String:Any],externalId:String, completion: @escaping (Result <String, Error>) -> Void) {
        CoreServiceUtilities.updateRecords(object: object, payload: payload,externalId: externalId ){ result in
            completion(result)
        }
    }
    
    public static func upload(object:String,payload:[String:Any],completion: @escaping ([String:Any]) -> Void){
        CoreServiceUtilities.checkPayload(object: object, payload:payload) { result in
            completion(result)
        }
    }
}
