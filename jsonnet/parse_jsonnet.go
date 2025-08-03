package jsonnet

import (
	"fmt"
	"github.com/google/go-jsonnet"
	"github.com/google/go-jsonnet/ast"
)

func ParseJsonnet() jsonnet.NativeFunction {
	return jsonnet.NativeFunction{
		Name:   "parseJsonnet",
		Params: ast.Identifiers{"jsonnet"},
		Func: func(input []any) (any, error) {
			if len(input) != 1 {
				return nil, fmt.Errorf("jsonnet must be provided")
			}
			md, ok := input[0].(string)
			if !ok {
				return nil, fmt.Errorf("jsonnet must be a string")
			}
			out, err := Parse(md)
			if err != nil {
				return nil, err
			}
			return out, nil
		},
	}
}
