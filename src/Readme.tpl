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

- off-line
```javascript
buffer = IC.compress([1, 2, 3, 4, 5], {order:1});
```

- decompress
```javascript
IC.decompress(buffer);
```


## API

<%= api %>

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
