# SPM

![Test Script](https://github.com/Sherlouk/spm/workflows/Test%20Script/badge.svg)

An executable with a couple potentially helpful swift package manager commands.

## Commands

### Graph

Creates a graph visualising the package and all of it's dependencies.

> Note: This command requires that you have already installed '[nomnoml](https://github.com/skanaar/nomnoml)' locally - you can do this by running `npm install -g nomnoml`.

```shell
$ spm graph path/to/package [--outputName <generated.svg>]
```

### New (NOT IMPLEMENTED)

Creates a new Swift package using an opinionated structure 

```shell
$ spm new MyPackage
```

## TODO

* Create `new` command
* Support GraphViz export type for graph command (--outputType <graphviz || nomnoml>)
* Add --outputPath option to graph command to switch from current directory
* Add --detailed flag which adds enhanced information to every node in graph. Including tools version, and platform target(s).
* Extract JUnit from CI test suite and upload using https://github.com/EnricoMi/publish-unit-test-result-action
