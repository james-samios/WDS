import Foundation

public enum HTTPMethod{
    
    case post,get
}


public final class Fetcher{
    
    public static let baseURL = "http://wds.samios.io/worlddomination/"
    
    public static var userID:String!{
        
        return UserDefaults.standard.string(forKey: "wd-userID")
    }
    
    public class func saveSecurityCode(_ email:String,code:String, completion:@escaping(_ result:Any)->Swift.Void){
        
        
        self.request(self.baseURL, postParam: ["email":email,"code":code,"method":"saveCode"], method: .post) { (any) in
            
            completion(any)
        }
    }
    
    public class func getVerificationCode(_ email:String,completion:@escaping(_ result:Any)->Swift.Void){
        
        
        self.request(self.baseURL, postParam: ["email":email,"method":"getCode"], method: .post) { (any) in
            
            completion(any)
        }
    }
    
    public class func clearUser(_ email:String, completion:@escaping(_ result:Any)->Swift.Void){
        
        self.request(self.baseURL, postParam: ["email":email,"method":"clearUser"], method: .post) { (any) in
            
            completion(any)
        }
    }
    
    private class func request(_ urlString:String,postParam:Any?,method:HTTPMethod,completion:@escaping(_ data:Any)->Void){
        
        
        if let url = URL(string:urlString){
            
            var request = URLRequest(url: url)
            request.httpMethod = method == .post ? "POST" : "GET"
            
            if let postParam = postParam as? [String:String]{
                
                var bodyString:String?
                for (key,value) in postParam{
                    
                    bodyString = bodyString == nil ? key+"="+value : bodyString!+"&"+key+"="+value
                }
                
                if let postString = bodyString{
                    
                    request.httpBody = postString.data(using: .utf8)
                }
            }else if let postParam = postParam as? Data{
                
                request.httpBody = postParam
            }
            
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async(execute: {
                    
                    guard error == nil else{
                        
                        completion(error?.localizedDescription ?? "Unexpected error occured!")
                        return
                    }
                    
                    if let data = data{
                        
                        do{
                            
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            completion(json)
                            
                        }catch{
                            print("===============Error===================")
                            print("Error: \(error.localizedDescription)")
                            let stringValue = String(data: data, encoding: .utf8)
                            print("Received data: \(stringValue)")
                            print("===============End Error===================")
                            completion(error)
                        }
                    }else{
                        completion("Data wasn't received from request!")
                    }
                })
            })
            
            task.resume()
            
        }else{
            completion("Invalid URL")
        }
        
    }
    
}
