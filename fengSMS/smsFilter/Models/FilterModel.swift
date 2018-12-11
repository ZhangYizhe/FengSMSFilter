//
//  FilterModel.swift
//  smsFilter
//
//  Copyright © 2018 com.feng. All rights reserved.
//

import Foundation

class FilterModel {
    
    func get(message: String) -> String {
        let model = sms() //引入机器学习模型
        
        guard let output = try? model.prediction(text: message) else { //传入内容并获取结果，若出现错误则返回错误
            return "运行错误"
        }
        
        return output.label //返回结果，我们直接返回了结果中的标签字段，这个字段是string类型的
    }
    
}
