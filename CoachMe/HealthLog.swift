//
//  HealthLog.swift
//  CoachMe
//
//  Created by duaa mohammed on 30/05/2023.
//


import SwiftUI
import HealthKit
import HealthKitUI
struct HealthLog: View {
    @State private var autherized = false
        @State private var steps : [Step] = [Step]()
        @State private var calories : [Calorie] = [Calorie]()
        @State private var heartRate : [HeartRate] = [HeartRate]()
        @State private var heartRate2 : Double = 0.0
    @State var exerciseTime = 0
        @State private var activities : [Activity] = [Activity]()
        @State private var stepCount :Int = 0
        @State private var CaloreiCount :Int = 0
        @State private var rateCount :Int = 0
        @State private var ActivtyCount :Int = 0

     
        @State var percentage: Double = 0.25

        
        var animation: Animation {
            Animation.easeInOut(duration: 1)
        }
        
        
        
        
        
        private var healthStore : HealthStore?
        init(){
            healthStore = HealthStore()
        }
        private func updateUIFromSteps (_ statsicsCollection :HKStatisticsCollection){
            let startDate = Date()
            let endDate = Date()
            statsicsCollection.enumerateStatistics(from: startDate, to: endDate){
                (statstics , stop )
                in let count = statstics.sumQuantity()?.doubleValue(for: .count())
                let step = Step(count: Int(count ?? 0), date: statstics.startDate)
                steps.append(step)
                
            }
            
        }
        private func updateUIFromCalories (_ statsicsCollection :HKStatisticsCollection){
            let startDate = Date()
            let endDate = Date()
            statsicsCollection.enumerateStatistics(from: startDate, to: endDate){
                (statstics , stop )
                in let count = statstics.sumQuantity()?.doubleValue(for: .kilocalorie())
                let calorie = Calorie(calories: Int(count ?? 0), date: statstics.startDate)
                calories.append(calorie)
                
            }
            
        }
        private func updateUIFromRate (_ statsicsCollection :HKStatisticsCollection){
            let startDate = Date()
            let endDate = Date()
            statsicsCollection.enumerateStatistics(from: startDate, to: endDate){
                (statstics , stop )
                in let count = statstics.sumQuantity()?.doubleValue(for: .count())
                let rate = HeartRate(heartRate:Int(count ?? 0), date: statstics.startDate)
                heartRate.append(rate)
                
                
            }
            
        }
        private func updateUIFromActivity (_ statsicsCollection :HKStatisticsCollection){
            let startDate = Calendar.current.date(byAdding: .day, value: -7 , to: Date())!
            print(startDate)
            let endDate = Date()
            statsicsCollection.enumerateStatistics(from: startDate, to: endDate){
                (statstics , stop )
                in
                
                let count = statstics.averageQuantity()?.doubleValue(for:HKUnit.minute())
                let activity = Activity(min:Int(count ?? 0), date: statstics.startDate)
                activities.append(activity)
                
                
            }
            
        }

        var body: some View {
            
            VStack{
                if autherized {
                    VStack {
                        VStack (alignment: .leading){
                            Text("Health Log").modifier(MainTitle())
                            Text("Steps For Today").modifier(SubTitle())
                          
                            
                            
                        }
                        //            ZStack{
                        //                Circle().trim(from: 0 , to: CGFloat(stepCount)).stroke(Color("primary"), lineWidth: 10).frame(width:200 , height: 200)
                        //                Circle().trim(from: CGFloat(stepCount) , to: CGFloat( 8000 )).stroke(Color("gray").opacity(0.05)  , lineWidth: 10).frame(width:200 , height: 200)
                        //            }
                        PieChartView(percentage: percentage, stepCount: stepCount)
                        VStack{
                            VStack(alignment: .leading){
                                Text("Calories Burned").modifier(SubTitle2())
                                CalorieView(calories: CaloreiCount)
                                
                            }.padding(.bottom,10)
                            VStack(alignment: .leading){
                                Text("Heart Rate").modifier(SubTitle2())
                                RateView(heartRate: heartRate2)
                            }
                        }.padding()
                        
                        
                    }}else {
                        VStack{
                            Text("to see your health log here please accept permsion")
                        }.padding()
                    }
                Spacer()
           
            }.onAppear {
                Task {
                    if let healthStore = healthStore {
                        await healthStore.requestAuteraziation {
                            sucess in
                            if sucess {
                                
                                self.getExerciseTime(){ time in

                                    self.exerciseTime = Int(time)
                                           }
                                self.autherized = true
                              getTodaysHeartRates()
                                healthStore.calcualteSteps{ statisticCollection in
                                    if let statisticCollection = statisticCollection {
                                        updateUIFromSteps(statisticCollection)
                                        stepCount = steps[0].count
                                        percentage = Double(stepCount * 100)
                                        
                                        percentage = percentage / 8000
                                        percentage = percentage / 100
                                     
                                    }
                                    
                                }
                                healthStore.calcualteCalories{ statisticCollection in
                                    if let statisticCollection = statisticCollection {
                                        updateUIFromCalories(statisticCollection)
                                        CaloreiCount = calories[0].calories
                                        
                                    }
                                    
                                }
                                healthStore.calcualteHeartRate{ statisticCollection in
                                    if let statisticCollection = statisticCollection {
                                        updateUIFromRate(statisticCollection)
                                        rateCount = heartRate[0].heartRate
                                        print (statisticCollection)
                                    }
                                    
                                }
                                healthStore.calcualteActivitey{
                                    statisticCollection in
                                    if let statisticCollection = statisticCollection {
                                        updateUIFromActivity(statisticCollection)
                                        ActivtyCount = activities[1].min
                                        print(activities)
                                    }
                                }

                                
                            }
                        }
    //                    let s = await healthStore.readWorkouts()
    //                    let m = await healthStore.getWorkoutRoute(workout: (s?.first!)!)
    //                    print(m?.debugDescription)
    //                    print(m?.description)
    //                    print(m?.first.debugDescription)
    //                    print(m?.first?.description)
                    }
                }
                
            }
        }
        
        
        
        
        
        
        
