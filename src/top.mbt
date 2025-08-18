///|
pub(open) trait Clone {
  clone(Self) -> Self
}

// scalar

///|
pub impl Clone for Int with clone(self) = "%identity"

///|
pub impl Clone for Int16 with clone(self) = "%identity"

///|
pub impl Clone for Int64 with clone(self) = "%identity"

///|
pub impl Clone for UInt with clone(self) = "%identity"

///|
pub impl Clone for UInt16 with clone(self) = "%identity"

///|
pub impl Clone for UInt64 with clone(self) = "%identity"

///|
pub impl Clone for Byte with clone(self) = "%identity"

///|
pub impl Clone for Float with clone(self) = "%identity"

///|
pub impl Clone for Double with clone(self) = "%identity"

///|
pub impl Clone for Bool with clone(self) = "%identity"

///|
pub impl Clone for Char with clone(self) = "%identity"

///|
pub impl Clone for Unit with clone(self) = "%identity"

///|
pub impl Clone for String with clone(self) {
  // Create new String
  self + ""
}

// compound

///|
pub impl[A : Clone] Clone for Ref[A] with clone(self) {
  Ref::new(self.val.clone())
}

///|
pub impl[A : Clone] Clone for A? with clone(self) {
  match self {
    None => None
    Some(v) => Some(v.clone())
  }
}

///|
pub impl[A : Clone, B : Clone] Clone for Result[A, B] with clone(self) {
  match self {
    Err(v) => Err(v.clone())
    Ok(v) => Ok(v.clone())
  }
}

///|
pub impl[A : Clone] Clone for Array[A] with clone(self) {
  self.map(Clone::clone)
}

///|
pub impl[A : Clone] Clone for @list.List[A] with clone(self) {
  self.map(Clone::clone)
}

///|
pub impl[A : Clone] Clone for FixedArray[A] with clone(self) {
  self.map(Clone::clone)
}

///|
pub impl Clone for Bytes with clone(self) {
  // Bytes are immutable, so we can return self directly
  self
}

///|
pub impl[K : Clone + Eq + Hash, V : Clone] Clone for Map[K, V] with clone(self) {
  let res = Map::new(capacity=self.size())
  for k, v in self {
    res[k.clone()] = v.clone()
  }
  res
}

///|
pub impl[V : Clone + Eq + Hash] Clone for Set[V] with clone(self) {
  let res = Set::new(capacity=self.size())
  for v in self {
    res.add(v.clone())
  }
  res
}

///|
pub impl[A : Clone] Clone for @deque.T[A] with clone(self) {
  self.map(Clone::clone)
}

///|
pub impl[K : Clone + Eq + Hash, V : Clone] Clone for @hashmap.T[K, V] with clone(
  self,
) {
  let res = @hashmap.new(capacity=self.size())
  for k, v in self {
    res[k.clone()] = v.clone()
  }
  res
}

///|
pub impl[V : Clone + Eq + Hash] Clone for @hashset.T[V] with clone(self) {
  let res = @hashset.new(capacity=self.size())
  for v in self {
    res.add(v.clone())
  }
  res
}

///|
pub impl[K : Clone + Eq + Compare, V : Clone] Clone for @sorted_map.T[K, V] with clone(
  self,
) {
  let res = @sorted_map.new()
  for k, v in self {
    res[k.clone()] = v.clone()
  }
  res
}

///|
pub impl[V : Clone + Eq + Compare] Clone for @sorted_set.T[V] with clone(self) {
  let res = @sorted_set.new()
  for v in self {
    res.add(v.clone())
  }
  res
}

///|
pub impl[A : Clone + Compare] Clone for @priority_queue.T[A] with clone(self) {
  let res = @priority_queue.new()
  for x in self {
    res.push(x.clone())
  }
  res
}
