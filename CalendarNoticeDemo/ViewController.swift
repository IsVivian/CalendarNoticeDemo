//
//  ViewController.swift
//  CalendarNoticeDemo
//
//  Created by sherry on 16/6/27.
//  Copyright © 2016年 sherry. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    let titleName = "生日提醒"
    let address = "上海市浦东新区"
    let startDate = "2016-06-27 15:37"
    let endDate = "2016-06-27 15:39"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func addBtnAct(sender: AnyObject) {
        
        let eventStore = EKEventStore()
        eventStore.requestAccessToEntityType(.Event) { (granted, error) in
            
            do {
            
                if error != nil {
                    
                    //添加错误
                    return
                    
                }else if !granted {
                    
                    //无访问日历权限
                    return
                    
                }else {
                    
                    let event = EKEvent(eventStore: eventStore)
                    event.title = self.titleName
                    event.location = self.address
                    
                    //起止时间
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let startTime = formatter.dateFromString(self.startDate)
                    let endTime = formatter.dateFromString(self.endDate)
                    
//                    print("startTime: \(startTime)")
//                    print("endTime: \(endTime)")
                    
                    event.startDate = startTime!
                    event.endDate = endTime!
                    
                    //在事件前多少秒开始事件提醒
                    let alarm = EKAlarm()
                    alarm.relativeOffset = -60.0
                    event.addAlarm(alarm)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    let result: ()? = try eventStore.saveEvent(event, span: .ThisEvent)
                    
                    if result != nil {
                    
                        print("已成功添加到日历")
                    
                    }
                    
                }
            } catch {
            
                print("error")
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

