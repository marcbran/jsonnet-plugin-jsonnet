package main

import (
	"github.com/google/go-jsonnet"
	"github.com/marcbran/jpoet/pkg/jpoet"
)

func main() {
	jpoet.Serve([]jsonnet.NativeFunction{
		FormatJsonnet(),
		ManifestJsonnet(),
		ParseJsonnet(),
	})
}
