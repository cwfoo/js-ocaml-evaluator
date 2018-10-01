export PATH := $(shell npm bin):$(PATH)  # Add local npm executables to PATH.

.PHONY: clean

_build/evaluator.js: src/evaluator.ml
	@mkdir -p _build/
	# Produce bytecode.
	ocamlfind ocamlc src/evaluator.ml \
		-package js_of_ocaml \
		-package js_of_ocaml-ppx \
		-package js_of_ocaml-toplevel \
		-linkpkg \
		-o _build/evaluator.byte
	# Compile bytecode to JavaScript.
	js_of_ocaml -o _build/evaluator.js \
		--toplevel \
		--dynlink \
		+dynlink.js \
		+toplevel.js \
		_build/evaluator.byte
	rm -f _build/evaluator.byte
	# Minify JavaScript file.
	uglifyjs _build/evaluator.js --compress --mangle --output _build/evaluator.min.js
	rm -f _build/evaluator.js

clean:
	rm -rf _build/ src/*.cm[io]
