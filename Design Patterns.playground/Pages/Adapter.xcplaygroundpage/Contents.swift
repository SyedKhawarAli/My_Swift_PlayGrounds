import EventKit
// MARK: Adapter design pattern -> it transforms the interface of an object to adapt it to a different object. -> wrapper

// our target protocol
protocol Event {
    var title: String { get }
    var startDate: String { get }
    var endDate: String { get }
}

// adapter (wrapper class)
class EventAdapter {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd. HH.mm"
        return dateFormatter
    }()

    private var event: EKEvent

    init(event: EKEvent) {
        self.event = event
    }
}

// actual adapter implementation
extension EventAdapter: Event {
    var title: String {
        return event.title
    }

    var startDate: String {
        return dateFormatter.string(from: event.startDate)
    }

    var endDate: String {
        return dateFormatter.string(from: event.endDate)
    }
}

// let's create an EKEvent adaptee instance
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"

let calendarEvent = EKEvent(eventStore: EKEventStore())
calendarEvent.title = "Adapter tutorial deadline"
calendarEvent.startDate = dateFormatter.date(from: "07/30/2021 10:00")
calendarEvent.endDate = dateFormatter.date(from: "07/30/2021 11:00")

// Now we can use adapter class as event protocol, instead of EKEvent
let adapter = EventAdapter(event: calendarEvent)
print("Title: \(adapter.title), Start date: \(adapter.startDate), End Date: \(adapter.endDate)")

