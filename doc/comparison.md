Array Size:  200000

sequence from 1 to 1000:

    order1_RLE: 7 (0.00%) 9ms ---- deflate: 9(0.00%) 0ms
    order2_RLE: 8 (0.00%) 11ms ---- deflate: 10(0.00%) 0ms
    order1: 200002 (33.80%) 17ms ---- deflate: 214(0.04%) 1ms
    order2: 200002 (33.80%) 20ms ---- deflate: 214(0.04%) 1ms
    order0_RLE_UNSIGNED: 583494 (98.61%) 19ms ---- deflate: 407148(68.80%) 17ms
    plain: 591748 (100.00%) 25ms ---- deflate: 413740(69.92%) 17ms
    order0_RLE: 591750 (100.00%) 19ms ---- deflate: 413748(69.92%) 20ms

    Best: order1_RLE
    Fast: order1_RLE

repeated sequence for 1000:

    order0_RLE_UNSIGNED: 7 (0.00%) 8ms ---- deflate: 9(0.00%) 0ms
    order0_RLE: 7 (0.00%) 10ms ---- deflate: 9(0.00%) 0ms
    order1_RLE: 8 (0.00%) 11ms ---- deflate: 10(0.00%) 0ms
    order2_RLE: 8 (0.00%) 14ms ---- deflate: 10(0.00%) 0ms
    order1: 200002 (50.00%) 20ms ---- deflate: 215(0.05%) 1ms
    order2: 200002 (50.00%) 22ms ---- deflate: 216(0.05%) 1ms
    plain: 400001 (100.00%) 17ms ---- deflate: 409(0.10%) 2ms

    Best: order0_RLE_UNSIGNED,order0_RLE
    Fast: order0_RLE_UNSIGNED

✖ random array for small number(10, 100):

    plain: 200001 (100.00%) 15ms ---- deflate: 164857(82.43%) 7ms
    order0_RLE_UNSIGNED: 200001 (100.00%) 17ms ---- deflate: 164863(82.43%) 7ms
    order0_RLE: 200001 (100.00%) 20ms ---- deflate: 164862(82.43%) 6ms
    order1: 216776 (108.39%) 18ms ---- deflate: 191017(95.51%) 8ms
    order1_RLE: 217426 (108.71%) 24ms ---- deflate: 191326(95.66%) 10ms
    order2: 269804 (134.90%) 37ms ---- deflate: 229941(114.97%) 19ms
    order2_RLE: 270659 (135.33%) 22ms ---- deflate: 230224(115.11%) 15ms

    Best: plain,order0_RLE_UNSIGNED,order0_RLE
    Fast: plain

✖ random array for big number(100k, 100.1k):

    order1: 226171 (37.70%) 20ms ---- deflate: 199117(33.19%) 12ms
    order1_RLE: 226875 (37.81%) 21ms ---- deflate: 199440(33.24%) 11ms
    order2: 280810 (46.80%) 21ms ---- deflate: 237027(39.50%) 25ms
    order2_RLE: 281604 (46.93%) 30ms ---- deflate: 237234(39.54%) 22ms
    plain: 600001 (100.00%) 17ms ---- deflate: 225401(37.57%) 82ms
    order0_RLE: 600001 (100.00%) 21ms ---- deflate: 225882(37.65%) 88ms
    order0_RLE_UNSIGNED: 600001 (100.00%) 25ms ---- deflate: 225882(37.65%) 87ms

    Best: order1
    Fast: plain

random array for big number(100k, 1001k):

    order1: 375322 (62.55%) 17ms ---- deflate: 315683(52.61%) 19ms
    order1_RLE: 375509 (62.58%) 22ms ---- deflate: 315730(52.62%) 18ms
    order2: 387331 (64.56%) 22ms ---- deflate: 336148(56.02%) 16ms
    order2_RLE: 387432 (64.57%) 26ms ---- deflate: 336176(56.03%) 17ms
    plain: 600001 (100.00%) 19ms ---- deflate: 328831(54.81%) 47ms
    order0_RLE: 600001 (100.00%) 19ms ---- deflate: 328849(54.81%) 46ms
    order0_RLE_UNSIGNED: 600001 (100.00%) 21ms ---- deflate: 328849(54.81%) 49ms

    Best: order1
    Fast: order1

✖ pure random array for big number(1, 100k):

    plain: 596625 (100.00%) 17ms ---- deflate: 571504(95.79%) 20ms
    order0_RLE: 596626 (100.00%) 19ms ---- deflate: 571461(95.78%) 19ms
    order0_RLE_UNSIGNED: 596626 (100.00%) 19ms ---- deflate: 571462(95.78%) 19ms
    order1: 596726 (100.02%) 22ms ---- deflate: 587576(98.48%) 22ms
    order1_RLE: 596726 (100.02%) 29ms ---- deflate: 587566(98.48%) 22ms
    order2: 626978 (105.09%) 25ms ---- deflate: 613046(102.75%) 22ms
    order2_RLE: 626979 (105.09%) 27ms ---- deflate: 613038(102.75%) 25ms

    Best: plain
    Fast: plain

