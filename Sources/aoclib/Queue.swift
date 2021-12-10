public class Queue<T> {
  class Node {
    let v: T
    var next: Node?
    init(_ v: T) {
      self.v = v
    }
  }
  var head: Node? = nil
  var tail: Node? = nil
  
  public var isEmpty: Bool {
    return head == nil
  }
  
  public init() {}
  
  public func push(_ v: T) {
    let newTail = Node(v)
    if let t = tail {
      assert(t.next == nil)
      t.next = newTail
    }
    tail = newTail
    if head == nil {
      head = tail
    }
  }
  
  public func pop() -> T? {
    guard let h = head else {
      return nil
    }
    head = h.next
    return h.v
  }
}