import jsony, json

block:
  type Entry = object
    name: string
    data: JsonNode

  var entry = Entry()
  entry.name = "json-in-json"
  entry.data = %*{
    "random-data": "here",
    "number": 123,
    "number2": 123.456,
    "array": @[1, 2, 3],
    "active": true,
    "null": nil
  }

  doAssert entry.toJson() == """{"name":"json-in-json","data":{"random-data":"here","number":123,"number2":123.456,"array":[1,2,3],"active":true,"null":null}}"""
  doAssert $entry.toJson.fromJson(Entry) == """(name: "json-in-json", data: {"random-data":"here","number":123,"number2":123.456,"array":[1,2,3],"active":true,"null":null})"""

  let s = """{"name":"json-in-json","data":{"random-data":"here","number":123,"number2":123.456,"array":[1,2,3],"active":true,"null":null}}"""
  doAssert $s.fromJson() == """{"name":"json-in-json","data":{"random-data":"here","number":123,"number2":123.456,"array":[1,2,3],"active":true,"null":null}}"""

  let ns = """[123, +123, -123, 123.456, +123.456, -123.456, 123.456E9, +123.456E9, -123.456E9]"""
  doAssert $ns.fromJson() == """[123,123,-123,123.456,123.456,-123.456,123456000000.0,123456000000.0,-123456000000.0]"""
