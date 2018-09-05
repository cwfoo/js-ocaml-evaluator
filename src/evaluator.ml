let () =
  JsooTop.initialize ()

let execute code =
  let code = Js.to_string code in
  let buffer = Buffer.create 100 in
  let formatter = Format.formatter_of_buffer buffer in
  JsooTop.execute true formatter code;
  Js.string (Buffer.contents buffer)

let () =
  Js.export_all (
    object%js
      val execute = execute
    end)
