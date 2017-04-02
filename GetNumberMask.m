function linidx = GetNumberMask(num, target_size, bigfont)
%GETNUMBERMASK

    if (nargin < 3)
       bigfont = false; 
    end
    if (bigfont)
        switch num
            case 0
                linidx =[[    1 2 3 4 5  ]' + target_size(1) * 4;
                         [  0   2       6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0       4   6]' + target_size(1);
                         [    1 2 3 4 5  ]'];
            case 1
                linidx =[[               ]' + target_size(1) * 4;
                         [               ]' + target_size(1) * 3;
                         [  0 1 2 3 4 5 6]' + target_size(1) * 2;
                         [    1          ]' + target_size(1);
                         [               ]'];
            case 2
                linidx =[[    1 2       6]' + target_size(1) * 4;
                         [  0     3     6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0     3     6]' + target_size(1);
                         [    1     4 5 6]'];
            case 3
                linidx =[[    1 2   4 5  ]' + target_size(1) * 4;
                         [  0     3     6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0           6]' + target_size(1);
                         [    1       5  ]'];
            case 4
                linidx =[[          4    ]' + target_size(1) * 4;
                         [  0 1 2 3 4 5 6]' + target_size(1) * 3;
                         [    1     4    ]' + target_size(1) * 2;
                         [      2   4    ]' + target_size(1);
                         [        3 4    ]'];
            case 5
                linidx =[[  0       4 5  ]' + target_size(1) * 4;
                         [  0     3     6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0     3     6]' + target_size(1);
                         [  0 1 2 3     6]'];
            case 6
                linidx =[[  0       4 5  ]' + target_size(1) * 4;
                         [  0     3     6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0     3     6]' + target_size(1);
                         [    1 2 3 4 5  ]'];
            case 7
                linidx =[[    1 2        ]' + target_size(1) * 4;
                         [  0     3      ]' + target_size(1) * 3;
                         [  0       4    ]' + target_size(1) * 2;
                         [  0         5 6]' + target_size(1);
                         [  0            ]'];
            case 8
                linidx =[[    1 2   4 5  ]' + target_size(1) * 4;
                         [  0     3     6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0     3     6]' + target_size(1);
                         [    1 2   4 5  ]'];
            case 9
                linidx =[[    1 2 3 4 5  ]' + target_size(1) * 4;
                         [  0     3     6]' + target_size(1) * 3;
                         [  0     3     6]' + target_size(1) * 2;
                         [  0     3     6]' + target_size(1);
                         [    1 2        ]'];
        end
    else
        switch num
            case 0
                linidx =[[  0 1 2 3 4]' + target_size(1) * 2;
                         [  0       4]' + target_size(1);
                         [  0 1 2 3 4]'];
            case 1
                linidx =[[           ]' + target_size(1) * 2;
                         [  0 1 2 3 4]' + target_size(1);
                         [           ]'];
            case 2
                linidx =[[  0 1 2   4]' + target_size(1) * 2;
                         [  0   2   4]' + target_size(1);
                         [  0   2 3 4]'];
            case 3
                linidx =[[  0 1 2 3 4]' + target_size(1) * 2;
                         [  0   2   4]' + target_size(1);
                         [  0   2   4]'];
            case 4
                linidx =[[  0 1 2 3 4]' + target_size(1) * 2;
                         [      2    ]' + target_size(1);
                         [  0 1 2    ]'];
            case 5
                linidx =[[  0   2 3 4]' + target_size(1) * 2;
                         [  0   2   4]' + target_size(1);
                         [  0 1 2   4]'];
            case 6
                linidx =[[  0   2 3 4]' + target_size(1) * 2;
                         [  0   2   4]' + target_size(1);
                         [  0 1 2 3 4]'];
            case 7
                linidx =[[  0 1      ]' + target_size(1) * 2;
                         [  0   2 3 4]' + target_size(1);
                         [  0        ]'];
            case 8
                linidx =[[  0 1 2 3 4]' + target_size(1) * 2;
                         [  0   2   4]' + target_size(1);
                         [  0 1 2 3 4]'];
            case 9
                linidx =[[  0 1 2 3 4]' + target_size(1) * 2;
                         [  0   2   4]' + target_size(1);
                         [  0 1 2   4]'];
        end
    end
    if (numel(target_size) == 3)
        xysiz = prod(target_size(1:2));
        N = numel(linidx);
        linidx = [linidx; linidx + ones(N, 1) * xysiz; linidx + ones(N, 1) * 2 * xysiz];
    end
end

