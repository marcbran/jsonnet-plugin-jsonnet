package jsonnet

import (
	"github.com/google/go-jsonnet"
	"github.com/marcbran/jpoet/pkg/jpoet"
)

func Plugin(opts ...jpoet.PluginOption) *jpoet.Plugin {
	return jpoet.NewPlugin("jsonnet", []jsonnet.NativeFunction{
		FormatJsonnet(),
		ManifestJsonnet(),
		ParseJsonnet(),
	}, opts...)
}
