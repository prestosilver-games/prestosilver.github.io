## About

I've always wanted to make my own programming language, so here is the process.

## Inspiration

- [porth](https://gitlab.com/tsoding/porth)

## Planning

Slam was always going to be a object oriented programming language, but I also wanted it to be concatinative.
Originally Slam was supposed to be named slim, but that was taken by a html templating language.

## Usage

### Hello World

```slam
{This is needed for the cstr class}
inc stdlib.slm

{This prints hello world}
proc main 0 0
  "Hello World" {Push hello world onto the stack}
  (cstr.println) {print the top of the stack}

  ret
end
```

### Arithmetic

```slam
{
Slam uses Reverse polish notation for math
instead of writing a operation b you
run a b operation, so for example 4 + 3 would
be
}

4 3 +
(int.print)

{
subtraction has an order still, you need to put the
2nd parameter second, 4 - 3 would be
}
4 3 -
(int.print)

{
slam by default has no division operation
instead it has /% which pushes the result and the
remainder to the stack. though there are shortcuts
in stdlib.slm that allow you to / and % individually.
}
100 10 /%
(int.print)
(int.print)
```

### Defining Procs (functions)

```slam
{
this defines a proc named foo, it will
have access to the top 2 items in the
stack. And when it returns itll have 1
item in place of these 2.
}
proc foo 2 1
  {remove the top item in the stack}
  disc
  
  ret
end

{
an operation proc (which you'll see
the effects of in Calling procs) can
be defined by putting the identifier
oper before the name.
}
oper
proc bar 0 0
  
  ret
end

{you can also do this on the same line}
oper proc foo-op2 0 0

  ret
end
```

### Calling Procs

```slam
(foo)
            
{to call a operation proc just write its name}

bar
```

### Blocks

```slam
{
A block is created by wrapping a sequence of
operations in [], a block counts as one command.
This is useful for if statements
}
[
  (foo) bar
]
{
due to limitations in slam, you cannont create a block inside a block.
}

```

### if statements

```slam
{
an if statement pops the last item on the stack
if this item is 0 it skips the next command
}
100 10 /
10 == if [
  "10 / 100 is 10"
]
```

### Classes

```slam
class bar
  proc name 0 1
    "bar"
    ret
  end
  
  proc inherit 0 0
  
    ret
  end
end

class foo of bar
  proc name 0 1
    "foo"
    ret
  end
end
```

## Links

- [Github](https://github.com/slam-lang)