random increacing timestamp:

    order1_RLE: 309089 (25.76%) 116ms ---- deflate: 58019(4.83%) 23ms
    order2_RLE: 318484 (26.54%) 100ms ---- deflate: 62185(5.18%) 29ms
    order2: 325004 (27.08%) 98ms ---- deflate: 60667(5.06%) 27ms
    order1: 349936 (29.16%) 84ms ---- deflate: 55887(4.66%) 28ms
    order0_RLE_UNSIGNED: 1157139 (96.43%) 2498ms ---- deflate: 372534(31.04%) 72ms
    order0_RLE: 1157139 (96.43%) 2510ms ---- deflate: 372534(31.04%) 68ms
    plain: 1200001 (100.00%) 2571ms ---- deflate: 366588(30.55%) 77ms

    Best: order1_RLE
    Fast: order1

random increacing integers by 0...10 from 0:

    order1_RLE: 199800 (33.48%) 35ms ---- deflate: 98090(16.44%) 17ms
    order2_RLE: 199955 (33.51%) 39ms ---- deflate: 109991(18.43%) 10ms
    order1: 200001 (33.52%) 35ms ---- deflate: 98012(16.43%) 15ms
    order2: 200001 (33.52%) 38ms ---- deflate: 109953(18.43%) 10ms
    order0_RLE_UNSIGNED: 596609 (99.98%) 38ms ---- deflate: 430284(72.11%) 22ms
    order0_RLE: 596609 (99.98%) 51ms ---- deflate: 430284(72.11%) 22ms
    plain: 596722 (100.00%) 38ms ---- deflate: 430235(72.10%) 24ms

    Best: order1_RLE
    Fast: order1_RLE,order1

random increacing integers by 0...3 from 0:

    order1_RLE: 194722 (33.06%) 38ms ---- deflate: 59602(10.12%) 39ms
    order2_RLE: 198315 (33.67%) 45ms ---- deflate: 65916(11.19%) 39ms
    order1: 200001 (33.95%) 36ms ---- deflate: 58714(9.97%) 47ms
    order2: 200001 (33.95%) 41ms ---- deflate: 65676(11.15%) 35ms
    order0_RLE_UNSIGNED: 582974 (98.97%) 41ms ---- deflate: 352004(59.76%) 21ms
    order0_RLE: 582974 (98.97%) 45ms ---- deflate: 352003(59.76%) 22ms
    plain: 589043 (100.00%) 40ms ---- deflate: 350078(59.43%) 24ms

    Best: order1_RLE
    Fast: order1

slowly changed integers:

    order1_RLE: 122552 (30.51%) 27ms ---- deflate: 48749(12.14%) 19ms
    order2_RLE: 144159 (35.89%) 35ms ---- deflate: 53822(13.40%) 20ms
    order0_RLE_UNSIGNED: 144937 (36.08%) 20ms ---- deflate: 79168(19.71%) 10ms
    order0_RLE: 144937 (36.08%) 21ms ---- deflate: 79168(19.71%) 8ms
    order1: 200003 (49.79%) 32ms ---- deflate: 49333(12.28%) 19ms
    order2: 200003 (49.79%) 39ms ---- deflate: 54950(13.68%) 17ms
    plain: 401690 (100.00%) 35ms ---- deflate: 74242(18.48%) 12ms

    Best: order1_RLE
    Fast: order0_RLE_UNSIGNED

    order0_RLE: 300479 (100.25%) 38ms ---- deflate: 243737(81.32%) 21ms
    order0_RLE_UNSIGNED: 300479 (100.25%) 45ms ---- deflate: 243738(81.32%) 24ms
    order1: 312323 (104.20%) 34ms ---- deflate: 261009(87.08%) 23ms
    order1_RLE: 312936 (104.41%) 48ms ---- deflate: 261195(87.15%) 18ms
    order2: 350311 (116.88%) 43ms ---- deflate: 285913(95.39%) 26ms
    order2_RLE: 350719 (117.02%) 48ms ---- deflate: 286009(95.43%) 26ms

    Best: plain
    Fast: plain

Enums in small range:

    order0_RLE_UNSIGNED: 186092 (93.05%) 33ms ---- deflate: 49652(24.83%) 34ms
    order0_RLE: 186092 (93.05%) 36ms ---- deflate: 49652(24.83%) 30ms
    order1_RLE: 193486 (96.74%) 35ms ---- deflate: 53551(26.78%) 31ms
    order2_RLE: 196868 (98.43%) 39ms ---- deflate: 58468(29.23%) 28ms
    order1: 200001 (100.00%) 27ms ---- deflate: 53120(26.56%) 32ms
    plain: 200001 (100.00%) 28ms ---- deflate: 47429(23.71%) 43ms
    order2: 200001 (100.00%) 33ms ---- deflate: 58310(29.15%) 27ms

    Best: order0_RLE_UNSIGNED,order0_RLE
    Fast: order1

high precision sensor data(size 5000):

    order2_RLE: 15000 (69.58%) 1ms ---- deflate: 442(2.05%) 0ms
    order2: 15000 (69.58%) 2ms ---- deflate: 442(2.05%) 0ms
    order1: 19250 (89.29%) 1ms ---- deflate: 625(2.90%) 0ms
    order1_RLE: 19250 (89.29%) 2ms ---- deflate: 625(2.90%) 0ms
    plain: 21558 (100.00%) 1ms ---- deflate: 782(3.63%) 0ms
    order0_RLE_UNSIGNED: 21558 (100.00%) 1ms ---- deflate: 780(3.62%) 0ms
    order0_RLE: 21558 (100.00%) 2ms ---- deflate: 780(3.62%) 0ms

    Best: order2_RLE,order2
    Fast: order2_RLE,order1,plain,order0_RLE_UNSIGNED
