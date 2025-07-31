package main

import (
	"fmt"
	"github.com/google/go-jsonnet"
	"github.com/google/go-jsonnet/ast"
)

func ManifestJsonnet() jsonnet.NativeFunction {
	return jsonnet.NativeFunction{
		Name:   "manifestJsonnet",
		Params: ast.Identifiers{"jsonnet"},
		Func: func(input []any) (any, error) {
			if len(input) != 1 {
				return nil, fmt.Errorf("jsonnet must be provided")
			}
			out, err := Manifest(input[0])
			if err != nil {
				return nil, err
			}
			return out, nil
		},
	}
}
