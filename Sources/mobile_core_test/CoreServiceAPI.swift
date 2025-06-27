import Foundation

public class CoreServiceAPI {
    static let base_URL = URL(string: "https://backend.connect-x.tech/connectx/api")!
    
    public static func loginAPI(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let urlString = base_URL.absoluteString + "/auth/login/"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "password": password,
            "stayLogin":"true"
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                let dataError = NSError(domain: "InvalidData", code: 0, userInfo: nil)
                completion(.failure(dataError))
                return
            }
            
            completion(.success(responseString))
        }
        
        task.resume()
    }
    
    public static func getRecordAPI(object:String,payload:[String:Any],completion: @escaping (Result<String, Error>) -> Void){
        let urlString = base_URL.absoluteString + "/object/" + object + "/getRecords"

        guard let url = URL(string: urlString) else {
                   completion(.failure(URLError(.badURL)))
                   return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
                
        do {
            let headers = try getHeaders()
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                let dataError = NSError(domain: "InvalidData", code: 0, userInfo: nil)
                completion(.failure(dataError))
                return
            }
            
            completion(.success(responseString))
        }
        
        task.resume()
    }
    
    public static func countRecordAPI(object:String,payload:[String:Any],completion: @escaping (Result<String, Error>) -> Void){
        let urlString = base_URL.absoluteString + "/object/" + object + "/countRecords"

        guard let url = URL(string: urlString) else {
                   completion(.failure(URLError(.badURL)))
                   return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
                
        do {
            let headers = try getHeaders()
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                let dataError = NSError(domain: "InvalidData", code: 0, userInfo: nil)
                completion(.failure(dataError))
                return
            }
            
            completion(.success(responseString))
        }
        
        task.resume()
    }
    
    public static func createRecordAPI(object:String,payload:[String:Any],completion: @escaping (Result<String, Error>) -> Void){
        let urlString = base_URL.absoluteString + "/object/" + object

        guard let url = URL(string: urlString) else {
                   completion(.failure(URLError(.badURL)))
                   return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
                
        do {
            let headers = try getHeaders()
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                let dataError = NSError(domain: "InvalidData", code: 0, userInfo: nil)
                completion(.failure(dataError))
                return
            }
            
            completion(.success(responseString))
        }
        task.resume()
    }
    
    
    public static func updateRecordAPI(object:String,payload:[String:Any],externalId:String,completion: @escaping (Result<String, Error>) -> Void){
        let urlString = base_URL.absoluteString + "/object/" + object + "?externalId=" + externalId

        guard let url = URL(string: urlString) else {
                   completion(.failure(URLError(.badURL)))
                   return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
                
        do {
            let headers = try getHeaders()
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                let dataError = NSError(domain: "InvalidData", code: 0, userInfo: nil)
                completion(.failure(dataError))
                return
            }
            
            completion(.success(responseString))
        }
        task.resume()
    }
    
    public static func uploadImageAPI(
        object: String,
        base64Image: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        print("uploadImageAPI")
        guard
            let token = CoreServiceStorage.read(key: "ConnectxLocalStorage"),
            let tokenData = token.data(using: .utf8),
            let profile = try? JSONSerialization.jsonObject(with: tokenData) as? [String: Any],
            let organizeId = profile["organizeId"] as? String,
            let imageData = Data(base64Encoded: base64Image)
        else {
            completion(.failure(NSError(domain: "UploadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing data"])))
            return
        }
        
        let url = URL(string: "\(base_URL.absoluteString)/storage/uploadFile")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let path = "Organizes/\(organizeId)/objects/\(object)"
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"file.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
        body.append("Content-Disposition: form-data; name=\"path\"\r\n\r\n".data(using: .utf8)!)
        body.append(path.data(using: .utf8)!)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        
       let task = URLSession.shared.dataTask(with: request) { data,response, error in
           if let httpResponse = response as? HTTPURLResponse {
                    print("📬 [Response Status]: \(httpResponse.statusCode)")
                }

                if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        completion(.success(responseString))
                    } else {
                        completion(.failure(NSError(domain: "InvalidData", code: 0)))
                    }
                } else {
                    completion(.failure(NSError(domain: "NoData", code: 0)))
                }
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = String(data: data, encoding: .utf8) {
                completion(.success(response))
            } else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
            }
        }
        
        task.resume()
    }

    
    
    public static func getHeaders() throws -> [String: String] {
        guard let profile = CoreServiceStorage.read(key: "ConnectxLocalStorage") else {
               throw NSError(domain: "HeaderBuilder", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"])
           }
        guard let jsonData = profile.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
              let accessToken = json["access_token"] as? String else {
            throw NSError(domain: "HeaderBuilder", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token parsing failed"])
        }
        return [
               "Authorization": "Bearer \(accessToken)",
               "Content-Type": "application/json; charset=utf-8"
           ]
    }
}
