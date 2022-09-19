## About

Ive always wanted to make my own programming language, so heres the process.

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

### Defining Procs (functions)

```
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
proc foo-op1 0 0
  
  ret
end

{you can also do this on the same line}
oper proc foo-op2 0 0

  ret
end
```

### Calling Procs

```
(foo)
            
{to call a operation proc just write its name}

bar
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

