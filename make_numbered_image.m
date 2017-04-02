function [ img_final ] = make_numbered_image(img, mask, startcoor, only_number_mask)
%MAKE_NUMBERED_IMAGE
    
    big = false;
    if (big)
        cell_size = 33;
    else
        cell_size = 20;
    end
    img_final = imresize(img, cell_size, 'nearest');
    img_siz = size(img_final);
    [Ny, Nx, ~] = size(img);

    % draw divider = dotted line
    xx = (1:Nx) * cell_size;
    yy = 1:2:img_siz(1);
    cc = 1:3;
    [xx, yy, cc] = meshgrid(xx, yy, cc);
    xlinidx = sub2ind(img_siz, yy, xx, cc);
    img_final(xlinidx) = 0;
    xx = (1:Nx) * cell_size;
    yy = 2:2:img_siz(1);
    cc = 1:3;
    [xx, yy, cc] = meshgrid(xx, yy, cc);
    xlinidx = sub2ind(img_siz, yy, xx, cc);
    img_final(xlinidx) = 255;

    yy = (1:Ny) * cell_size;
    xx = 1:2:img_siz(2);
    cc = 1:3;
    [xx, yy, cc] = meshgrid(xx, yy, cc);
    xlinidx = sub2ind(img_siz, yy, xx, cc);
    img_final(xlinidx) = 0;
    yy = (1:Ny) * cell_size;
    xx = 2:2:img_siz(2);
    cc = 1:3;
    [xx, yy, cc] = meshgrid(xx, yy, cc);
    xlinidx = sub2ind(img_siz, yy, xx, cc);
    img_final(xlinidx) = 255;

    %% numbers
    mask_siz = img_siz(1:2);
    nummask = false(mask_siz);
    rowoffset = mask_siz(1);
    if (big)
       num1_offset = -13;
       num2_offset = -6;
       num3_offset = 2;
       num4_offset = 9;
       num_width = 8;
    else
       num1_offset = -8;
       num2_offset = -4;
       num3_offset = 2;
       num4_offset = 6;
       num_width = 5;
    end
    for xx = 1:Nx
        for yy = 1:Ny
            if (mask(yy, xx) || ~only_number_mask)
                cx = floor((xx - 0.5) * cell_size );
                cy = floor((yy - 0.5) * cell_size + 1);
                cidx = sub2ind(mask_siz, cy, cx) - 4;

                assert(all(cidx + (num_width + 1) * rowoffset + GetNumberMask(mod(yy, 10), mask_siz) < numel(nummask)));
                assert(size(nummask, 1 ) > 1);

                numx = startcoor(1) + xx - 1;
                numy = startcoor(2) + yy - 1;
                nummask(cidx + num1_offset * rowoffset + GetNumberMask(floor(numx / 10),    mask_siz, big)) = true;
                nummask(cidx + num2_offset * rowoffset + GetNumberMask(mod(numx, 10),       mask_siz, big)) = true;
                nummask(cidx + num3_offset * rowoffset + GetNumberMask(floor(numy / 10),    mask_siz, big)) = true;
                nummask(cidx + num4_offset * rowoffset + GetNumberMask(mod(numy, 10),       mask_siz, big)) = true;

                % the comma
                nummask(cidx + 4 + [0 1]) = true;
            end
        end
    end
    
    %% mark pixels in mask
    [x,y] = find(mask);
    for ii = 1:numel(x);
        left = cell_size * (x(ii) - 1);
        right = left + cell_size;
        top = cell_size * (y(ii) - 1);
        bottom = top + cell_size;
        if (left == 0)
            left = 1;
        end
        if (bottom == 0)
            bottom = 1;
        end

        hori_newclr = uint8(ones(right - left + 1, 1) * [255 0 0]);
        vert_newclr = uint8(ones(bottom - top + 1, 1) * [255 0 0]);
        img_final(left, top:bottom, :)      = vert_newclr;
        img_final(right, top:bottom, :)     = vert_newclr;
        img_final(left:right, bottom, :)    = hori_newclr;
        img_final(left:right, top, :)   	= hori_newclr;
        
        %% extra (inner/thicker) border
        left = left + 1;
        right = right - 1;
        top = top + 1;
        bottom = bottom - 1;

        hori_newclr = uint8(ones(right - left + 1, 1) * [255 0 0]);
        vert_newclr = uint8(ones(bottom - top + 1, 1) * [255 0 0]);
        img_final(left, top:bottom, :)      = vert_newclr;
        img_final(right, top:bottom, :)     = vert_newclr;
        img_final(left:right, bottom, :)    = hori_newclr;
        img_final(left:right, top, :)   	= hori_newclr;
    end

    % invert color
    nummask = repmat(nummask, [1 1 3]);
    img_final(nummask) = uint8(255) - img_final(nummask);
    
end

