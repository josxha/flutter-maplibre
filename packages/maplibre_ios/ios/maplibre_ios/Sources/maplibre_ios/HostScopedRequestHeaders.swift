import Foundation
import MapLibre

@objc(HostScopedRequestHeaders)
public class HostScopedRequestHeaders: NSObject, MLNNetworkConfigurationDelegate {
    public static let shared = HostScopedRequestHeaders()

    private let lock = NSLock()
    private var headersByHost: [String: [String: String]] = [:]
    private var previousDelegate: MLNNetworkConfigurationDelegate?

    func install() {
        let configuration = MLNNetworkConfiguration.sharedManager
        guard configuration.delegate !== self else { return }
        previousDelegate = configuration.delegate
        configuration.delegate = self
    }

    /// MapLibre calls these optional methods only when the current delegate
    /// responds to them. Forwarding without implementing them keeps MapLibre's
    /// own session when no earlier delegate supplied one.
    override public func responds(to aSelector: Selector!) -> Bool {
        if Self.forwardedSelectors.contains(aSelector) {
            return (previousDelegate as? NSObject)?.responds(to: aSelector) ?? false
        }
        return super.responds(to: aSelector)
    }

    override public func forwardingTarget(for aSelector: Selector!) -> Any? {
        if Self.forwardedSelectors.contains(aSelector),
           let previous = previousDelegate as? NSObject,
           previous.responds(to: aSelector)
        {
            return previous
        }
        return super.forwardingTarget(for: aSelector)
    }

    @objc(replaceWithHost:headers:)
    public static func replaceWithHost(_ host: String, headers: NSDictionary) {
        var converted: [String: String] = [:]
        converted.reserveCapacity(headers.count)
        headers.enumerateKeysAndObjects { key, value, _ in
            guard let name = key as? String, let headerValue = value as? String else {
                return
            }
            converted[name] = headerValue
        }
        shared.replace(host: host, headers: converted)
    }

    @objc(clearWithHost:)
    public static func clearWithHost(_ host: String) {
        shared.clear(host: host)
    }

    func replace(host: String, headers: [String: String]) {
        lock.lock()
        defer { lock.unlock() }
        let normalizedHost = host.lowercased()
        if headers.isEmpty {
            headersByHost.removeValue(forKey: normalizedHost)
        } else {
            headersByHost[normalizedHost] = headers
        }
    }

    func clear(host: String) {
        lock.lock()
        defer { lock.unlock() }
        headersByHost.removeValue(forKey: host.lowercased())
    }

    public func willSend(_ request: NSMutableURLRequest) -> NSMutableURLRequest {
        let transformedRequest = previousDelegate?.willSend?(request) ?? request
        guard let host = transformedRequest.url?.host?.lowercased() else {
            return transformedRequest
        }

        lock.lock()
        let headers = headersByHost[host]
        lock.unlock()

        headers?.forEach { name, value in
            transformedRequest.setValue(value, forHTTPHeaderField: name)
        }
        return transformedRequest
    }

    private static let forwardedSelectors: Set<Selector> = [
        NSSelectorFromString("sessionForNetworkConfiguration:"),
        NSSelectorFromString("didReceiveResponse:"),
    ]
}
