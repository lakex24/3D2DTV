% Convert original stereo images into 3D+ format stereo images
% Input two original left and right images (dimensions must match)
% Output converted left and right images
function [out_L, out_R] = convertStereoPairs(in_L, in_R, notConvert)

% in_L, in_R dimension should match
[l_row l_col l_ch] = size(in_L);
[r_row r_col r_ch] = size(in_R);

if (l_row ~= r_row || l_col ~= r_col || l_ch ~= r_ch)
    disp('ERROR: Left and Right Stereo Images dimensions don''t match!');
end

% Max pixel values for converted stereo images
L_max = 200.0;
R_max = 115.0;

out_R = (R_max / 255.0) * in_R;
% If we only need reduced L + reduced R
if (notConvert)
    out_L = in_L;
    return;
end
out_L = (L_max / 255.0) * in_L;


% zi is the 2D look-up table
% currently, red is used for all 3 channels
load '2d_lut_red.mat' zi;

row = l_row;
col = l_col;
channel = l_ch;

for r = 1:row
    for c = 1:col
        for k = 1:channel
            % Perform conversion on each pixel, each channel
            L_val = out_L(r, c, k);
            R_val = out_R(r, c, k);

            % Find the value to be added to L_pixel in 2D lut
            x_val = zi(int32(R_max - R_val) + 1, L_val + 1);
            out_L(r, c, k) = L_val + x_val;
        end
    end
end