///|
pub(open) trait Clone {
  fn clone(Self) -> Self
}

// scalar

///|
pub impl Clone for Int with fn clone(self) = "%identity"

///|
pub impl Clone for Int16 with fn clone(self) = "%identity"

///|
pub impl Clone for Int64 with fn clone(self) = "%identity"

///|
pub impl Clone for UInt with fn clone(self) = "%identity"

///|
pub impl Clone for UInt16 with fn clone(self) = "%identity"

///|
pub impl Clone for UInt64 with fn clone(self) = "%identity"

///|
pub impl Clone for Byte with fn clone(self) = "%identity"

///|
pub impl Clone for Float with fn clone(self) = "%identity"

///|
pub impl Clone for Double with fn clone(self) = "%identity"

///|
pub impl Clone for Bool with fn clone(self) = "%identity"

///|
pub impl Clone for Char with fn clone(self) = "%identity"

///|
pub impl Clone for Unit with fn clone(self) = "%identity"

///|
pub impl Clone for String with fn clone(self) {
  // Create new String
  self + ""
}

// compound

///|
pub impl[A : Clone] Clone for Ref[A] with fn clone(self) {
  Ref(self.val.clone())
}

///|
pub impl[A : Clone] Clone for A? with fn clone(self) {
  match self {
    None => None
    Some(v) => Some(v.clone())
  }
}

///|
pub impl[A : Clone, B : Clone] Clone for Result[A, B] with fn clone(self) {
  match self {
    Err(v) => Err(v.clone())
    Ok(v) => Ok(v.clone())
  }
}

///|
pub impl[A : Clone] Clone for Array[A] with fn clone(self) {
  self.map(Clone::clone)
}

///|
pub impl[A : Clone] Clone for @list.List[A] with fn clone(self) {
  self.map(Clone::clone)
}

///|
pub impl[A : Clone] Clone for FixedArray[A] with fn clone(self) {
  self.map(Clone::clone)
}

///|
pub impl Clone for Bytes with fn clone(self) {
  // Bytes are immutable, so we can return self directly
  self
}

///|
pub impl[K : Clone + Eq + Hash, V : Clone] Clone for Map[K, V] with fn clone(
  self,
) {
  let res = Map([], capacity=self.length())
  for k, v in self {
    res[Clone::clone(k)] = v.clone()
  }
  res
}

///|
pub impl[V : Clone + Eq + Hash] Clone for Set[V] with fn clone(self) {
  let res = Set([], capacity=self.length())
  for v in self {
    res.add(Clone::clone(v))
  }
  res
}

///|
pub impl[A : Clone] Clone for @deque.Deque[A] with fn clone(self) {
  self.map(Clone::clone)
}

///|
pub impl[K : Clone + Eq + Hash, V : Clone] Clone for @hashmap.HashMap[K, V] with fn clone(
  self,
) {
  let res = @hashmap.HashMap([], capacity=self.length())
  for k, v in self {
    res[Clone::clone(k)] = v.clone()
  }
  res
}

///|
pub impl[V : Clone + Eq + Hash] Clone for @hashset.HashSet[V] with fn clone(
  self,
) {
  let res = @hashset.HashSet([], capacity=self.length())
  for v in self {
    res.add(Clone::clone(v))
  }
  res
}

///|
pub impl[K : Clone + Compare, V : Clone] Clone for @sorted_map.SortedMap[K, V] with fn clone(
  self,
) {
  let res = @sorted_map.SortedMap([])
  for k, v in self {
    res[Clone::clone(k)] = v.clone()
  }
  res
}

///|
pub impl[V : Clone + Compare] Clone for @sorted_set.SortedSet[V] with fn clone(
  self,
) {
  let res = @sorted_set.SortedSet([])
  for v in self {
    res.add(Clone::clone(v))
  }
  res
}

///|
pub impl[A : Clone + Compare] Clone for @priority_queue.PriorityQueue[A] with fn clone(
  self,
) {
  let res = @priority_queue.PriorityQueue([])
  for x in self {
    res.push(Clone::clone(x))
  }
  res
}
