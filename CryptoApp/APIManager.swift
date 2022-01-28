//
//  APIManager.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//
import UIKit
import Alamofire


final class APIManager
{
    static let shared = APIManager()
    
    func makeRequest<T: Decodable>(_ request: GorodAPIBaseRequest, responseType: T.Type, completion: @escaping (T)->Void) {
        makeAlamofireRequest(request).responseJSON { (dataResponse) in
            do {
                guard let data = dataResponse.data else {
                    self.displayError(title: LocalizationNames.error, message: dataResponse.error?.errorDescription)
                    return
                }
                
                let decoder = JSONDecoder()
                
                let model = try decoder.decode(T.self, from: data)
                let s = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("🚀", s)
                completion(model)
            }
            catch
            {
                print(error)
                self.displayError(title: request.getEndPoint(), message: error.localizedDescription)
                
               
                return
            }
        }
    }
    
    private func decode<T: Decodable>(_ data: Data, as responseType: T.Type) -> T?
    {
        let decoder = JSONDecoder()
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let model = try? decoder.decode(T.self, from: data)
        
        return model
    }
    
    private func makeAlamofireRequest(_ request: GorodAPIBaseRequest) -> DataRequest
    {
        let endPoint = request.getBaseURL() + request.getEndPoint()
        let method = request.getMethod().httpMethod
        let params = request.getParams()
//        let headers = self.requestHeaders()
        return AF.request(endPoint, method: method, parameters: params, headers: [])
//        return Alamofire.request(endPoint, method: method, parameters: params, headers: [])
//        return Alamofire.request
    }
    
    
    
    private func displayError(title: String?, message: String?)
    {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        UIApplication.shared.keyWindow
        UIApplication.shared.keyWindow?.visibleViewController?.present(alert, animated: true)
    }
    
    enum Method
    {
        case get
        case post
        case delete
        
        var httpMethod: HTTPMethod
        {
            switch self
            {
                case .get: return .get
                case .post: return .post
                case .delete: return .delete
            }
        }
    }
}

protocol GorodAPIBaseRequest
{
    func getEndPoint() -> String
    func getMethod() -> APIManager.Method
    func getParams() -> [String: Any]
    func getBaseURL() -> String
    
//    var cancelationGroup: String? {get}
}

extension GorodAPIBaseRequest
{
    func getMethod() -> APIManager.Method
    {
        return .get
    }
    
    func getParams() -> [String : Any]
    {
        return [:]
    }
    
    func getBaseURL() -> String
    {
        return APIConstants.baseUrl
    }
}

final class CustomRequest: GorodAPIBaseRequest
{
    private let url: String
    private let method: APIManager.Method
    private let params: [String : Any]
    
    init(_ url: String, method: APIManager.Method = .get, params: [String : Any] = [:])
    {
        self.url = url
        self.method = method
        self.params = params
    }
    
    func getEndPoint() -> String
    {
        return url
    }
    
    func getMethod() -> APIManager.Method
    {
        return method
    }

    func getParams() -> [String : Any]
    {
        return params
    }
}

enum GorodResponse <S: Decodable, E: Decodable>
{
    case success(S)
    case error(E)
    case none
}
//
//class ApiService {
//
//    static let shared = ApiService()
//
//
//
//    func handleErrors(_ response: URLResponse?, _ error: Error?) -> Errors? {
//        guard let response = response as? HTTPURLResponse,
//            error == nil else {
//                return .serverNotFound
//        }
//
//        if response.statusCode == 200 {
//            return nil
//        }
//
//        if response.statusCode == 404 {
//            return .serverNotFound
//        }
//
//        if response.statusCode == 400 {
//            return .badResponse
//        }
//
//        if response.statusCode == 401 {
//            return .tokenExpired
//        }
//
//        return .unknown
//    }
//}
//
//enum Errors {
//    case undefined
//    case unknown
//    case serverNotFound
//    case accessDenied
//    case badResponse
//    case tokenExpired
//    case forceUpdate
//
//    var message: String {
//        var errMessage = "Ошибка системы."
//
//        switch self {
//        case .undefined:
//            errMessage = "Неизвестная ошибка."
//        case .unknown, .badResponse:
//            errMessage = "Сервер вернул ошибку. \nПовторите попытку позже."
//        case .serverNotFound:
//            errMessage = "Не удается подключиться к серверу. \nПроверьте соединение."
//        case .accessDenied:
//            errMessage = "Не верный логин или пароль. \nПроверте правильность введенных данных."
//        case .tokenExpired:
//            errMessage = "Ошибка аутентификации. \nОсуществите повторный вход в приложение."
//        case .forceUpdate:
//            errMessage = "Необходимо выполнить обновление. Перейдите в AppStore."
//        }
//
//        return errMessage
//    }
//}
//
//extension ApiService {
//    func getProfileStatus(completion: @escaping (_ profileStatus: AssetModel?, _ error: Errors?) -> Void) {
//
//        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)assets/?limit=10")!)
//        request.configure(.get)
//
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let error = self.handleErrors(response, error) {
//                completion(nil, error)
//                return
//            }
//
//            guard let data = data else {
//                completion(nil, .serverNotFound)
//                return
//            }
//
//            // MARK: - ПОЛУЧИТЬ ЧИСТЫЙ JSON
//            let s = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//            print("🔥", s)
//
//            do {
//                let status = try JSONDecoder().decode(AssetModel.self, from: data)
//                completion(status, nil)
//            } catch {
//                print(error)
//                completion(nil, nil)
//            }
//        }
//
//        task.resume()
//    }
//}
//    extension URLRequest {
//        mutating func configure(
//            _ method: HttpMethod,
//            _ parameters: [String: Any?]? = nil
//        ) {
//
//            self.httpMethod = method.rawValue
//            if let strongParameters = parameters, !strongParameters.isEmpty {
//                self.httpBody = try? JSONSerialization.data(withJSONObject: strongParameters)
//            }
//        }
//    }
//    enum HttpMethod: String {
//        case post = "POST"
//        case get = "GET"
//        case put = "PUT"
//    }
