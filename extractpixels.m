function [ img_discrete ] = extractpixels( filename )
%EXTRACTPIXELS Summary of this function goes here

    %% load data
    img = imread(filename);

    % figure;
    % imshow(img)
    % figure
    % imshow(img2)

    %% analyze
    dfx = sum(any(abs(diff(int16(img), 1, 2)) >= 15, 3), 1);
    dfy = sum(any(abs(diff(int16(img), 1, 1)) >= 15, 3), 2);
    [~, locx]= findpeaks(dfx);
    [~, locy]= findpeaks(dfy);

    pksx_remove = dfx(locx) < 40;
    pksy_remove = dfy(locy) < 40;

    locx(pksx_remove) = [];
    locy(pksy_remove) = [];
    locx = unique([1  locx  size(img, 2)]);
    locy = unique([1; locy; size(img, 1)]);

    % figure;
    % subplot(211);hold on;
    % plot(dfx);scatter(locx, dfx(locx));
    % subplot(212);hold on;
    % plot(dfy);scatter(locy, dfy(locx));

    % figure;
    % imshow(img); hold on
    % scatter(locx, ones(size(locx)) * 26,'r')

    mean_dx = median(diff(locx));
    mean_dy = median(diff(locy));

    % check if any missing
    assert(all(abs(diff(locx) - mean_dx) <= 3));
    assert(all(abs(diff(locy) - mean_dy) <= 3));
    % figure;hold all
    % plot(diff(locx));
    % plot(diff(locy));
    % ylim([0 2 * max(mean_dx, mean_dy) + 2]);

    %% find centers between edges
    cx = floor(locx(1:end - 1) + diff(locx) / 2);
    cy = floor(locy(1:end - 1) + diff(locy) / 2);
    Nx = numel(cx);
    Ny = numel(cy);

    %% get center coordinates
    [xx, yy] = meshgrid(cx, cy);

    % figure;
    % imshow(img); hold on;
    % scatter(xx(:), yy(:), 'r');

    %% get colors
    img_median = zeros(size(img), class(img));
    for kk = 1:3
        img_median(:, :,kk) = medfilt2(img(:, :, kk));
    end

    Nxy = numel(xx);
    lin_idx = sub2ind(size(img_median), repmat(yy(:), 3, 1), repmat(xx(:), 3, 1), [ones(Nxy, 1); 2 * ones(Nxy, 1); 3 * ones(Nxy, 1)]);
    % img_discrete = zeros(Nx, Ny, class(img));
    img_discrete = reshape(img_median(lin_idx), [Ny Nx 3]);

end
