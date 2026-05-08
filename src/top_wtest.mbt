///|
test "String::Clone" {
  let x = "hello"
  let y = Clone::clone(x)
  inspect(physical_equal(x, y), content="false")
}
