local p = import 'pkg/main.libsonnet';

p.pkg({
  source: 'https://github.com/marcbran/jsonnet-plugin-jsonnet',
  repo: 'https://github.com/marcbran/jsonnet.git',
  branch: 'jsonnet',
  path: 'jsonnet',
  target: 'j',
}, |||
  DSL for creating Jsonnet code.
|||, {
  Null: p.desc('Null literal'),
  True: p.desc('True literal'),
  False: p.desc('False literal'),
  Self: p.desc('Self'),
  Dollar: p.desc('Dollar'),
  String: p.desc('String'),
  Number: p.desc('Number'),
  Var: p.desc('Var'),

  Member: p.desc('Member'),
  Index: p.desc('Index'),
  Slice: p.desc('Slice'),

  SuperMember: p.desc('SuperMember'),
  SuperIndex: p.desc('SuperIndex'),
  InSuper: p.desc('InSuper'),

  Function: p.desc('Function'),
  Parameter: p.desc('Parameter'),
  Apply: p.desc('Apply'),

  Object: p.desc('Object'),
  ApplyBrace: p.desc('ApplyBrace'),
  Array: p.desc('Array'),
  ObjectComp: p.desc('ObjectComp'),
  ArrayComp: p.desc('ArrayComp'),

  If: p.desc('If'),

  Local: p.desc('Local'),

  Assert: p.desc('Assert'),
  Error: p.desc('Error'),

  Parens: p.desc('Parens'),

  Import: p.desc('Import'),
  ImportStr: p.desc('ImportStr'),
  ImportBin: p.desc('ImportBin'),

  Binary: p.desc('Binary'),
  Unary: p.desc('Unary'),

  Std: p.desc('Std'),

  manifestJsonnet: p.desc('manifestJsonnet'),
  parseJsonnet: p.desc('parseJsonnet'),
})
