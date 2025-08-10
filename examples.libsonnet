local j = import './main.libsonnet';
local p = import 'pkg/main.libsonnet';

p.ex({}, {
  Null: p.ex({
    example:
      j.manifestJsonnet(
        j.Null,
      ),
    expected: 'null',
  }),
  True: p.ex({
    example:
      j.manifestJsonnet(
        j.True,
      ),
    expected: 'true',
  }),
  False: p.ex({
    example:
      j.manifestJsonnet(
        j.False,
      ),
    expected: 'false',
  }),
  Self: p.ex({
    example:
      j.manifestJsonnet(
        j.Self,
      ),
    expected: 'self',
  }),
  Dollar: p.ex({
    example:
      j.manifestJsonnet(
        j.Dollar,
      ),
    expected: '$',
  }),
  String: p.ex([{
    name: 'simple',
    example:
      j.manifestJsonnet(
        j.String('foobar'),
      ),
    expected: "'foobar'",
  }, {
    name: 'format',
    example:
      j.manifestJsonnet(
        j.String('foo bar %s', j.String('baz')),
      ),
    expected: "'foo bar %s' % 'baz'",
  }, {
    name: 'format list',
    example:
      j.manifestJsonnet(
        j.String('foo %s %s', j.Array([j.String('bar'), j.String('baz')])),
      ),
    expected: "'foo %s %s' % ['bar', 'baz']",
  }]),
  Number: p.ex({
    example:
      j.manifestJsonnet(
        j.Number('123.456'),
      ),
    expected: '123.456',
  }),
  Var: p.ex({
    example:
      j.manifestJsonnet(
        j.Var('a'),
      ),
    expected: 'a',
  }),
  Member: p.ex({
    example:
      j.manifestJsonnet(
        j.Member(j.Var('a'), 'b'),
      ),
    expected: 'a.b',
  }),
  Index: p.ex({
    example:
      j.manifestJsonnet(
        j.Index(j.Var('a'), j.String('b')),
      ),
    expected: 'a["b"]',
  }),
  Slice: p.ex({
    example:
      j.manifestJsonnet(
        j.Slice(j.Var('a'), j.Number('1'), j.Number('10'), j.Number('2')),
      ),
    expected: 'a[1:10:2]',
  }),
  SuperMember: p.ex({
    example:
      j.manifestJsonnet(
        j.SuperMember('a'),
      ),
    expected: 'super.a',
  }),
  SuperIndex: p.ex({
    example:
      j.manifestJsonnet(
        j.SuperIndex(j.String('a')),
      ),
    expected: 'super["a"]',
  }),
  InSuper: p.ex({
    example:
      j.manifestJsonnet(
        j.InSuper(j.Var('a')),
      ),
    expected: ' a in super',
  }),
  Function: p.ex([{
    name: 'no parameter',
    example:
      j.manifestJsonnet(
        j.Function([], j.String('foo')),
      ),
    expected: "function() 'foo'",
  }, {
    name: 'single parameter',
    example:
      j.manifestJsonnet(
        j.Function([j.Parameter('a')], j.Var('a')),
      ),
    expected: "function(a) 'foo'",
  }, {
    name: 'parameter with default value',
    example:
      j.manifestJsonnet(
        j.Function([j.Parameter('a', j.Number('2'))], j.Var('a')),
      ),
    expected: "function(a) 'foo'",
  }]),
  Apply: p.ex([{
    name: 'no parameter',
    example:
      j.manifestJsonnet(
        j.Apply(j.Var('foo')),
      ),
    expected: 'foo()',
  }, {
    name: 'single positional parameter',
    example:
      j.manifestJsonnet(
        j.Apply(j.Var('foo'), [j.CommaSeparatedExpr(j.Var('a'))]),
      ),
    expected: 'foo(a)',
  }, {
    name: 'single positional parameter without comma separated expr',
    example:
      j.manifestJsonnet(
        j.Apply(j.Var('foo'), [j.Var('a')]),
      ),
    expected: 'foo(a)',
  }, {
    name: 'single named parameter',
    example:
      j.manifestJsonnet(
        j.Apply(j.Var('foo'), [], [j.NamedArgument('a', j.Number('1'))]),
      ),
    expected: 'foo(a=1)',
  }]),
  Object: p.ex([{
    name: 'no fields',
    example:
      j.manifestJsonnet(
        j.Object(),
      ),
    expected: '{}',
  }, {
    name: 'single field',
    example:
      j.manifestJsonnet(
        j.Object([j.Field('a', j.Number('1'))]),
      ),
    expected: '{ a: 1 }',
  }, {
    name: 'single expr field',
    example:
      j.manifestJsonnet(
        j.Object([j.Field(j.Var('a'), j.Number('1'))]),
      ),
    expected: '{ [a]: 1 }',
  }, {
    name: 'single field func',
    example:
      j.manifestJsonnet(
        j.Object([j.FieldFunction('a', [], j.Number('1'))]),
      ),
    expected: '{ a(): 1 }',
  }]),
  ApplyBrace: p.ex([{
    name: 'apply brace',
    example:
      j.manifestJsonnet(
        j.ApplyBrace(j.Var('a'), j.Object()),
      ),
    expected: 'a {}',
  }]),
  Array: p.ex([{
    name: 'no elements',
    example:
      j.manifestJsonnet(
        j.Array(),
      ),
    expected: '[]',
  }, {
    name: 'single element',
    example:
      j.manifestJsonnet(
        j.Array([j.CommaSeparatedExpr(j.Number('1'))]),
      ),
    expected: '[1]',
  }, {
    name: 'single element, without comma separated expr',
    example:
      j.manifestJsonnet(
        j.Array([j.Number('1')]),
      ),
    expected: '[1]',
  }]),
  ObjectComp: p.ex([{
    name: 'single for',
    example:
      j.manifestJsonnet(
        j.ObjectComp(
          [j.Field(j.Var('a'), j.Number('1'))],
          [j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))]))]
        ),
      ),
    expected: '{ [a]: 1 for a in [1, 2, 3] }',
  }, {
    name: 'two fors',
    example:
      j.manifestJsonnet(
        j.ObjectComp(
          [j.Field(j.Var('a'), j.Var('b'))],
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.ForSpec('b', j.Array([j.CommaSeparatedExpr(j.Number('4')), j.CommaSeparatedExpr(j.Number('5')), j.CommaSeparatedExpr(j.Number('6'))])),
          ]
        ),
      ),
    expected: '{ [a]: b for a in [1, 2, 3] for b in [4, 5, 6] }',
  }, {
    name: 'one for one if',
    example:
      j.manifestJsonnet(
        j.ObjectComp(
          [j.Field(j.Var('a'), j.Var('b'))],
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.IfSpec(j.True),
          ]
        ),
      ),
    expected: '{ [a]: b for a in [1, 2, 3] if true }',
  }, {
    name: 'one for two ifs',
    example:
      j.manifestJsonnet(
        j.ObjectComp(
          [j.Field(j.Var('a'), j.Var('b'))],
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.IfSpec(j.True),
            j.IfSpec(j.False),
          ]
        ),
      ),
    expected: '{ [a]: b for a in [1, 2, 3] if true if false }',
  }, {
    name: 'one for one if one for',
    example:
      j.manifestJsonnet(
        j.ObjectComp(
          [j.Field(j.Var('a'), j.Var('b'))],
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.IfSpec(j.True),
            j.ForSpec('b', j.Array([j.CommaSeparatedExpr(j.Number('4')), j.CommaSeparatedExpr(j.Number('5')), j.CommaSeparatedExpr(j.Number('6'))])),
          ]
        ),
      ),
    expected: '{ [a]: b for a in [1, 2, 3] if true for b in [4, 5, 6] }',
  }]),
  ArrayComp: p.ex([{
    name: 'single for',
    example:
      j.manifestJsonnet(
        j.ArrayComp(
          j.Var('a'),
          [j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))]))]
        ),
      ),
    expected: '[ a for a in [1, 2, 3] ]',
  }, {
    name: 'two fors',
    example:
      j.manifestJsonnet(
        j.ArrayComp(
          j.Var('a'),
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.ForSpec('b', j.Array([j.CommaSeparatedExpr(j.Number('4')), j.CommaSeparatedExpr(j.Number('5')), j.CommaSeparatedExpr(j.Number('6'))])),
          ]
        ),
      ),
    expected: '[ a for a in [1, 2, 3] for b in [4, 5, 6] ]',
  }, {
    name: 'one for one if',
    example:
      j.manifestJsonnet(
        j.ArrayComp(
          j.Var('a'),
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.IfSpec(j.True),
          ]
        ),
      ),
    expected: '[ a for a in [1, 2, 3] if true ]',
  }, {
    name: 'one for two ifs',
    example:
      j.manifestJsonnet(
        j.ArrayComp(
          j.Var('a'),
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.IfSpec(j.True),
            j.IfSpec(j.False),
          ]
        ),
      ),
    expected: '[ a for a in [1, 2, 3] if true if false ]',
  }, {
    name: 'one for one if one for',
    example:
      j.manifestJsonnet(
        j.ArrayComp(
          j.Var('a'),
          [
            j.ForSpec('a', j.Array([j.CommaSeparatedExpr(j.Number('1')), j.CommaSeparatedExpr(j.Number('2')), j.CommaSeparatedExpr(j.Number('3'))])),
            j.IfSpec(j.True),
            j.ForSpec('b', j.Array([j.CommaSeparatedExpr(j.Number('4')), j.CommaSeparatedExpr(j.Number('5')), j.CommaSeparatedExpr(j.Number('6'))])),
          ]
        ),
      ),
    expected: '[ a for a in [1, 2, 3] if true for b in [4, 5, 6] ]',
  }]),
  If: p.ex([{
    name: 'if-then',
    example:
      j.manifestJsonnet(
        j.If(j.True, j.Var('a')),
      ),
    expected: 'null',
  }, {
    name: 'if-then-else',
    example:
      j.manifestJsonnet(
        j.If(j.True, j.Var('a'), j.Var('b')),
      ),
    expected: 'null',
  }]),
  Local: p.ex([{
    name: 'single bind',
    example:
      j.manifestJsonnet(
        j.Local([j.LocalBind('a', j.Number('1'))], j.Var('a')),
      ),
    expected: 'local a = 1; a',
  }, {
    name: 'single non-array bind',
    example:
      j.manifestJsonnet(
        j.Local(j.LocalBind('a', j.Number('1')), j.Var('a')),
      ),
    expected: 'local a = 1; a',
  }, {
    name: 'two binds',
    example:
      j.manifestJsonnet(
        j.Local(
          [
            j.LocalBind('a', j.Number('1')),
            j.LocalBind('b', j.Var('a')),
          ],
          j.Var('b')
        ),
      ),
    expected: 'local a = 1, b = a; b',
  }, {
    name: 'two locals',
    example:
      j.manifestJsonnet(
        j.Local(
          [
            j.LocalBind('a', j.Number('1')),
          ],
          j.Local(
            [
              j.LocalBind('b', j.Var('a')),
            ],
            j.Var('b')
          ),
        ),
      ),
    expected: 'local a = 1; local b = a; b',
  }, {
    name: 'function bind',
    example:
      j.manifestJsonnet(
        j.Local(
          [j.LocalFunctionBind('a', [j.Parameter('b')], j.Var('b'))],
          j.Apply(j.Var('a'), [j.CommaSeparatedExpr(j.Number('1'))])
        ),
      ),
    expected: 'local a(b) = b; a(1)',
  }]),
  Locals: p.ex([{
    name: 'two locals',
    example:
      j.manifestJsonnet(
        j.Locals(
          [
            [j.LocalBind('a', j.Number('1'))],
            [j.LocalBind('b', j.Var('a'))],
          ],
          j.Var('b')
        ),
      ),
    expected: 'local a = 1; local b = a; b',
  }, {
    name: 'two non-array locals',
    example:
      j.manifestJsonnet(
        j.Locals(
          [
            j.LocalBind('a', j.Number('1')),
            j.LocalBind('b', j.Var('a')),
          ],
          j.Var('b')
        ),
      ),
    expected: 'local a = 1; local b = a; b',
  }]),
  Assert: p.ex({
    example:
      j.manifestJsonnet(
        j.Assert(j.True, null, j.Var('a')),
      ),
    expected: 'assert true; a',
  }),
  Error: p.ex({
    example:
      j.manifestJsonnet(
        j.Error(j.String('input required')),
      ),
    expected: "error 'input required'",
  }),
  Parens: p.ex({
    example:
      j.manifestJsonnet(
        j.Parens(j.String('foo')),
      ),
    expected: "('foo')",
  }),
  Import: p.ex({
    example:
      j.manifestJsonnet(
        j.Import('main.libsonnet'),
      ),
    expected: "import 'main.libsonnet'",
  }),
  ImportStr: p.ex({
    example:
      j.manifestJsonnet(
        j.ImportStr('main.txt'),
      ),
    expected: "import 'main.txt'",
  }),
  ImportBin: p.ex({
    example:
      j.manifestJsonnet(
        j.ImportBin('data.raw'),
      ),
    expected: "import 'data.raw'",
  }),
  Binary: p.ex([{
    name: 'add',
    example:
      j.manifestJsonnet(
        j.Mul(j.Number('1'), j.Number('2')),
      ),
    expected: '1 + 2',
  }]),
  Unary: p.ex([{
    name: 'negate',
    example:
      j.manifestJsonnet(
        j.Not(j.Var('a')),
      ),
    expected: '!a',
  }]),
  Std: p.ex([{
    name: 'get',
    example:
      j.manifestJsonnet(
        j.Std.get(j.Var('a'), j.String('foo')).default(j.Null),
      ),
    expected: "std.get(a, 'foo', null)",
  }]),
})
