//
//  Widgets.swift
//  Widgets
//
//  Created by Matteo Visotto on 08/05/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetModel {
        WidgetModel(date: Date(), products: WidgetManager.getFakeData())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetModel) -> ()) {
        let entry = WidgetModel(date: Date(), products: WidgetManager.getFakeData())
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WidgetModel>) -> Void) {
        let next = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
        WidgetManager.loadData { products in
            let timeline = Timeline(entries: [WidgetModel(date: Date(), products: products)], policy: .after(next!))
            completion(timeline)
        }
    }
}

struct myAPTrackerWidgetView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            WidgetSmall(entry: entry)
        case .systemMedium:
            WidgetMedium(entry: entry)
            //WidgetSmall(entry: entry)
        case .systemLarge:
            WidgetLarge(entry: entry)
        default:
            EmptyView()
        }
    }
    
}

@main
struct Widgets: Widget {
    let kind: String = "Widgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            myAPTrackerWidgetView(entry: entry)
        }
        .configurationDisplayName("myAPTracker")
        .description("Monitor your products easily")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Widgets_Previews: PreviewProvider {
    static var previews: some View {
        myAPTrackerWidgetView(entry: WidgetModel(date: Date(), products: WidgetManager.getFakeData()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
