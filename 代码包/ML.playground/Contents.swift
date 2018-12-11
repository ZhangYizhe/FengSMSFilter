import Cocoa
import CreateML
import NaturalLanguage

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/Desktop/data.json"))
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,textColumn: "text",labelColumn: "label")

// 评估准确性百分比
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

//验证模型
let sentimentPredictor = try NLModel(mlModel: sentimentClassifier.model)
sentimentPredictor.predictedLabel(for: "亲爱的会员，NIKE特别呈上11.11精选产品系列")

//导出模型
let metadata = MLModelMetadata(author: "feng",shortDescription: "短信过滤器",version: "1.0")
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/Desktop/sms.mlmodel"),metadata: metadata)
