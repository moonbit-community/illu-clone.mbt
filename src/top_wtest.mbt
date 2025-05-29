///|
test "String::Clone" {
  let x = "hello"
  let y = x.clone()
  inspect!(physical_equal(x, y), content="false")
}
