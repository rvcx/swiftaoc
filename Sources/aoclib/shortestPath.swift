public func shortestPath<Node: Hashable>(from: Node, to: Node,
                                         neighbors: (Node) -> [Node])
    -> [Node]? {
  var v = [Node:Node]()
  let q = Queue<Node>()
  q.push(from)
  while let c = q.pop() {
    for n in neighbors(c) {
      if n == to {
        var path = [n, c]
        var cur = c
        while let next = v[cur] {
          cur = next
          path.append(cur)
        }
        return path.reversed()
      }
      if n != from && v[n] == nil {
        v[n] = c
        q.push(n)
      }
    }
  }
  return nil
}
