local p = import 'pkg/main.libsonnet';

p.pkg({
  source: 'https://github.com/marcbran/jsonnet-plugin-jsonnet',
  repo: 'https://github.com/marcbran/jsonnet.git',
  branch: 'jsonnet',
  path: 'jsonnet',
  target: 'j',
}, |||
  DSL for creating Jsonnet code.
|||)
