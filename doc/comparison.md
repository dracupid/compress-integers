Array Size:  200000

sequence from 0 to ARR_SIZE:

    order1_RLE: 7 (0.00%) 8ms ---- deflate: 9(0.00%) 1ms
    order2_RLE: 8 (0.00%) 12ms ---- deflate: 10(0.00%) 0ms
    order1: 200002 (33.80%) 16ms ---- deflate: 214(0.04%) 1ms
    order2: 200002 (33.80%) 21ms ---- deflate: 214(0.04%) 1ms
    order0_RLE_UNSIGNED: 583494 (98.61%) 20ms ---- deflate: 407148(68.80%) 14ms
    plain: 591748 (100.00%) 24ms ---- deflate: 413740(69.92%) 18ms
    order0_RLE: 591750 (100.00%) 20ms ---- deflate: 413748(69.92%) 17ms

    Best: order1_RLE
    Fast: order1_RLE

repeated sequence for 1000:

    order0_RLE: 7 (0.00%) 9ms ---- deflate: 9(0.00%) 0ms
    order0_RLE_UNSIGNED: 7 (0.00%) 9ms ---- deflate: 9(0.00%) 0ms
    order2_RLE: 8 (0.00%) 9ms ---- deflate: 10(0.00%) 0ms
    order1_RLE: 8 (0.00%) 11ms ---- deflate: 10(0.00%) 0ms
    order1: 200002 (50.00%) 22ms ---- deflate: 215(0.05%) 1ms
    order2: 200002 (50.00%) 24ms ---- deflate: 216(0.05%) 1ms
    plain: 400001 (100.00%) 17ms ---- deflate: 409(0.10%) 2ms

    Best: order0_RLE,order0_RLE_UNSIGNED
    Fast: order0_RLE,order0_RLE_UNSIGNED,order2_RLE

✖ random array for small number(10, 100):

    plain: 200001 (100.00%) 14ms ---- deflate: 164826(82.41%) 8ms
    order0_RLE: 200001 (100.00%) 16ms ---- deflate: 164830(82.41%) 7ms
    order0_RLE_UNSIGNED: 200001 (100.00%) 23ms ---- deflate: 164830(82.41%) 7ms
    order1: 216680 (108.34%) 16ms ---- deflate: 190957(95.48%) 8ms
    order1_RLE: 217331 (108.66%) 22ms ---- deflate: 191267(95.63%) 9ms
    order2: 269647 (134.82%) 22ms ---- deflate: 230046(115.02%) 15ms
    order2_RLE: 270460 (135.23%) 29ms ---- deflate: 230273(115.14%) 16ms

    Best: plain,order0_RLE,order0_RLE_UNSIGNED
    Fast: plain

random array for big number(100k, 100.1k):

    order1: 225812 (37.64%) 18ms ---- deflate: 198913(33.15%) 11ms
    order1_RLE: 226535 (37.76%) 20ms ---- deflate: 199241(33.21%) 9ms
    order2: 280843 (46.81%) 27ms ---- deflate: 237008(39.50%) 19ms
    order2_RLE: 281652 (46.94%) 30ms ---- deflate: 237255(39.54%) 19ms
    order0_RLE: 599994 (100.00%) 19ms ---- deflate: 225921(37.65%) 81ms
    order0_RLE_UNSIGNED: 599994 (100.00%) 19ms ---- deflate: 225921(37.65%) 83ms
    plain: 600001 (100.00%) 22ms ---- deflate: 225369(37.56%) 94ms

    Best: order1
    Fast: order1

random array for big number(100k, 105k):

    order1: 394986 (65.83%) 22ms ---- deflate: 374368(62.39%) 15ms
    order1_RLE: 395025 (65.84%) 25ms ---- deflate: 374348(62.39%) 15ms
    order2: 398929 (66.49%) 22ms ---- deflate: 395105(65.85%) 17ms
    order2_RLE: 398946 (66.49%) 24ms ---- deflate: 395086(65.85%) 14ms
    plain: 600001 (100.00%) 17ms ---- deflate: 400374(66.73%) 30ms
    order0_RLE: 600001 (100.00%) 18ms ---- deflate: 400355(66.73%) 30ms
    order0_RLE_UNSIGNED: 600001 (100.00%) 23ms ---- deflate: 400355(66.73%) 38ms

    Best: order1
    Fast: plain

✖ pure random array for big number(0, 100k):

    order1: 596601 (99.97%) 27ms ---- deflate: 587459(98.44%) 21ms
    order1_RLE: 596602 (99.97%) 22ms ---- deflate: 587472(98.44%) 19ms
    plain: 596764 (100.00%) 18ms ---- deflate: 571493(95.77%) 21ms
    order0_RLE_UNSIGNED: 596764 (100.00%) 19ms ---- deflate: 571460(95.76%) 19ms
    order0_RLE: 596764 (100.00%) 20ms ---- deflate: 571460(95.76%) 19ms
    order2: 626746 (105.02%) 24ms ---- deflate: 612995(102.72%) 22ms
    order2_RLE: 626746 (105.02%) 25ms ---- deflate: 613021(102.72%) 26ms

    Best: order1
    Fast: plain

