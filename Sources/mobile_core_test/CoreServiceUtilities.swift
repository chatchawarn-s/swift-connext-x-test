import CommonCrypto
import Foundation
import UIKit

public class CoreServiceUtilities {
    public static func login(
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ){
  
        let keyString = password + email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) + "Vmh;{v]M[pJqJMC2-bj@R<ZYeMred0BT,aHL*QYhPD5/wj%/^hVz4J=Ts$,+%:SS"
        let messageData = Data()

        guard let keyData = keyString.data(using: .utf8) else {
            return 
        }
   
           var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))

           messageData.withUnsafeBytes { messageBytes in
               keyData.withUnsafeBytes { keyBytes in
                   CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1),
                          keyBytes.baseAddress, keyData.count,
                          messageBytes.baseAddress, messageData.count,
                          &digest)
               }
           }
            let hexString = digest.map { String(format: "%02hhx", $0) }.joined()
            CoreServiceAPI.loginAPI(email: email, password: hexString) { result in
                switch result {
                case .success(let response):
                    if let data = response.data(using: .utf8),
                       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            CoreServiceStorage.save(key: "ConnectxLocalStorage", value: jsonString)
                        }
                        completion(.success(response))
                    } else {
                        let parseError = NSError(domain: "InvalidJSON", code: 0, userInfo: [NSLocalizedDescriptionKey: "Cannot parse response"])
                        completion(.failure(parseError))
                    }
                case .failure(let error):
                    print("❌ API Failed:", error.localizedDescription)
                    completion(.failure(error))
                }
            }

       }
    
    public static func getRecords(object: String,payload: [String:Any], completion : @escaping (Result<String, Error>) -> Void){
        CoreServiceAPI.getRecordAPI(object: object, payload: payload) { result in
            completion(result)
        }
    }
    
    public static func countRecords(object: String,payload: [String:Any], completion : @escaping (Result<String, Error>) -> Void){
        CoreServiceAPI.countRecordAPI(object: object, payload: payload) { result in
            completion(result)
        }
    }
    
    public static func createRecords(object: String,payload: [String:Any], completion : @escaping (Result<String, Error>) -> Void){
        checkPayload(object: object, payload: payload) { resultPayload in
            CoreServiceAPI.createRecordAPI(object: object, payload: resultPayload) { result in
                completion(result)
            }
        }
    }
    
    public static func updateRecords(object: String,payload: [String:Any], externalId:String, completion : @escaping (Result<String, Error>) -> Void){
        checkPayload(object: object, payload: payload) { resultPayload in
            CoreServiceAPI.updateRecordAPI(object: object, payload: resultPayload, externalId: externalId) { result in
                completion(result)
            }
        }
    }
    
    
    public static func checkPayload(
        object: String,
        payload: [String: Any],
        completion: @escaping ([String: Any]) -> Void
    ) {
        
        var newPayload = payload
        let keys = Array(payload.keys)
        var didComplete = false
        
        func processNext(index: Int) {
            if index >= keys.count {
                if !didComplete {
                    didComplete = true
              
                    completion(newPayload)
                } else {
                  
                }
                return
            }

            let key = keys[index]
            let value = payload[key]

            if let strValue = value as? String, getPathType(strValue) == true {
                CoreServiceAPI.uploadImageAPI(object: object, base64Image: strValue) { result in
                    switch result {
                    case .success(let jsonString):
                        if let data = jsonString.data(using: .utf8),
                           let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let url = json["url"] as? String {
                            newPayload[key] = url
                        }
                    case .failure(let error):
                        print("❌ Upload failed for key: \(key): \(error.localizedDescription)")
                    }
                    processNext(index: index + 1)
                }
            } else {
                processNext(index: index + 1)
            }
        }
        processNext(index: 0)
    }
    
    public static func getPathType(_ path: String) -> Bool {
        guard let data = Data(base64Encoded: path) else {
            return false
        }
        
        if let _ = UIImage(data: data) {
            return true
        }
        
        return false
    }
}
