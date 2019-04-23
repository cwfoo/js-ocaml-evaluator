# OCaml evaluator in JavaScript

Evaluate OCaml code given as a string.

```bash
npm install --save js-ocaml-evaluator
```

## Usage

This package exposes these functions:

* `execute` - Execute OCaml code given as a string.
* `setStdoutHandler` - Configure how data sent to stdout is handled.
* `setStderrHandler` - Configure how data sent to stderr is handled.

Usage in Node.js:

```javascript
const OCamlEval = require('js-ocaml-evaluator');

OCamlEval.execute('print_endline "Hello planet";;');
// Prints "Hello planet" to the console.
// Returns: '- : unit = ()\n'

OCamlEval.execute('let x = 2;;');  // Returns: 'val x : int = 2\n'
OCamlEval.execute('let y = 3;;');  // Returns: 'val y : int = 3\n'
OCamlEval.execute('print_endline (string_of_int (x + y));;');
// Prints "5" to the console.
// Returns: '- : unit = ()\n'

OCamlEval.execute('let plus x y = \n x + y;;');
// Returns: 'val plus : int -> int -> int = <fun>\n'
OCamlEval.execute('plus x y;;');
// Returns: '- : int = 5\n'

OCamlEval.execute('0 / 0;;');
// Returns: 'Exception: Division_by_zero.\n'

OCamlEval.execute('blabla;;');
// Prints "File "", line 1, characters 0-6:
//         Error: Syntax error" to the console.
// Returns: ''

// Customize the handling of data sent to stdout.
OCamlEval.setStdoutHandler(function(str) {
    process.stdout.write('This is stdout: ' + str);
    // Note: `process.stdout.write` is specific to Node.js.
    // We could have used `console.log`, but that adds a newline.
});
OCamlEval.execute('print_endline "Hello planet";;');
// Prints "This is stdout: Hello planet" to the console.
// Returns: '- : unit = ()\n'
```

## Development

Prerequisites:

* An installation of GNU Make.
* `opam install js_of_ocaml js_of_ocaml-ppx js_of_ocaml-toplevel`
* `npm install`

To build, run `make`. The output will be in the `_build/` directory.

## License

This project is distributed under the BSD 3-Clause License (see LICENSE).
This project uses third-party libraries that are licensed under their own terms
(see LICENSE-3RD-PARTY).
