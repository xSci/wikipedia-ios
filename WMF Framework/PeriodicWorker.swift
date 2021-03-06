import Foundation

@objc(WMFPeriodicWorker) public protocol PeriodicWorker: NSObjectProtocol {
    func doPeriodicWork(_ completion: @escaping () -> Void)
}

@objc(WMFPeriodicWorkerController) public class PeriodicWorkerController: NSObject {
    let interval: TimeInterval
    let initialDelay: TimeInterval
    let leeway: TimeInterval
    
    lazy var workTimer: RepeatingTimer = {
        assert(Thread.isMainThread)
        return RepeatingTimer(interval, afterDelay: initialDelay, leeway: leeway) { [weak self] in
            self?.doPeriodicWork()
        }
    }()
    
    @objc(initWithInterval:initialDelay:leeway:) public required init(_ interval: TimeInterval, initialDelay: TimeInterval, leeway: TimeInterval) {
        self.interval = interval
        self.initialDelay = initialDelay
        self.leeway = leeway
    }
    
    var workers = PointerArray<PeriodicWorker>()
    
    @objc public func add(_ worker: PeriodicWorker) {
        workers.append(worker)
    }
    
    @objc public func start() {
        workTimer.resume()
    }
    
    @objc public func stop() {
        workTimer.pause()
    }
    
    @objc public func doPeriodicWork(_ completion: (() -> Void)? = nil) {
        workers.allObjects.asyncForEach({ (worker, completion) in
            worker.doPeriodicWork(completion)
        }) { () in
            completion?()
        }
    }
}
