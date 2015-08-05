compress-integers
======
Compress a series of related integers.

[![NPM version](https://badge.fury.io/js/compress-integers.svg)](https://www.npmjs.com/package/compress-integers)
[![Build Status](https://travis-ci.org/dracupid/compress-integers.svg)](https://travis-ci.org/dracupid/compress-integers)
[![Build status](https://ci.appveyor.com/api/projects/status/github/dracupid/compress-integers?svg=true)](https://ci.appveyor.com/project/dracupid/compress-integers)

## Installation
```bash
npm i compress-integers -S
```

## Usage
- on-line
```javascript
IC = require('compress-integers');
IC.getCompressor({order: 2});
IC.write(10);
IC.write(10);
IC.getResult()
```

- off-line shortcut
```javascript
buffer = IC.compress([1, 2, 3, 4, 5], {order:1});
```

- decompress
```javascript
IC.decompress(buffer);
```


## API



### src

- #### <a href="./src/index.coffee?source#L15" target="_blank"><b>getCompressor (opts = {})</b></a>
    Get an order N compressor with options

  - **param**: `opts` { _Object={}_ }

    options

  - **option**: `RLE` { _boolean_ }

    use Run-Length Encoding

  - **option**: `order` { _number=1_ }

    order of the compressor (0, 1 or 2)

  - **return**:  { _Compressor_ }

    an order N compressor

- #### <a href="./src/index.coffee?source#L33" target="_blank"><b>compress (arr, options = {})</b></a>
    A shortcut for get a Compressor

  - **param**: `arr` { _Array_ }

    array of integers

  - **param**: `options` { _options={}_ }

    see getCompressor

  - **return**:  { _Buffer_ }

    compressed data

- #### <a href="./src/index.coffee?source#L45" target="_blank"><b>decompress (buffer)</b></a>
    Decompress a buffer to an array of integers

  - **param**: `buffer` { _Buffer_ }

    buffer to compress

  - **return**:  { _Array_ }

    array of integers

- #### <a href="./src/index.coffee?source#L210" target="_blank"><b>Compressor.write (int)</b></a>
    write an integer

  - **param**: `int` { _number_ }

    integer

- #### <a href="./src/index.coffee?source#L224" target="_blank"><b>Compressor.getResult ()</b></a>
    Get the result buffer

  - **return**:  { _Buffer_ }

    buffer



## HOW
- Integers are encoded with zig-zag variable-length coding using [binbone](https://github.com/dracupid/node-binbone/blob/master/doc/spec.md)
- A series of integers are stored as their differences. Order is the number of turns of making difference.
- [Run-length encoding](http://en.wikipedia.org/wiki/Run-length_encoding) is use to make it better.
- This algorithm is not suitable for random integers.

For example:

- [1, 2, 3, 4, 5]
    - order1: [1, 1, 1, 1, 1]
    - order2: [1, 1, 0, 0, 0]  The second value is the base value.

- [1, 1, 1, 1, 1]
    - order1: [1, 0, 0, 0, 0]
    - order2: [1, 0, 0, 0, 0]

## Comparison
```bash
npm run compare
```

See [result](doc/comparison.md)

## License
MIT@Jingchen Zhao