random increacing timestamp:

    order1_RLE: 309311 (25.78%) 93ms ---- deflate: 58093(4.84%) 24ms
    order2_RLE: 318020 (26.50%) 140ms ---- deflate: 62157(5.18%) 27ms
    order2: 324694 (27.06%) 92ms ---- deflate: 60546(5.05%) 33ms
    order1: 350238 (29.19%) 84ms ---- deflate: 55809(4.65%) 27ms
    order0_RLE: 1156863 (96.41%) 2468ms ---- deflate: 373216(31.10%) 76ms
    order0_RLE_UNSIGNED: 1156863 (96.41%) 2476ms ---- deflate: 373216(31.10%) 76ms
    plain: 1200001 (100.00%) 2453ms ---- deflate: 367212(30.60%) 81ms

    Best: order1_RLE
    Fast: order1

random increacing integers by 0...10 from 0:

    order1_RLE: 199814 (33.48%) 53ms ---- deflate: 98101(16.44%) 19ms
    order2_RLE: 199952 (33.51%) 56ms ---- deflate: 109856(18.41%) 13ms
    order2: 200001 (33.52%) 37ms ---- deflate: 109826(18.40%) 9ms
    order1: 200001 (33.52%) 39ms ---- deflate: 98039(16.43%) 16ms
    order0_RLE_UNSIGNED: 596593 (99.98%) 44ms ---- deflate: 430394(72.12%) 22ms
    order0_RLE: 596593 (99.98%) 49ms ---- deflate: 430393(72.12%) 26ms
    plain: 596742 (100.00%) 34ms ---- deflate: 430363(72.12%) 27ms

    Best: order1_RLE
    Fast: plain

random increacing integers by 0...3 from 0:

    order1_RLE: 194735 (33.06%) 48ms ---- deflate: 59553(10.11%) 51ms
    order2_RLE: 198315 (33.66%) 43ms ---- deflate: 65929(11.19%) 41ms
    order2: 200001 (33.95%) 33ms ---- deflate: 65656(11.15%) 39ms
    order1: 200001 (33.95%) 39ms ---- deflate: 58649(9.96%) 41ms
    order0_RLE_UNSIGNED: 583700 (99.08%) 46ms ---- deflate: 352718(59.87%) 22ms
    order0_RLE: 583700 (99.08%) 49ms ---- deflate: 352718(59.87%) 26ms
    plain: 589092 (100.00%) 44ms ---- deflate: 351198(59.62%) 21ms

    Best: order1_RLE
    Fast: order2

slowly changed integers:

    order1_RLE: 122976 (26.68%) 28ms ---- deflate: 48891(10.61%) 20ms
    order2_RLE: 144595 (31.38%) 37ms ---- deflate: 54102(11.74%) 16ms
    order0_RLE: 159437 (34.60%) 31ms ---- deflate: 80350(17.44%) 10ms
    order0_RLE_UNSIGNED: 159437 (34.60%) 31ms ---- deflate: 80350(17.44%) 9ms
    order1: 200005 (43.40%) 32ms ---- deflate: 49459(10.73%) 21ms
    order2: 200005 (43.40%) 38ms ---- deflate: 55148(11.97%) 21ms
    plain: 460845 (100.00%) 35ms ---- deflate: 76255(16.55%) 12ms

    Best: order1_RLE
    Fast: order1_RLE

✖ Enums in large range:

    plain: 300072 (100.00%) 32ms ---- deflate: 243255(81.07%) 21ms
    order0_RLE_UNSIGNED: 300846 (100.26%) 41ms ---- deflate: 243848(81.26%) 21ms
    order0_RLE: 300846 (100.26%) 42ms ---- deflate: 243848(81.26%) 22ms
    order1: 312110 (104.01%) 34ms ---- deflate: 260849(86.93%) 20ms
    order1_RLE: 312699 (104.21%) 47ms ---- deflate: 260966(86.97%) 21ms
    order2: 350328 (116.75%) 40ms ---- deflate: 286081(95.34%) 23ms
    order2_RLE: 350722 (116.88%) 55ms ---- deflate: 286142(95.36%) 22ms

    Best: plain
    Fast: plain

✖ Enums in small range:

    order0_RLE_UNSIGNED: 185975 (92.99%) 42ms ---- deflate: 49557(24.78%) 40ms
    order0_RLE: 185975 (92.99%) 47ms ---- deflate: 49557(24.78%) 34ms
    order1_RLE: 193363 (96.68%) 41ms ---- deflate: 53554(26.78%) 30ms
    order2_RLE: 196786 (98.39%) 50ms ---- deflate: 58489(29.24%) 25ms
    plain: 200001 (100.00%) 32ms ---- deflate: 47352(23.68%) 41ms
    order1: 200001 (100.00%) 33ms ---- deflate: 53111(26.56%) 35ms
    order2: 200001 (100.00%) 37ms ---- deflate: 58317(29.16%) 25ms

    Best: order0_RLE_UNSIGNED,order0_RLE
    Fast: plain

high precision sensor data:

    order2_RLE: 15000 (69.58%) 2ms ---- deflate: 442(2.05%) 0ms
    order2: 15000 (69.58%) 2ms ---- deflate: 442(2.05%) 0ms
    order1_RLE: 19250 (89.29%) 1ms ---- deflate: 625(2.90%) 0ms
    order1: 19250 (89.29%) 1ms ---- deflate: 625(2.90%) 0ms
    plain: 21558 (100.00%) 1ms ---- deflate: 782(3.63%) 1ms
    order0_RLE: 21558 (100.00%) 1ms ---- deflate: 780(3.62%) 1ms
    order0_RLE_UNSIGNED: 21558 (100.00%) 3ms ---- deflate: 780(3.62%) 0ms

    Best: order2_RLE,order2
    Fast: order1_RLE,order1,plain,order0_RLE
