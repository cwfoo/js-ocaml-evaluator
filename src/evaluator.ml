let () = JsooTop.initialize ()

let execute (code : Js.js_string Js.t) : Js.js_string Js.t =
  let code = Js.to_string code in
  let buffer = Buffer.create 100 in
  let formatter = Format.formatter_of_buffer buffer in
  JsooTop.execute true formatter code;
  Js.string (Buffer.contents buffer)

(* Set the handler for stdout.
 * Every time data is sent to stdout, function f will be called with
 * one string argument: the data sent to stdout.
 * *)
let set_stdout_handler (f : (string -> unit)) : unit =
    Sys_js.set_channel_flusher stdout f

let () =
  Js.export_all (
    object%js
      val execute = execute
      val setStdoutHandler = set_stdout_handler
    end)
