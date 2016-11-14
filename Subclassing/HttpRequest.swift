//
//  HttpRequest.swift
//  Shift
//
//  Created by Jayakumar Radhakrishnan on 6/24/16.
//  Copyright © 2016 Jayakumar Radhakrishnan. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import CoreData
class HttpRequest: NSObject {

}
enum OptionalValue<T> {
    case None
    case Some(T)
}
extension UIViewController{
    func setFetchReques(entityName:String) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
        return request
    }
    func setPredicate(keyName:String, entityName:String) -> NSPredicate {
        
        let resultPredicate = NSPredicate(format: "key = %@", keyName)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "entityName")
        request.predicate = resultPredicate
        return resultPredicate
    }
    func showAlert(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
   
    func getMethodUrl(urlMethod:String,loadingRequired:Bool,success:@escaping (_ result: JSON) -> Void){
        if loadingRequired {
            DispatchQueue.global(qos: .background).async {
                print("This is run on the background queue")
                
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    SVProgressHUD.show()
                    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
                }
            }
    }
       Alamofire.request(Contants.DomainUrl+urlMethod) .responseJSON { response in
            SVProgressHUD.dismiss()
        if response.result.isSuccess{
            print("Validation Successful")
            print(response.response!.statusCode)
            if response.response!.statusCode == 200{
                let jsonResponse =  JSON(data:response.data!)
                if jsonResponse != JSON.null{
                    success(jsonResponse)
  
                }
//                if let JSON = response.result.value {
//                    success(result: JSON)
//                    
//                }
            }else{
                 print("Could not get json from file, make sure that file contains valid json.")
            }
        }else{
            var statusCode = response.response?.statusCode
            if let error = response.result.error as? AFError {
                statusCode = error._code // statusCode private
            }
            if statusCode == -1009{
                self.showAlert(title: "SubClassing", message:(response.result.error!.localizedDescription) )
            }else{
            self.showAlert(title: "SubClassing", message:(response.result.error!.localizedDescription) )
            }

        }
    }
        
    }
//    func postMethodUrl(urlMethod:String,parameter:Dictionary<String, any>  ,success:(result: Any) -> Void)  {
//        SVProgressHUD.show()
//        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
//        Alamofire.request(.POST, Contants.DomainUrl+urlMethod, parameters:parameter)
//            .responseJSON { response in
//                SVProgressHUD.dismiss()
//                print(parameter)
//                switch response.result {
//                case .Success:
//                    print("Validation Successful")
//                    print(response.response!.statusCode)
//                    if response.response!.statusCode == 200{
//                        if let JSON = response.result.value {
//                            print("JSON: \(JSON)")
//                            success(result: JSON)
//                        }
//                    }else{
//                        
//                    }
//                case .Failure(let error):
//                    print(error)
//                    if response.result .error!.code == -1009{
//                        self .showAlert(message: (response.result.error!.localizedDescription))
//                    }else{
//                        self.showAlert(message: (response.result.error!.localizedDescription))
//                    }
//                }
// 
//        }
//    }
    
    
    
    
//    Alamofire.request(urlString)
//    .responseString { response in
//    print("Success: \(response.result.isSuccess)")
//    print("Response String: \(response.result.value)")
//    
//    var statusCode = response.response?.statusCode
//    if let error = response.result.error as? AFError {
//    statusCode = error._code // statusCode private
//    switch error {
//    case .invalidURL(let url):
//    print("Invalid URL: \(url) - \(error.localizedDescription)")
//    case .parameterEncodingFailed(let reason):
//    print("Parameter encoding failed: \(error.localizedDescription)")
//    print("Failure Reason: \(reason)")
//    case .multipartEncodingFailed(let reason):
//    print("Multipart encoding failed: \(error.localizedDescription)")
//    print("Failure Reason: \(reason)")
//    case .responseValidationFailed(let reason):
//    print("Response validation failed: \(error.localizedDescription)")
//    print("Failure Reason: \(reason)")
//    
//    switch reason {
//    case .dataFileNil, .dataFileReadFailed:
//    print("Downloaded file could not be read")
//    case .missingContentType(let acceptableContentTypes):
//    print("Content Type Missing: \(acceptableContentTypes)")
//    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
//    case .unacceptableStatusCode(let code):
//    print("Response status code was unacceptable: \(code)")
//    statusCode = code
//    }
//    case .responseSerializationFailed(let reason):
//    print("Response serialization failed: \(error.localizedDescription)")
//    print("Failure Reason: \(reason)")
//    // statusCode = 3840 ???? maybe..
//    }
//    
//    print("Underlying error: \(error.underlyingError)")
//    } else if let error = response.result.error as? URLError {
//    print("URLError occurred: \(error)")
//    } else {
//    print("Unknown error: \(response.result.error)")
//    }
//    
//    print(statusCode) // the status code
//    }

}
