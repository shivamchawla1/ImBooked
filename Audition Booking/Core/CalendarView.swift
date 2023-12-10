//
//  CalendarView.swift
//  Audition Booking
//
//  Created by Shivam Chawla on 30/10/23.
//

import Foundation
import SwiftUI

struct CalendarView : UIViewRepresentable {
    let interval : DateInterval
    @Binding var haveStar : [String]
    @Binding var selectedDate : Date
    @Binding var showCalendar : Bool
    @Binding var updateDateCalendar : Bool

    @Binding var updateStar : String

    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        view.tintColor = UIColor(Color.blue)
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        
        return view
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    class Coordinator : NSObject , UICalendarViewDelegate , UICalendarSelectionSingleDateDelegate {
        
        var parent : CalendarView
        
        init(parent: CalendarView) {
            self.parent = parent
        }
        
        
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            
            if parent.haveStar.contains("\(dateCal(dateP: "\(dateComponents.date ?? Date())"))") {
                return .image(UIImage(systemName: "star.fill"),color: .yellow , size: .large)
            }else{
                return nil
            }
            
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
          
            parent.updateStar = "\(calendarView.visibleDateComponents.month ?? 0)"

        }
      
//        func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
//           
//            parent.updateStar = "\((previousDateComponents.month ?? 0) + 1)"
//        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.selectedDate = dateComponents?.date ?? Date()
            parent.updateDateCalendar.toggle()
            parent.showCalendar.toggle()
            
        }
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
        
        func dateCal(dateP : String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

            if let inputDate = dateFormatter.date(from: dateP) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let formattedDate = dateFormatter.string(from: inputDate)
                return formattedDate // Output: "2023-10-28"
            } else {
                return ""
            }
        }
        
    }
}
