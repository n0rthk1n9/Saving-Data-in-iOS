/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Combine
import Foundation

class TaskStore: ObservableObject {
    let tasksJSONURL = URL(fileURLWithPath: "PrioritizedTasks", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    let tasksPropertyListURL = URL(fileURLWithPath: "PrioritizedTasks", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("plist")

    @Published var prioritizedTasks: [PrioritizedTasks] = [
        PrioritizedTasks(priority: .high, tasks: []),
        PrioritizedTasks(priority: .medium, tasks: []),
        PrioritizedTasks(priority: .low, tasks: []),
        PrioritizedTasks(priority: .no, tasks: [])
    ] {
        didSet {
            saveJSONPrioritizedTasks()
            savePlistPrioritizedTasks()
        }
    }

    init() {
        loadJSONPrioritizedTasks()
        loadPlistPrioritizedTasks()
    }

    func getIndex(for priority: Task.Priority) -> Int {
        prioritizedTasks.firstIndex { $0.priority == priority }!
    }

    private func loadJSONPrioritizedTasks() {
        guard FileManager.default.fileExists(atPath: tasksJSONURL.path) else {
            return
        }

        print(Bundle.main.bundleURL)
        print(FileManager.documentsDirectoryURL)

        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        print(temporaryDirectoryURL)

        print((try? FileManager.default.contentsOfDirectory(atPath: FileManager.documentsDirectoryURL.path)) ?? [])

        let decoder = JSONDecoder()

        do {
            let tasksData = try Data(contentsOf: tasksJSONURL)
            prioritizedTasks = try decoder.decode([PrioritizedTasks].self, from: tasksData)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadPlistPrioritizedTasks() {
        guard FileManager.default.fileExists(atPath: tasksPropertyListURL.path) else {
            return
        }

        let decoder = PropertyListDecoder()

        do {
            let tasksData = try Data(contentsOf: tasksPropertyListURL)
            prioritizedTasks = try decoder.decode([PrioritizedTasks].self, from: tasksData)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func saveJSONPrioritizedTasks() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let taskData = try encoder.encode(prioritizedTasks)
            try taskData.write(to: tasksJSONURL, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func savePlistPrioritizedTasks() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        do {
            let taskData = try encoder.encode(prioritizedTasks)
            try taskData.write(to: tasksPropertyListURL, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
}

private extension TaskStore.PrioritizedTasks {
    init(priority: Task.Priority, names: [String]) {
        self.init(
            priority: priority,
            tasks: names.map { Task(name: $0) }
        )
    }
}
