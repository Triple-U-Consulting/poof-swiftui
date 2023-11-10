//
//  APIEndpoints.swift
//  Poof
//
//  Created by Angela Christabel on 12/10/23.
//

import Foundation

struct APIEndpoints {
    // MARK: - Pages
    static func getHomeData(token: String) -> Endpoint<HomeDataResponseDTO> {
        let headerParameters = ["accesstoken": token]
        
        return Endpoint(path: "page/home", method: .get, headerParameters: headerParameters)
    }
    
    // MARK: - Authentication
    static func login(email: String, password: String) -> Endpoint<MessageResponseDTO> {
        let bodyParameters = UserLoginRequestDTO(email: email, password: password)
        
        return Endpoint(path: "auth/login", method: .post, bodyParametersEncodable: bodyParameters)
    }
    
    static func register(email: String, password: String) -> Endpoint<UserResponseDTO> {
       // let newDob = DateFormatUtil.shared.dateToString(date: dob, to: "yyyy-MM-dd")
        let requestDTO = UserRequestDTO(email: email, password: password)
        return Endpoint(path: "auth/register", method: .post, bodyParametersEncodable: requestDTO)
    }
    
    // MARK: - Kambuh
    static func getKambuh() -> Endpoint<KambuhResponseDTO> {
        return Endpoint(path: "kambuh", method: .get)
    }
    
    static func getKambuhById(id: Int) -> Endpoint<KambuhResponseDTO> {
        let queryParameters = ["id": id]
        
        return Endpoint(path: "kambuh", method: .get, queryParameters: queryParameters)
    }
    
    static func getKambuhByDate(date: Date) -> Endpoint<KambuhResponseDTO>{
        let requestDate = DateFormatUtil().dateToString(date: date, to: "yyyy-MM-dd")
        let queryParam = ["date": requestDate]
        //let requestDTO = DateRequestDTO(date: requestDate)
        
        return Endpoint(path: "data/kambuh/date", method: .get, queryParameters: queryParam)
    }
    
    static func getKambuhByMonthYear(date: Date) -> Endpoint<KambuhResponseDTO> {
        let requestDate = DateFormatUtil().dateToString(date: date, to: "yyyy-MM-dd")
        let queryParam = ["date": requestDate]
        
        return Endpoint(path: "data/kambuh/month", method: .get, queryParameters: queryParam)
    }
    
    static func updateKambuhCondition(kambuh_id: [Int], scale: [Int], trigger: [Bool]) -> Endpoint<MessageResponseDTO> {
        var bodyParameters: [ConditionRequestDTO.ConditionKambuh] = []
        for i in 0..<kambuh_id.count {
            let requestKambuh_id = kambuh_id[i]
            let requestScale = scale[i]
            let requestTrigger = trigger[i]
            let req = ConditionRequestDTO.ConditionKambuh(kambuh_id: requestKambuh_id, scale: requestScale, trigger: requestTrigger)
            bodyParameters.append(req)
        }
        let requestDTO = ConditionRequestDTO(allValuetoUpdate: bodyParameters)
        print(requestDTO)
        
        return Endpoint(path: "data/update/condition", method: .put, bodyParametersEncodable: requestDTO)
    }
    
    // MARK: - Inhaler
    static func updateUserInhalerId(id: String, token: String) -> Endpoint<MessageResponseDTO> {
        let bodyParameters = ["inhaler_id": id]
        let headerParameters = ["accesstoken": token]
        
        return Endpoint(path: "auth/update/inhaler", method: .put, bodyParameters: bodyParameters, headerParameters: headerParameters)
    }
    
    // MARK: - IOT
    static func getIoTInhalerId() -> Endpoint<IoTResponseDTO> {
        return Endpoint(path: "http://192.168.4.1/device-id", isFullPath: true, method: .get)
    }
    
    static func postWiFiDetails(ssid: String, password: String) -> Endpoint<MessageResponseDTO> {
            let bodyParameters = ["ssid": ssid, "password": password]
            print(ssid, password)
            return Endpoint(path: "http://192.168.4.1:80/config-wifi",
                            isFullPath: true,
                            method: .post,
                            bodyParameters: bodyParameters)
        }
    
    // MARK: - Analytics
    static func getAnalytics(start_date: Date, frequency: String) -> Endpoint<AnalyticsResponseDTO> {
        let start_date = DateFormatUtil().dateToString(date: start_date, to: "yyyy-MM-dd")
        let queryParameters = ["start_date": start_date, "frequency": frequency]
        print(queryParameters)
//        return Endpoint(path: "http://192.168.100.52:3000/data/analytics",
//                                    isFullPath: true,
//                                    method: .get,
//                        queryParameters: queryParameters)
        return Endpoint(path: "data/analytics", method: .get, queryParameters: queryParameters)
    }

}
