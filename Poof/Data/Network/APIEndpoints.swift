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
    
    static func getKambuhIfScaleAndTriggerIsNull() -> Endpoint<KambuhResponseDTO> {
        return Endpoint(path: "data/kambuh/scale-trigger/null", method: .get)
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
    
    static func updateKambuhCondition(kambuh: [Kambuh]) -> Endpoint<MessageResponseDTO> {
        var bodyParameters: [ConditionRequestDTO.ConditionKambuh] = []
        for k in kambuh {
            let requestKambuh_id = k.id
            let requestScale = k.scale
            let requestTrigger = k.trigger
            let req = ConditionRequestDTO.ConditionKambuh(kambuh_id: requestKambuh_id, scale: requestScale, trigger: requestTrigger)
            bodyParameters.append(req)
        }
        let requestDTO = ConditionRequestDTO(allValueToUpdate: bodyParameters)
        print(requestDTO)
        
        return Endpoint(path: "data/update/condition", method: .put, bodyParametersEncodable: requestDTO)
    }
    
    static func deleteKambuhData(kambuh_id: Int) -> Endpoint<MessageResponseDTO>{
        return Endpoint(path: "data/delete/data/\(kambuh_id)", method: .delete)
    }
    
    // MARK: - Inhaler
    static func updateUserInhalerId(id: String, token: String) -> Endpoint<MessageResponseDTO> {
        let bodyParameters = ["inhaler_id": id]
        let headerParameters = ["accesstoken": token]
        
        return Endpoint(path: "auth/update/inhaler", method: .put, bodyParameters: bodyParameters, headerParameters: headerParameters)
    }
    
    static func updateInhalerBottle(id: String, dose: Int) -> Endpoint<MessageResponseDTO> {
        let bodyParameters = ["remaining_puff": dose]
        
        return Endpoint(path: "inhaler/update/remaining-inhaler/\(id)", method: .put, bodyParameters: bodyParameters)
    }
    
    // MARK: - IOT
    static func getIoTInhalerId() -> Endpoint<IoTResponseDTO> {
        return Endpoint(path: "http://192.168.4.1/device-id", isFullPath: true, method: .get)
    }
    
    static func postWiFiDetails(ssid: String, password: String) -> Endpoint<MessageResponseDTO> {
            let bodyParameters = ["ssid": ssid, "password": password]
            print(ssid, password)
            return Endpoint(path: "http://192.168.4.1/config-wifi",
                            isFullPath: true,
                            method: .post,
                            bodyParameters: bodyParameters)
        }
    
    // MARK: - Analytics
    static func getAnalytics(start_date: Date, frequency: String) -> Endpoint<AnalyticsResponseDTO> {
        let start_date = DateFormatUtil().dateToString(date: start_date, to: "yyyy-MM-dd")
        let queryParameters = ["start_date": start_date, "frequency": frequency]
        return Endpoint(path: "data/analytics", method: .get, queryParameters: queryParameters)
    }
    
    static func getSummary(start_date: Date) -> Endpoint<SummaryResponseDTO> {
        let start_date = DateFormatUtil().dateToString(date: start_date, to: "yyyy-MM-dd")
        let queryParameters = ["start_date": start_date]
        return Endpoint(path: "data/summary", method: .get, queryParameters: queryParameters)
    }

}
