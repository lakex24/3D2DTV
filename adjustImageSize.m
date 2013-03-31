% Adjust image sizes to fit the TV screen
function [out_L out_R] = adjustImageSize(in_L, in_R)

[l_row l_col l_ch] = size(in_L);
[r_row r_col r_ch] = size(in_R);

if (l_row ~= r_row || l_col ~= r_col || l_ch ~= r_ch)
    disp('ERROR: Stereo images'' dimensions don''t match!');
end

% TV Resolution
ROW = 1080;
COL = 1920;
ratio = ROW / COL;

in_ch  = l_ch;
in_row = l_row;
in_col = l_col;
in_ratio = in_row / in_col;

if (in_ratio > ratio)
    % in_row -> ROW
    scale = ROW / in_row;
    new_col = floor(scale * in_col / 2);
    
    space = floor((COL/2 - new_col) / 2);
    
    out_L = zeros(ROW, COL/2, in_ch, 'uint8');
    out_R = zeros(ROW, COL/2, in_ch, 'uint8');
    
    out_L(:, (space + 1):(space + new_col), :) = imresize(in_L, [ROW new_col]);
    out_R(:, (space + 1):(space + new_col), :) = imresize(in_R, [ROW new_col]);
    
elseif (in_ratio < ratio)
    % in_col -> COL
    scale = COL / in_col;
    new_row = floor(scale * in_row);
    
    space = floor((ROW - new_row) / 2);
    
    out_L = zeros(ROW, COL/2, in_ch, 'uint8');
    out_R = zeros(ROW, COL/2, in_ch, 'uint8');
    
    out_L((space + 1):(space + new_row), :, :) = imresize(in_L, [new_row COL/2]);
    out_R((space + 1):(space + new_row), :, :) = imresize(in_R, [new_row COL/2]);
else
    % in_ratio == ratio
    out_L = imresize(in_L, [ROW COL/2]);
    out_R = imresize(in_R, [ROW COL/2]);
end

