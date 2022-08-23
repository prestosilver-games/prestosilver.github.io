## About

Markup is a document compiler written completly in nim.

## Install

Run:

```
$ nimble install http://github.com/bob16795/markup_nim
```

## Usage

```
$ markup [options] [file1 file2 ...]
```

## Basic usage

Markup has all the basic syntax as markdown see [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) for a refrence. 

## Advanced features

Markup has a document property system that allows you to define a variable and refrence it later, an example of a document property section is as follows:

```
---
Title: This is a document
---
# Title is ()Title() % () is used to refer to 

sample text
```

## Plugins

Markup plugins can be used to define tags in a less confusing way than using doc props. You can define a macro that will be ran when you create a tag with the same name.

## Full AST Definition

```
body        := [propSec | textSec]+
textSec     := [textComment |
                textList |
                codeBlock |
                equ |
                tag |
                textHeading |
                textTable |
                textLine]+ textParEnd
heading2    := `##` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                     `:` | `;` | `<` | `>` | `!` | text | num |
                     `-` | `*` | `$` ]+ `\n`
textParEnd  := `\n`+
textList    := [listLevel3 |
                listLevel2 |
                listLevel1]+
listLevel3  := `\t\t- ` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                         `:` | `;` | `<` | `>` | `!` | text | num |
                         `-` | `*` | `$` ]+ `\n`
listLevel2  := `\t- ` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                       `:` | `;` | `<` | `>` | `!` | text | num |
                       `-` | `*` | `$` ]+ `\n`
listLevel1  := `- ` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                     `:` | `;` | `<` | `>` | `!` | text | num |
                     `-` | `*` | `$` ]+ `\n`
equ         := `$$` [`_` | `*` | `{` | `}` | `!` | `-` | `+` |
                     `;` | `<` | `>` | `(` | `)` | `=` | text |
                     num]+ `$$\n`
tag         := `<` text [`:` text]? `>\n`
textHeading := [heading3 |
                heading2 |
                heading1 ]+
heading3    := `###` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                      `:` | `;` | `<` | `>` | `!` | text | num |
                      `-` | `*` | `$` ]+ `\n`
heading2    := `##` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                     `:` | `;` | `<` | `>` | `!` | text | num |
                     `-` | `*` | `$` ]+ `\n`
heading1    := `#` [`(` | `|` | `)` | `{` | `}` | `_` | `+` |
                    `:` | `;` | `<` | `>` | `!` | text | num |
                    `-` | `*` | `$` ]+ `\n`
comment     := `!` .* [`\n` | EOF]
textLine        := [bold |
                emph |
                text ]+ `\n` 
propSec     := propDiv propLine+ propDiv `\n`*
propDiv     := `---\n`
propLine    := [`!`? text `|`]? text `:` text `\n`
textTable   := tableHeader [tableRow]+
tableHeader := tableRow tableSplit
tableRow    := `|` [text `|`]+
tableSplit  := `|` [`-`+ `|`]+
emphText    := [`_` text `_`] | [`*` text `*`] 
boldText    := [`__` text `__`] | [`**` text `**`] 
codeBlock   := `\`\`\`` text? `\n` [text | `\n`] `\`\`\``
```