        /*Method to get todays heart rate - this only reads data from health kit. */
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        let heartRateType:HKQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
            @State var heartRateQuery:HKSampleQuery?
        func getTodaysHeartRates()  {
            //predicate
            let calendar = Calendar.current
            let now = Date()
            let health: HKHealthStore = HKHealthStore()

            let components = calendar.dateComponents([.year, .month, .day], from: now as Date)
            
            guard let startDate:NSDate = calendar.date(from: components) as NSDate? else { return }
            var dayComponent    = DateComponents()
            dayComponent.day    = 1
            let endDate:NSDate? = calendar.date(byAdding: dayComponent, to: startDate as Date) as NSDate?
            let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate as Date?, options: [])
            
            //descriptor
            let sortDescriptors = [
                NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            ]
            
            heartRateQuery = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 25, sortDescriptors: sortDescriptors, resultsHandler: { (query, results, error) in
                guard error == nil else { print("error"); return }
                
                self.printHeartRateInfo(results: results)
                
            }) //eo-query
          
           
            health.execute(heartRateQuery!)
     
            
         }//eom

        /*used only for testing, prints heart rate info */
        private func printHeartRateInfo(results:[HKSample]?)
        {
            for (_, sample) in results!.enumerated() {
                guard let currData:HKQuantitySample = sample as? HKQuantitySample else { return }
               heartRate2 = currData.quantity.doubleValue(for: heartRateUnit)
    //            print("Heart Rate: \(currData.quantity.doubleValue(for: heartRateUnit))")
    //            print("quantityType: \(currData.quantityType)")
    //            print("Start Date: \(currData.startDate)")
    //            print("End Date: \(currData.endDate)")
    //            print("Metadata: \(currData.metadata)")
    //            print("UUID: \(currData.uuid)")
    //            print("Source: \(currData.sourceRevision)")
            }//eofl
        }//eom



    func getExerciseTime(completion: @escaping (Double) -> Void) {
      

        /*
         let now = Date()
         let startOfDay = Calendar.current.startOfDay(for: now)
         let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
         */
        var healthStore:HKHealthStore?
        var now = Date()
       var startOfDay = Calendar.current.startOfDay(for: now)
        let ActivityType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!

        let daily = DateComponents(day: 1)
        let anchore = Date.mondayAt12AM()
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay,end: now,options: .strictStartDate)
      
        let query = HKStatisticsQuery(quantityType: ActivityType, quantitySamplePredicate: predicate, options: .cumulativeSum ) { (_, result, error) in
            var resultCount = 0.0



            guard let result = result else {
                //log.error("Failed to fetch steps = \(error?.localizedDescription ?? "N/A")")
                completion(resultCount)

                return
            }

            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.minute())


            }

            
                completion(resultCount)
                print("Exercise time : \(resultCount)")

        }

        healthStore?.execute(query)


    }
        
        
    }
    
    
    
    
    

struct HealthLog_Previews: PreviewProvider {
    static var previews: some View {
        HealthLog()
    }
}
